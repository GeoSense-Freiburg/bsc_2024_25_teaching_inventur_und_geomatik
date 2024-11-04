library(stringr)
library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(leaflet)
library(RColorBrewer)
library(geosphere)
library(sf)  # for handling spatial data
library(leaflet.extras)  # for advanced leaflet features
library(markdown)

# Function to read all CSV files from a folder
read_all_csv <- function(folder_path) {
  csv_files <- list.files(folder_path, pattern = "\\.csv$", full.names = TRUE)
  data_list <- lapply(csv_files, function(file) {
    read_csv(file, quote = "\"") %>%
      mutate(across(where(is.character), ~ str_remove_all(., "^\"|\"$")))
  })
  combined_data <- bind_rows(data_list)
  combined_data
}

# Function to read all GPX files from a folder
read_all_gpx <- function(folder_path) {
  gpx_files <- list.files(folder_path, pattern = "\\.gpx$", full.names = TRUE)
  gpx_list <- lapply(gpx_files, function(file) {
    st_read(file, layer = "tracks")
  })
  combined_gpx <- do.call(rbind, gpx_list)
  combined_gpx
}

# Load data from the specified folder when the app starts
folder_path <- "field-data"  # Change this to your folder path
data <- read_all_csv(folder_path)
gpx_data <- read_all_gpx(folder_path)

# Filter out points more than 15m away from their respective centroid
centroid_data <- data %>%
  group_by(Title) %>%
  summarise(centroid_lat = mean(Latitude), centroid_lon = mean(Longitude))
data_with_centroids <- data %>%
  left_join(centroid_data, by = "Title") %>%
  rowwise() %>%
  mutate(distance_to_centroid = distGeo(c(Longitude, Latitude), c(centroid_lon, centroid_lat)))
filtered_data <- data_with_centroids %>%
  filter(distance_to_centroid <= 15)

# Define UI
ui <- fluidPage(
  titlePanel("Aftermath to Exercise 03_gnss"),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Instructions", 
               includeMarkdown("instructions.md")),
      #tabPanel("Table View", dataTableOutput("data_table")),
      tabPanel("GPS Precision Plot", plotOutput("data_plot")),
      tabPanel("Sky Cover Map", leafletOutput("data_map")),
      tabPanel("Name Map", leafletOutput("name_map")),
      tabPanel("Sky Cover vs Distance Plot", plotOutput("trendline_plot")),
      tabPanel("GPX Tracks", leafletOutput("gpx_map"))
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Display combined CSV data as a table
  output$data_table <- renderDataTable({
    filtered_data
  })
  
  # GPS Precision Plot based on sky cover
  output$data_plot <- renderPlot({
    ggplot(filtered_data, aes(x = Longitude, y = Latitude, color = as.numeric(Description) * 10)) +
      geom_point(size = 3) +
      scale_color_gradient(low = "blue", high = "red") +
      theme_minimal() +
      labs(title = "GPS Precision vs Sky Cover", color = "Sky Cover (%)", x = "Longitude", y = "Latitude")
  })
  
  # Sky Cover Map
  output$data_map <- renderLeaflet({
    leaflet(filtered_data) %>%
      addTiles(options = tileOptions(maxZoom = 22)) %>%
      addCircleMarkers(~Longitude, ~Latitude,
                       color = ~colorNumeric("YlOrRd", as.numeric(Description) * 10)(as.numeric(Description) * 10),
                       popup = ~paste("Title:", Title, "<br>", "Sky Cover:", as.numeric(Description) * 10, "%")) %>%
      addLegend("bottomright", pal = colorNumeric("YlOrRd", as.numeric(filtered_data$Description) * 10),
                values = as.numeric(filtered_data$Description) * 10,
                title = "Sky Cover (%)",
                opacity = 1) %>%
      addScaleBar(position = "bottomleft", options = scaleBarOptions(maxWidth = 100, metric = TRUE, imperial = FALSE))
  })
  
  # Name Map with unique color for each Title
  output$name_map <- renderLeaflet({
    color_palette <- colorFactor(palette = brewer.pal(n = 8, "Set1"), 
                                 domain = filtered_data$Title)
    leaflet(filtered_data) %>%
      addTiles(options = tileOptions(maxZoom = 22)) %>%
      addCircleMarkers(
        ~Longitude, ~Latitude,
        color = ~color_palette(Title),
        popup = ~paste("Title:", Title),
        radius = 6
      ) %>%
      addLegend("bottomright", pal = color_palette, values = filtered_data$Title,
                title = "Point Name", opacity = 1) %>%
      addScaleBar(position = "bottomleft", options = scaleBarOptions(maxWidth = 100, metric = TRUE, imperial = FALSE))
  })
  
  # Sky Cover vs Distance to Centroid Plot
  output$trendline_plot <- renderPlot({
    variance_data <- filtered_data %>%
      group_by(Title) %>%
      summarise(
        avg_sky_cover = mean(as.numeric(Description) * 10, na.rm = TRUE),
        avg_distance = mean(distance_to_centroid, na.rm = TRUE)
      )
    ggplot(variance_data, aes(x = avg_sky_cover, y = avg_distance, label = Title)) +
      geom_point(color = "blue", size = 3) +
      geom_text(vjust = -1, hjust = 1) +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      annotate("text", 
               x = max(variance_data$avg_sky_cover), 
               y = max(variance_data$avg_distance),
               label = paste("r =", 
                             round(cor.test(variance_data$avg_distance, variance_data$avg_sky_cover, method="pearson")$estimate, 2)), 
               hjust = 2, 
               vjust = 2, 
               color = "black") +
      theme_minimal() +
      labs(title = "Average Distance to Centroid vs Sky Cover", x = "Average Sky Cover (%)", y = "Average Distance (m)")
  })
  
  # GPX Tracks Map
  output$gpx_map <- renderLeaflet({
    leaflet() %>%
      addTiles(options = tileOptions(maxZoom = 22)) %>%
      addPolylines(data = gpx_data, color = "blue", weight = 2, opacity = 0.7) %>%
      addLegend(position = "bottomright", colors = "blue", labels = "GPX Tracks", opacity = 0.7) %>%
      addScaleBar(position = "bottomleft", options = scaleBarOptions(maxWidth = 100, metric = TRUE, imperial = FALSE))
  })
}



# Run the application
shinyApp(ui = ui, server = server)

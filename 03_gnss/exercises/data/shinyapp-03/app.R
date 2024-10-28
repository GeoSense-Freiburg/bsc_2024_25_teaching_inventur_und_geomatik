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

# Initialize reactive values for uploaded data
uploaded_data <- reactiveValues(data = NULL, files = character(), gpx_data = NULL, gpx_files = character())

# Define UI
ui <- fluidPage(
  titlePanel("Aftermath to Exercise 03_gnss"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file_upload", "Upload CSV File", accept = ".csv"),
      fileInput("gpx_upload", "Upload GPX File", accept = ".gpx"),
      textOutput("upload_status")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Instructions", 
                 includeMarkdown("instructions.md")),
        tabPanel("Table View", dataTableOutput("data_table")),
        tabPanel("GPS Precision Plot", plotOutput("data_plot")),
        tabPanel("Sky Cover Map", leafletOutput("data_map")),
        tabPanel("Name Map", leafletOutput("name_map")),
        tabPanel("Sky Cover vs Distance Plot", plotOutput("trendline_plot")),
        tabPanel("GPX Tracks", leafletOutput("gpx_map"))
      )
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Handle CSV file upload with quality check
  observeEvent(input$file_upload, {
    file <- input$file_upload
    if (!is.null(file)) {
      
      # Load the CSV with consideration for quotes and cleanup of quotes if needed
      new_data <- read_csv(file$datapath, quote = "\"") %>%
        mutate(across(where(is.character), ~ str_remove_all(., "^\"|\"$")))
      
      # Check for required columns and validate data
      if (all(c("Title", "Description", "Latitude", "Longitude") %in% colnames(new_data))) {
        if (all(grepl("^[A-Z]$", new_data$Title)) &&
            all(!is.na(new_data$Description)) &&
            all(as.numeric(new_data$Description) >= 1 & as.numeric(new_data$Description) <= 10)) {
          if (is.null(uploaded_data$data)) {
            uploaded_data$data <- new_data
          } else {
            uploaded_data$data <- bind_rows(uploaded_data$data, new_data)
          }
          uploaded_data$files <- c(uploaded_data$files, file$name)
          output$upload_status <- renderText("CSV file uploaded successfully!")
        } else {
          output$upload_status <- renderText("CSV validation failed: Title must be A-Z, Description must be 0-10, and no missing values in Description.")
        }
      } else {
        output$upload_status <- renderText("CSV format incorrect. Required columns missing.")
      }
    }
  })
  
  # Handle GPX file upload
  observeEvent(input$gpx_upload, {
    file <- input$gpx_upload
    if (!is.null(file)) {
      new_gpx <- st_read(file$datapath, layer = "tracks", quiet = TRUE)
      if (is.null(uploaded_data$gpx_data)) {
        uploaded_data$gpx_data <- new_gpx
      } else {
        uploaded_data$gpx_data <- rbind(uploaded_data$gpx_data, new_gpx)
      }
      uploaded_data$gpx_files <- c(uploaded_data$gpx_files, file$name)
      output$upload_status <- renderText("GPX file uploaded successfully!")
    }
  })
  
  # Display combined CSV data as a table
  output$data_table <- renderDataTable({
    req(uploaded_data$data)
    uploaded_data$data
  })
  
  # GPS Precision Plot based on sky cover
  output$data_plot <- renderPlot({
    req(uploaded_data$data)
    ggplot(uploaded_data$data, aes(x = Longitude, y = Latitude, color = as.numeric(Description) * 10)) +
      geom_point(size = 3) +
      scale_color_gradient(low = "blue", high = "red") +
      theme_minimal() +
      labs(title = "GPS Precision vs Sky Cover", color = "Sky Cover (%)", x = "Longitude", y = "Latitude")
  })
  
  # Sky Cover Map
  output$data_map <- renderLeaflet({
    req(uploaded_data$data)
    leaflet(uploaded_data$data) %>%
      addTiles(options = tileOptions(maxZoom = 22)) %>%
      addCircleMarkers(~Longitude, ~Latitude,
                       color = ~colorNumeric("YlOrRd", as.numeric(Description) * 10)(as.numeric(Description) * 10),
                       popup = ~paste("Title:", Title, "<br>", "Sky Cover:", as.numeric(Description) * 10, "%")) %>%
      addLegend("bottomright", pal = colorNumeric("YlOrRd", as.numeric(uploaded_data$data$Description) * 10),
                values = as.numeric(uploaded_data$data$Description) * 10,
                title = "Sky Cover (%)",
                opacity = 1)
  })
  
  # Name Map with unique color for each Title
  output$name_map <- renderLeaflet({
    req(uploaded_data$data)
    color_palette <- colorFactor(palette = brewer.pal(n = 8, "Set1"), 
                                 domain = uploaded_data$data$Title)
    leaflet(uploaded_data$data) %>%
      addTiles(options = tileOptions(maxZoom = 22)) %>%
      addCircleMarkers(
        ~Longitude, ~Latitude,
        color = ~color_palette(Title),
        popup = ~paste("Title:", Title),
        radius = 6
      ) %>%
      addLegend("bottomright", pal = color_palette, values = uploaded_data$data$Title,
                title = "Point Name", opacity = 1)
  })
  
  # Sky Cover vs Distance to Centroid Plot
  output$trendline_plot <- renderPlot({
    req(uploaded_data$data)
    centroid_data <- uploaded_data$data %>%
      group_by(Title) %>%
      summarise(centroid_lat = mean(Latitude), centroid_lon = mean(Longitude))
    data_with_centroids <- uploaded_data$data %>%
      left_join(centroid_data, by = "Title") %>%
      rowwise() %>%
      mutate(distance_to_centroid = distGeo(c(Longitude, Latitude), c(centroid_lon, centroid_lat)))
    variance_data <- data_with_centroids %>%
      group_by(Title) %>%
      summarise(
        avg_sky_cover = mean(as.numeric(Description) * 10, na.rm = TRUE),
        avg_distance = mean(distance_to_centroid, na.rm = TRUE)
      )
    ggplot(variance_data, aes(x = avg_sky_cover, y = avg_distance)) +
      geom_point(color = "blue", size = 3) +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      theme_minimal() +
      labs(title = "Average Distance to Centroid vs Sky Cover", x = "Sky Cover (%)", y = "Average Distance (m)")
  })
  
  # GPX Tracks Map
  output$gpx_map <- renderLeaflet({
    req(uploaded_data$gpx_data)
    leaflet() %>%
      addTiles(options = tileOptions(maxZoom = 22)) %>%
      addPolylines(data = uploaded_data$gpx_data, color = "blue", weight = 2, opacity = 0.7) %>%
      addLegend(position = "bottomright", colors = "blue", labels = "GPX Tracks", opacity = 0.7)
  })
}

# Run the application
shinyApp(ui = ui, server = server)

# run the application on shinyapps.io:
# rsconnect::deployApp('app.R')
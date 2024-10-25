# Load necessary libraries
library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(leaflet)
library(RColorBrewer)
library(geosphere)

# Initialize a list to store uploaded files and data
uploaded_data <- reactiveValues(data = NULL, files = character())

# Define UI
ui <- fluidPage(
  titlePanel("Aftermath to Exercise 03_gnss"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file_upload", "Upload CSV File", accept = ".csv"),
      actionButton("undo_upload", "Undo Last Upload"),
      textOutput("upload_status")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Table View", dataTableOutput("data_table")),
        tabPanel("GPS Precision Plot", plotOutput("data_plot")),
        tabPanel("Sky Cover Map", leafletOutput("data_map")),
        tabPanel("Name Map", leafletOutput("name_map")),
        tabPanel("Sky Cover vs Distance Plot", plotOutput("trendline_plot"))
      )
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Function to handle file upload with quality check
  observeEvent(input$file_upload, {
    file <- input$file_upload
    
    # Check if the file is already uploaded
    if (!is.null(file) && !(file$name %in% uploaded_data$files)) {
      
      # Read the CSV file
      new_data <- read_csv(file$datapath)
      
      # Verify columns exist and data quality
      if (all(c("Title", "Description", "Latitude", "Longitude") %in% colnames(new_data))) {
        # Check Title only has letters A-Z, Description has numbers 1-10
        if (all(grepl("^[A-Z]$", new_data$Title)) &&
            all(as.numeric(new_data$Description) >= 1 & as.numeric(new_data$Description) <= 10)) {
          
          # Add new data if it passes checks
          if (is.null(uploaded_data$data)) {
            uploaded_data$data <- new_data
          } else {
            uploaded_data$data <- bind_rows(uploaded_data$data, new_data)
          }
          
          # Record the filename
          uploaded_data$files <- c(uploaded_data$files, file$name)
          output$upload_status <- renderText("File uploaded successfully!")
        } else {
          output$upload_status <- renderText("Data validation failed: Title must be A-Z and Description 1-10.")
        }
      } else {
        output$upload_status <- renderText("File format incorrect. Required columns missing.")
      }
      
    } else {
      # Notify about duplicate file
      output$upload_status <- renderText("This file has already been uploaded.")
    }
  })
  
  # Undo last upload
  observeEvent(input$undo_upload, {
    if (length(uploaded_data$files) > 0) {
      # Remove the last file from uploaded files
      uploaded_data$files <- uploaded_data$files[-length(uploaded_data$files)]
      
      # Reload data excluding the last upload
      if (length(uploaded_data$files) > 0) {
        all_data <- lapply(uploaded_data$files, read_csv)
        uploaded_data$data <- bind_rows(all_data)
      } else {
        uploaded_data$data <- NULL
      }
      
      output$upload_status <- renderText("Last upload undone.")
    } else {
      output$upload_status <- renderText("No uploads to undo.")
    }
  })
  
  # Display combined data as a table
  output$data_table <- renderDataTable({
    uploaded_data$data
  })
  
  # Create a GPS precision plot based on sky cover
  output$data_plot <- renderPlot({
    req(uploaded_data$data)
    ggplot(uploaded_data$data, aes(x = Longitude, y = Latitude, color = as.numeric(Description) * 10)) +
      geom_point(size = 3) +
      scale_color_gradient(low = "blue", high = "red") +
      theme_minimal() +
      labs(title = "GPS Precision vs Sky Cover", color = "Sky Cover (%)", x = "Longitude", y = "Latitude")
  })
  
  # Create an interactive sky cover map
  output$data_map <- renderLeaflet({
    req(uploaded_data$data)
    leaflet(uploaded_data$data) %>%
      addTiles() %>%
      addCircleMarkers(~Longitude, ~Latitude,
                       color = ~colorNumeric("YlOrRd", as.numeric(Description) * 10)(as.numeric(Description) * 10),
                       popup = ~paste("Title:", Title, "<br>", "Sky Cover:", as.numeric(Description) * 10, "%")) %>%
      addLegend("bottomright", pal = colorNumeric("YlOrRd", as.numeric(uploaded_data$data$Description) * 10),
                values = as.numeric(uploaded_data$data$Description) * 10,
                title = "Sky Cover (%)",
                opacity = 1)
  })
  
  # Create an interactive map with points displayed by name
  output$name_map <- renderLeaflet({
    req(uploaded_data$data)
    
    # Generate color palette for each unique Title
    color_palette <- colorFactor(palette = brewer.pal(n = length(unique(uploaded_data$data$Title)), "Set1"), 
                                 domain = uploaded_data$data$Title)
    
    leaflet(uploaded_data$data) %>%
      addTiles() %>%
      addCircleMarkers(
        ~Longitude, ~Latitude,
        color = ~color_palette(Title),
        popup = ~paste("Title:", Title),
        radius = 6
      ) %>%
      addLegend("bottomright", pal = color_palette, values = uploaded_data$data$Title,
                title = "Point Name", opacity = 1)
  })
  
  # Generate a trendline plot: Sky Cover vs Average Distance to Centroid
  output$trendline_plot <- renderPlot({
    req(uploaded_data$data)
    
    # Calculate centroids and average distances
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
    
    # Plot the trendline of sky cover vs distance
    ggplot(variance_data, aes(x = avg_sky_cover, y = avg_distance)) +
      geom_point(color = "blue", size = 3) +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      theme_minimal() +
      labs(title = "Average Distance to Centroid vs Sky Cover", x = "Sky Cover (%)", y = "Average Distance (m)")
  })
}

# Run the application
shinyApp(ui = ui, server = server)

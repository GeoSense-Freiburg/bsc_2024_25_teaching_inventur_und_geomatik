# Application Overview

This Shiny application is designed to process and visualize GPS data from CSV and GPX files. It provides multiple interactive features to analyze and display the data.

**Pay attention to only upload the data once!**

Try to answer the following questions at the end:

- which of the points has the lowest accuracy (from what you see on the maps)?
- Is there a correlation on GNSS accuracy and sky cover? If so, to what extent? If not, why not? What did we forget?
- Which other factors influence the GNSS signal?
- which factors influenced your measurements? Is it consistent?

## Libraries Used
- `stringr`: String manipulation
- `shiny`: Web application framework for R
- `readr`: Reading CSV files
- `dplyr`: Data manipulation
- `ggplot2`: Data visualization
- `leaflet`: Interactive maps
- `RColorBrewer`: Color palettes
- `geosphere`: Geospatial calculations
- `sf`: Handling spatial data
- `leaflet.extras`: Advanced leaflet features

## UI Components
- **Title Panel**: Displays the title of the application.
- **Sidebar Panel**: Contains file input controls for uploading CSV and GPX files and displays upload status.
- **Main Panel**: Contains multiple tabs for different views and visualizations:
    - **Instructions**: Displays instructions from a markdown file.
    - **Table View**: Shows the uploaded CSV data in a table format.
    - **GPS Precision Plot**: Plots GPS precision against sky cover.
    - **Sky Cover Map**: Displays a map with markers colored by sky cover percentage.
    - **Name Map**: Displays a map with markers colored by point names.
    - **Sky Cover vs Distance Plot**: Plots the relationship between sky cover and distance to centroid.
    - **GPX Tracks**: Displays GPX tracks on a map.

## Server Logic
- **CSV File Upload**: Handles CSV file uploads, performs validation, and updates the reactive data store.
- **GPX File Upload**: Handles GPX file uploads and updates the reactive data store.
- **Data Table**: Renders the uploaded CSV data as a table.
- **GPS Precision Plot**: Creates a scatter plot of GPS precision against sky cover.
- **Sky Cover Map**: Generates a leaflet map with markers colored by sky cover percentage.
- **Name Map**: Generates a leaflet map with markers colored by point names.
- **Sky Cover vs Distance Plot**: Plots the average distance to centroid against sky cover.
- **GPX Tracks Map**: Displays GPX tracks on a leaflet map.

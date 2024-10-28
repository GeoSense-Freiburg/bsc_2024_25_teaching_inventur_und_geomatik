library(dplyr)
library(readr)

# Read the example dataset
example_data <- read_csv("/Users/maximilianfabi/Desktop/_repos/bsc_2024_25_teaching_inventur_und_geomatik/04_accuracy_inventory/data/csv-files/03.csv")

# Function to add noise to latitude and longitude
generate_noise <- function(lat, lon, obscurance, max_dist = 10) {
  # Maximum displacement is 10 meters when obscurance is 10 (100% obscurance)
  # Displacement scales linearly with obscurance (in tenths)
  displacement_factor <- (obscurance / 10) * max_dist
  
  # Convert meters to degrees for latitude and longitude
  # Approximation: 1 degree latitude ≈ 111.32 km, 1 degree longitude ≈ 111.32 km * cos(latitude)
  lat_offset <- (displacement_factor / 111320)  # Meters to degrees latitude
  lon_offset <- (displacement_factor / (111320 * cos(lat * pi / 180)))  # Meters to degrees longitude
  
  # Randomly change the sign of the offset (to scatter in all directions)
  lat_new <- lat + runif(1, -lat_offset, lat_offset)
  lon_new <- lon + runif(1, -lon_offset, lon_offset)
  
  return(c(lat_new, lon_new))
}

# Function to generate n versions of the dataset with noisy coordinates
generate_datasets <- function(data, n_files = 5, max_dist = 10) {
  for (i in 1:n_files) {
    # Apply noise to latitude and longitude based on obscurance
    noisy_data <- data %>%
      rowwise() %>%
      mutate(
        new_coords = list(generate_noise(Latitude, Longitude, Description, max_dist)),
        Latitude = new_coords[[1]],
        Longitude = new_coords[[2]]
      ) %>%
      ungroup() %>%
      select(-new_coords)  # Remove the temporary list column
    
    # Write each altered dataset to a new CSV file
    write_csv(noisy_data, paste0("/Users/maximilianfabi/Desktop/_repos/bsc_2024_25_teaching_inventur_und_geomatik/04_accuracy_inventory/data/csv-files/noisy_data_", i, ".csv"))
  }
}

# Generate 5 versions of the dataset with altered GPS coordinates
generate_datasets(example_data, n_files = 5, max_dist = 10)

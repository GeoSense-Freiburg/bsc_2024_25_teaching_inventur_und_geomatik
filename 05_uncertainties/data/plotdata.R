# Summary of the plot data you collected
# first load in the necessary packages
library(ggplot2)

# read in the data
data <- read.csv("data.csv")

# Convert plot_nr and measurement to factors for better plotting
data$plot_nr <- as.factor(data$plot_nr)
data$measurement <- as.factor(data$measurement)

# Boxplot for Basal Area with mean value
boxplot_basal_area <- ggplot(data, aes(x = plot_nr, y = `basal_area_m2_ha`, fill = plot_nr)) +
    geom_boxplot() +
    stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "red", fill = "red") +
    labs(title = "Basal Area by Plot Number", x = "Plot Number", y = "Basal Area (m2/ha)") +
    theme_minimal() +
    scale_fill_discrete(name = "Plot Number", labels = function(x) paste0(x, " (mean: ", round(tapply(data$`basal_area_m2_ha`, data$plot_nr, mean), 2), ")"))

# Boxplot for Volume with mean value
boxplot_volume <- ggplot(data, aes(x = plot_nr, y = `volume_m3`, fill = plot_nr)) +
    geom_boxplot() +
    stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "red", fill = "red") +
    labs(title = "Volume by Plot Number", x = "Plot Number", y = "Volume (m3)") +
    theme_minimal() +
    scale_fill_discrete(name = "Plot Number", labels = function(x) paste0(x, " (mean: ", round(tapply(data$`volume_m3`, data$plot_nr, mean), 2), ")"))

# Boxplot for Angle Count with mean value
# Simple boxplot for Angle Count with mean value
boxplot_angle_count <- ggplot(data, aes(x = plot_nr, y = `angle_count_m2_ha`, fill = plot_nr)) +
    geom_boxplot() +
    stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "red", fill = "red") +
    labs(title = "Angle Count by Plot Number", x = "Plot Number", y = "Angle Count (m2/ha)") +
    theme_minimal()

# Print the boxplots
print(boxplot_basal_area)
print(boxplot_volume)
print(boxplot_angle_count)

# Save the plots as images
ggsave("boxplot_basal_area.png", plot = boxplot_basal_area, width = 8, height = 6, units = "in", dpi = 300)
ggsave("boxplot_volume.png", plot = boxplot_volume, width = 8, height = 6, units = "in", dpi = 300)
ggsave("boxplot_angle_count.png", plot = boxplot_angle_count, width = 8, height = 6, units = "in", dpi = 300)

# Summary statistics
# get the mean, standard deviation, and standard error for the whole dataset
mean_basal_area <- mean(data$`basal_area_m2_ha`, na.rm = TRUE)
sd_basal_area <- sd(data$`basal_area_m2_ha`, na.rm = TRUE)
se_basal_area <- sd_basal_area / sqrt(sum(!is.na(data$`basal_area_m2_ha`)))

mean_volume <- mean(data$`volume_m3`, na.rm = TRUE)
sd_volume <- sd(data$`volume_m3`, na.rm = TRUE)
se_volume <- sd_volume / sqrt(sum(!is.na(data$`volume_m3`)))

mean_angle_count <- mean(data$`angle_count_m2_ha`, na.rm = TRUE)
sd_angle_count <- sd(data$`angle_count_m2_ha`, na.rm = TRUE)
se_angle_count <- sd_angle_count / sqrt(sum(!is.na(data$`angle_count_m2_ha`)))

# Print the summary statistics
cat("Basal Area:\n")
cat("Mean: ", mean_basal_area, "\n")
cat("Standard Deviation: ", sd_basal_area, "\n")
cat("Standard Error: ", se_basal_area, "\n\n")

cat("Volume:\n")
cat("Mean: ", mean_volume, "\n")
cat("Standard Deviation: ", sd_volume, "\n")
cat("Standard Error: ", se_volume, "\n\n")

cat("Angle Count:\n")
cat("Mean: ", mean_angle_count, "\n")
cat("Standard Deviation: ", sd_angle_count, "\n")
cat("Standard Error: ", se_angle_count, "\n")

# plot the summary statistics without Volume
summary_stats <- data.frame(measurement = c("Basal Area", "Angle Count"),
                            mean = c(mean_basal_area, mean_angle_count),
                            sd = c(sd_basal_area, sd_angle_count),
                            se = c(se_basal_area, se_angle_count))

# Create a nicer plot for summary statistics
summary_stats_plot <- ggplot(summary_stats, aes(x = measurement, y = mean, fill = measurement)) +
    geom_bar(stat = "identity", position = "dodge", color = "white", width = 0.6) +
    geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), width = 0.2, position = position_dodge(0.6)) +
    labs(title = "Summary Statistics", x = "Measurement", y = "Mean Value") +
    theme_minimal() +
    scale_fill_manual(values = c("Basal Area" = "skyblue", "Angle Count" = "lightgreen")) +
    theme(legend.position = "none") +
    geom_text(aes(label = round(mean, 2)), vjust = -0.5, color = "black", size = 3.5)

print(summary_stats_plot)
ggsave("boxplot_area_vs.png", plot = summary_stats_plot, width = 8, height = 6, units = "in", dpi = 300)



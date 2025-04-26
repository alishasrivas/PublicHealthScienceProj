  library(dplyr)
  
  Final_Data_WWeather <- Final_Data_WWeather %>%
    mutate(SEASON_GROUP = case_when(
      Season %in% c("Spring", "Summer") ~ "Spring + Summer",
      Season %in% c("Fall", "Winter") ~ "Fall + Winter",
      TRUE ~ Season  # Just in case there's any weird data
    ))
  
  library(ggplot2)
  library(broom)
  
  
  Final_Data_WWeather <- Final_Data_WWeather %>%
    mutate(log_CLM_TOT_CHRG_AMT = log(CLM_TOT_CHRG_AMT))
  
  
  # Calculate correlation for each season group with log(AMT)
  cor_results_log <- Final_Data_WWeather %>%
    group_by(SEASON_GROUP) %>%
    summarize(correlation = cor(temp, log_CLM_TOT_CHRG_AMT, use = "complete.obs"))
  
  ggplot(Final_Data_WWeather, aes(x = temp, y = log_CLM_TOT_CHRG_AMT, color = SEASON_GROUP)) +
    geom_point(alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE) +
    facet_wrap(~ SEASON_GROUP) + 
    labs(title = "Temperature vs Log(Hospital Cost) by Season Group",
         x = "Temperature (°F)", 
         y = "Log(Hospital Cost)",
         color = "Season Group") +
    theme_minimal() +
    theme(legend.position = "bottom") +
    geom_text(data = cor_results_log, 
              aes(x = 30, y = 6, label = paste("Corr: ", round(correlation, 2))),
              inherit.aes = FALSE, color = "black", size = 5)
  
  
  
  
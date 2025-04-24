library(tidyverse)
library(dplyr)

inpatient_encounters <- read.csv("inpatient_encounters.csv")
inpatient_encounters <- inpatient_encounters |>
  mutate(BENE_ID = as.character(row_number()))
glimpse(inpatient_encounters)

enrollment <- read.csv("enrollment.csv")
enrollment <- enrollment |>
  mutate(BENE_ID = as.character(row_number()))
glimpse(enrollment)


inpatient_encounters_final <- inpatient_encounters |>
  left_join(fin_enrollment, by = "BENE_ID")
write.csv(inpatient_encounters_final, "C:/Users/erinl/OneDrive - University of Massachusetts/Documents/PH 345/inpatient_encounters_final.csv")

filtered_inpatient_final <- inpatient_encounters_final |>
  filter(ICD_DIAG_CD_DESC %in% c(
    "Stress", 
    "Other problems related to social environment", 
    "Social exclusion and rejection")
  ) |>
  filter(ER_flag %in% c("0")) 
    
final_filtered_inpatient <- filtered_inpatient_final |>
  mutate(
    CLM_FROM_DT = as.Date(CLM_FROM_DT, format = "%m / %d / %Y"),
    CLM_THRU_DT = as.Date(CLM_THRU_DT, format = "%m / %d / %Y"),
    Season = case_when(
      month(CLM_FROM_DT) %in% c(12, 1, 2) ~ "Winter",
      month(CLM_FROM_DT) %in% c(3, 4, 5) ~ "Spring",
      month(CLM_FROM_DT) %in% c(6, 7, 8) ~ "Summer",
      month(CLM_FROM_DT) %in% c(9, 10, 11) ~ "Fall",
      TRUE ~ "Unknown"
    )
  )

write.csv(final_filtered_inpatient, "C:/Users/erinl/OneDrive - University of Massachusetts/Documents/PH 345/final_filtered_inpatient.csv")
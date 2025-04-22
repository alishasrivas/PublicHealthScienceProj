library(tidyverse)
inpatient_encounters <- read_csv("inpatient_encounters.csv")
inpatient_stress <- inpatient_encounters |>
  filter(ICD_DIAG_CD_DESC %in% c("Stress", "Other problems related to social environment", "Social exclusion and rejection")) |>
  filter(ER_flag %in% c("0"))
inpatient_stress_count <- nrow(inpatient_stress)
print(paste("Inpatient admissions", inpatient_stress_count))
inpatient_stress <- inpatient_stress |>
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

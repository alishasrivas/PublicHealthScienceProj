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


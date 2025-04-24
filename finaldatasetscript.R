library(tidyverse)
library(dplyr)

inpatient_encounters <- read.csv("inpatient_encounters.csv")
inpatient_encounters <- inpatient_encounters |>
  transform(BENE_ID = as.character(BENE_ID))
enrollment <- read.csv("enrollment.csv")
glimpse(enrollment)

enrollment <- enrollment |>
  transform(BENE_ID = as.character(BENE_ID))
fin_enrollment <- select(enrollment, BENE_ID, BENE_BIRTH_DT)


fin_dataset <- full_join(inpatient_encounters, fin_enrollment)
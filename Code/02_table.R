library(labelled)
library(gtsummary)
library(dplyr)
library(broom)

clean_df <-  readRDS(here::here("Data/HepB_Data_Clean_Final.rds"))
                     
var_label(clean_df) <- list(
  Education_Level = "Education Level")

table1 <- clean_df |>
  select("Hep_B", "Gender", "Ethnicity", "Education_Level", "INDFMPIR", "Age") |>
  tbl_summary(by = Hep_B, missing = 'no') |>
  add_overall() |>
  add_p(
    test = list(all_categorical() ~ "chisq.test", all_continuous() ~ "t.test")
  )

saveRDS(
  table1,
  file = here::here("Output", "Table1.rds")
)

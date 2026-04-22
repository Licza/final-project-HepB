library(dplyr)
library(labelled)
library(gtsummary)
library(broom)
library(broom.helpers)
library(car)
library(parameters)

clean_df <-  readRDS(here::here("Data/HepB_Data_Clean_Final.rds"))
                     
log_df <- clean_df |>
  mutate(Hep_B = ifelse(Hep_B == "Immune", 1, 0))

binary_mod <- glm(
  Hep_B ~ Age + Gender + Ethnicity + Education_Level + INDFMPIR,
  data = log_df,
  family = binomial()
)

reg_table <- tbl_regression(binary_mod, exponentiate = TRUE) |>
  add_global_p()

saveRDS(
  reg_table,
  file = here::here("Output", "Regression.rds")
)

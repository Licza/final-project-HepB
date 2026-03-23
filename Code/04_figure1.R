library(ggplot2)
library(dplyr)

clean_df <-  readRDS(here::here("Data/HepB_Data_Clean_Final.rds"))

log_df <- clean_df |>
  mutate(Hep_B = ifelse(Hep_B == "Immune", 1, 0))

plot_df <- log_df |>
  group_by(Education_Level) |>
  summarise(
    prevalence = mean(Hep_B, na.rm = TRUE) * 100,
    n = n())|>
  filter(Education_Level != 'Unknown') |> 
  arrange(desc(prevalence)) |>
  mutate(Education_Level = factor(Education_Level, levels = Education_Level))

# Plot
figure1 <- ggplot(plot_df, aes(x = Education_Level, y = prevalence, fill = prevalence)) +
  geom_col() +
  labs(
    x = "Education Level",
    y = "Immunity Prevalence (%)",
    title = "Hepatitis B Immunity by Education Level"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

saveRDS(
  figure1,
  file = here::here("Output", "Figure1.rds")
)
library(haven) #needed to read in XPT files from NHANES
library(dplyr) #merging dataframes

here::i_am("final_project_report.Rmd")

#Reading in Hepatitis B Lab Data File
Hep_Data <- read_xpt(here::here("Data/HEPB_S_L.xpt"))

#Reading in NHANES Demographic Data File
Demo_Data <- read_xpt(here::here("Data/DEMO_L.xpt"))

#Merging Files: Adding Demographic Columns to Hepaptis B File
df <- left_join(Hep_Data, Demo_Data, by = "SEQN")


#cleaning data
#renaming variables of Interest
clean_df <- df %>%
  rename(
    Hep_B = LBXHBS,
    Gender = RIAGENDR,
    Ethnicity = RIDRETH3,
    Education_Level = DMDEDUC2,
    Age = RIDAGEYR
  )

#Setting LBXHBS values of 1 to immune, 2 to not immune, else NA
clean_df <- clean_df %>%
  mutate(
    Hep_B = case_when(
      Hep_B == 1 ~ 'Immune',
      Hep_B == 2 ~ 'Not Immune'
    )
  )

#Gender re-coding
clean_df <- clean_df %>%
  mutate(
    Gender = recode(Gender,
                    `1` = "Male",
                    `2` = "Female")
  )

#Ethnicity re-coding
clean_df <- clean_df %>%
  mutate(
    Ethnicity = recode(Ethnicity,
                       `1` = "Hispanic",
                       `2` = "Hispanic", #collapsing Mexican american and other Hispanic into one category
                       `3` = "White",
                       `4` = "Black",
                       `6` = "Asian",
                       `7` = "Other Race")
  )

#Education Level re-coding
clean_df <- clean_df %>%
  mutate(
    Education_Level = recode(Education_Level,
                             `1` = "Less than A High school Education",
                             `2` = "Less than A High school Education",  #Collapsing less than 9th and 9-12th grade into one category
                             `3` = "High school graduate/GED or equivalent",
                             `4` = "Some college or Associate's Degree",
                             `5` = "College Graduate or Above",
                             `7` = "Unknown",
                             `9` = "Unknown"),
    
    Education_Level = ifelse(is.na(Education_Level), 
                             "Unknown", 
                             Education_Level)
  )


#In NHANES August 2021-August 2023, the weighted mean age for participants 80 years and older is 85 years (variable is top coded)
#will replace values of 80 with mean give by NHANES (85)
clean_df <- clean_df %>%
  mutate(
    Age = ifelse(Age == 80, 85, Age)
  )


#Subsetting final data set to individuals >= 20 years of age and clear Immune Status
clean_df <- clean_df %>%
  filter(Age >= 20, !is.na(Hep_B))

#Saving final analytic Dataset
saveRDS(
  clean_df,
  file = here::here("Data", "HepB_Data_Clean_Final.rds")
)


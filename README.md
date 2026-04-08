# Hepatitis B serologic immunity among U.S. adults aged 20 years and older

## Overview
This repository contains code and data used to analyze Hepatitis B serologic immunity among U.S. adults aged 20 years and older. 
The project evaluates demographic and socioeconomic factors associated with immunity and presents findings in a final report.

## Code description

`Code/01_load_data.R`
  - loads the clean data files from the 'Data/' folder to generate the final analytic data set
  - saves the final clean analytic data set as a `.rds` object in `Data/` folder

`Code/02_table.R`
  - generates table 1 with summary characteristics of individuals in the Hepatitis B analytic data set
  - saves Table 1 as a `.rds` object in `Output/` folder
 
 `Code/03_regression.R`
  - runs a logistic regression table with the results of a multivariable logistic regression model used to evaluate demographic
    and socioeconomic factors associated with Hepatitis B immunity 
  - saves the regression table as a `.rds` object in `Output/` folder

`Code/04_figure1.R`
  - creates figure 1 that visualizes the proportion of individuals with vaccine-Induced Hepatitis B Immunity across education levels 
  - saves Figure 1 as a `.rds` object in `Output/` folder 

`Code/05_render_report.R`
  - renders `final_project_report.Rmd` to create `final_project_report.html`

`final_project_report.Rmd`
  - reads Table 1, Regression Table, and Figure 1 from the `Output/ ` folder
  - formats findings into a final report
  - The contents of this report include:
      - Table 1: Summary of participant characteristics stratified by Hepatitis B immunity status
      - Regression Table: Results from a multivariable logistic regression model estimating associations between 
                          demographic/socioeconomic factors and Hepatitis B immunity (reported as odds ratios)
       - Figure 1: Bar plot showing the proportion of individuals with vaccine-induced Hepatitis B immunity across education levels

`Data/ `
  - Holds original NHANES data files and final analytic data set
  
`Output/ `
  - Holds all generated output from the R scripts in the `Code/ ` folder
    - `table1.rds`  
    - `regression.rds`  
    - `figure1.rds`  

`Makefile/ `
  - Contains rules to create each object needed for the final report

## How to Generate the Final Report
  - First synchronize project library by running `make install`
  - Second use `make report.html` or run all R scripts in order from 01 to 05  to create final report
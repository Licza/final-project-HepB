report.html: final_project_report.Rmd Code/05_render_report.R Data/HepB_Data_Clean_Final.rds Output/Table1.rds Output/Regression.rds Output/Figure1.rds
	Rscript Code/05_render_report.R

Data/HepB_Data_Clean_Final.rds:
	Rscript Code/01_load_data.R
	
Output/Table1.rds: Data/HepB_Data_Clean_Final.rds
	Rscript Code/02_table.R
	
Output/Regression.rds: Data/HepB_Data_Clean_Final.rds
	Rscript Code/03_regression.R

Output/Figure1.rds: Data/HepB_Data_Clean_Final.rds
	Rscript Code/04_figure1.R

.PHONY: install
install: 
	Rscript -e "renv::restore(prompt = FALSE)"
	
.PHONY: clean
clean:
	rm -f Output/*.rds && rm -f Data/*.rds && rm -f final_project_report.html
FROM rocker/tidyverse:4.5.1 as base

RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

RUN Rscript -e "renv::restore(prompt = FALSE)"

#### DO NOT EDIT LINES ABOVE ####

FROM rocker/tidyverse:4.5.1

RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

COPY --from=base /home/rstudio/project .


COPY Makefile .
COPY final_project_report.Rmd .
COPY final.Rproj .

RUN mkdir Code
RUN mkdir Data
Run mkdir Output
RUN mkdir report

COPY Data Data
COPY Code Code

CMD make && mv final_project_report.html report/
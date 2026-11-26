# Life Expectancy and Income in Africa, 1952-2007

An R project analysing life expectancy, income and population across 52 African countries using the Gapminder dataset, with a focus on Kenya. Built with tidyverse, ggplot2 and R Markdown.

Live report: https://charisaladh.github.io/R-africa-development-analysis/

## What it shows
- Highest and lowest life expectancy in 2007
- Kenya compared with Uganda, Tanzania, Rwanda and Ethiopia
- Income against life expectancy
- Biggest gains and the setbacks of 1987 to 1997
- Kenya against the African average

## Project structure
- `scripts/` - R scripts for the analysis
- `data/` - Africa subset of the Gapminder data
- `output/` - tables and charts
- `report.Rmd` - the R Markdown report

## How to run
1. Install R and RStudio.
2. Install packages: `install.packages(c("tidyverse", "gapminder", "rmarkdown"))`
3. Run the scripts in `scripts/` in order, then knit `report.Rmd`.

## Data
Gapminder, via the `gapminder` R package.

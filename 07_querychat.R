# ---- I have data ----
library(readr)

mr_cases <- read_csv("data/cases_month.csv")

mr_cases

# ---- that I want to explore ----
library(querychat)

mr_cases |> querychat_app()

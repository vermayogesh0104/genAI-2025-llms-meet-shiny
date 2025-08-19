# ---- I have data that I want to explore ----
# Shoutout to Jen Richmond & TidyTuesday!
# https://jenrichmond.github.io/tidytuesday/2025-06-22_tt_measles/
library(readr)

mr_cases <- read_csv("data/cases_month.csv")

mr_cases

# ~~~~~~~~ ✦ querychat ✦ ~~~~~~~~

# ===[ https://github.com/posit-dev/querychat ]===

#  Imagine typing questions like these directly into your dashboard, and seeing
#  the results in realtime:
#
# - "Show only penguins that are not species Gentoo and have a bill length
#   greater than 50mm."
# - "Show only blue states with an incidence rate greater than 100 per 100,000
#   people."
# - "What is the average mpg of cars with 6 cylinders?"
#
# querychat is a drop-in component for Shiny that allows users to query a data
# frame using natural language. The results are available as a reactive data
# frame, so they can be easily used from > Shiny outputs, reactive expressions,
# downloads, etc. This is not as terrible an idea as you might think!

library(querychat)

mr_cases |> querychat_app()

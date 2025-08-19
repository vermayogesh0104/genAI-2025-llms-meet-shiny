library(DBI)
library(brio)
library(dplyr)
library(dbplyr)
library(ellmer)
library(duckdb)

con <- dbConnect(duckdb::duckdb(), dbdir = ":memory:")
duckdb_read_csv(con, "mr_cases", "data/cases_month.csv", na.strings = "NA")


dbGetQuery(con, "SELECT count(*) as n_row FROM mr_cases")


# ---- [[ A tool to run SQL queries ]] ----
run_query <- tool(
  function(query) {
    # Run the query on `con` and return as a tibble
    as_tibble(dbGetQuery(con, query))
  },
  name = "run_query",
  description = "Run a SQL query on the measles cases database.",
  arguments = list(
    query = type_string("A SQL query string.")
  ),
  annotations = tool_annotations(
    title = "Run Query",
    icon = bsicons::bs_icon("table")
  )
)

# ---- [[ Demo the tool ]] ----
chat <- chat("openai/gpt-4.1-nano", echo = "output")

chat$set_system_prompt(
  interpolate(
    r"(
You are an expert epidemiologist and data analyst.
Use the `run_query` tool to answer questions about measles cases.
The data is stored in a duckdb SQL database with a table called `mr_cases`.

{{ read_file('data/README-dataset.md')}}
  )"
  )
)
chat$register_tool(run_query)

chat$chat("Which country had the highest measles burden in 2019?")
chat$chat("What about in 2021?")

# ---- [[ Follow up ]] ----
# Go back and add metadata arguments to the `run_query` tool.
# Example: `.intent` (string)

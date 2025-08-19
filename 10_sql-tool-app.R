library(DBI)
library(brio)
library(dplyr)
library(dbplyr)
library(ellmer)
library(duckdb)

# ---- setup data ----
con <- dbConnect(duckdb::duckdb(), dbdir = ":memory:")
duckdb_read_csv(con, "mr_cases", "data/cases_month.csv", na.strings = "NA")


dbGetQuery(con, "SELECT count(*) as n_row FROM mr_cases")

# ---- 🌟 SHINY APP 🌟 ----

library(shiny)
library(bslib)
library(shinychat)

ui <- page_sidebar(
  sidebar = sidebar(
    width = 300,
    style = css(height = "100%"),
    chat_mod_ui(
      "chat",
      height = "100%",
      fill = TRUE,
      messages = '<span class="suggestion">Which country had the highest measles burden in 2019?</span>'
    ),
  ),
  fillable = FALSE,
  div(uiOutput("queries"))
)

server <- function(input, output, session) {
  queries <- reactiveVal(list())
  new_query <- reactiveVal(NULL)

  # ---- [[ A tool to run SQL queries ]] ----
  run_query <- tool(
    function(query, .intent = NULL) {
      result <- as_tibble(dbGetQuery(con, query))

      # Share the new_query with the app
      new_query(list(
        query = query,
        result = result,
        title = .intent
      ))

      result
    },
    name = "run_query",
    description = "Run a SQL query on the measles cases database.",
    arguments = list(
      query = type_string("A SQL query string."),
      .intent = type_string("The intent of the query for display purposes.")
    ),
    annotations = tool_annotations(
      title = "Run Query",
      icon = bsicons::bs_icon("table")
    )
  )

  # ---- [[ Display the queries ]] ----
  observeEvent(new_query(), {
    req(new_query())
    queries(c(queries(), list(new_query())))
  })

  output$queries <- renderUI({
    req(queries(), length(queries()) > 0)

    lapply(queries(), function(q) {
      card(
        fill = FALSE,
        card_header(q$title),
        layout_columns(
          div(
            h3("Query"),
            HTML(sprintf("<pre><code>%s</code></pre>", q$query)),
          ),
          div(
            h3("Result"),
            HTML(knitr::kable(q$result, format = "html", escape = FALSE))
          )
        )
      )
    })
  })

  # ---- [[ Set up the LLM client ]] ----
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

  chat_mod_server("chat", chat)
}

shinyApp(ui, server)

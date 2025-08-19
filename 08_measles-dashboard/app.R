library(shiny)
library(bslib)
library(dplyr)
library(plotly)
library(scales)
library(querychat)

mr_cases <- readr::read_csv(here::here("data/cases_month.csv"))

querychat_config <-
  querychat_init(
    data_source = mr_cases,
    greeting = r"---(Hi there!
I'm here to help you explore the measles cases data.
Here are some example prompts you can try:

* <span class="suggestion">Show Nigerian measles cases from 2023</span>
* <span class="suggestion">What are the top 5 countries with the most measles cases?</span>
* <span class="suggestion">Show countries with high yearly measles totals (above the 75th percentile)</span>
)---",
  )

ui <- page_sidebar(
  title = "Measles Dashboard",

  sidebar = querychat_sidebar("chat"),

  textOutput("title"),

  uiOutput("value_boxes"),

  layout_columns(
    col_widths = c(8, 4),
    card(
      full_screen = TRUE,
      card_header("Measles Cases by Country Over Time"),
      card_body(
        plotlyOutput("cases_by_country_plot")
      )
    ),
    card(
      full_screen = TRUE,
      card_header("Top 5 Countries by Measles Cases"),
      card_body(
        plotlyOutput("top_countries_plot")
      )
    )
  )
)

server <- function(input, output, session) {
  qc <- querychat_server("chat", querychat_config)

  mr_cases <- reactive(qc$df())

  output$title <- renderText({
    req(qc$title())
    qc$title()
  })

  output$value_boxes <- renderUI({
    data <- mr_cases()

    total_cases <- sum(data$measles_total, na.rm = TRUE)
    total_lab_confirmed <- sum(data$measles_lab_confirmed, na.rm = TRUE)
    # Calculate percentage of lab-confirmed cases
    lab_confirmed_rate <- round(total_lab_confirmed / total_cases * 100, 1)
    countries_affected <- length(unique(data$country))

    layout_columns(
      value_box(
        title = "Total Measles Cases",
        value = comma(total_cases),
        showcase = bsicons::bs_icon("virus")
      ),
      value_box(
        title = "Lab Confirmed Cases",
        value = comma(total_lab_confirmed),
        showcase = bsicons::bs_icon("clipboard2-check")
      ),
      value_box(
        title = "Lab Confirmed Rate",
        value = paste0(lab_confirmed_rate, "%"),
        showcase = bsicons::bs_icon("percent")
      ),
      value_box(
        title = "Countries Affected",
        value = countries_affected,
        showcase = bsicons::bs_icon("globe")
      )
    )
  })

  # Cases by country over time plot
  output$cases_by_country_plot <- renderPlotly({
    cases_by_country_year <- mr_cases() |>
      mutate(country = stringr::str_trunc(country, 25)) |>
      group_by(country, year) |>
      summarize(
        total_cases = sum(measles_total, na.rm = TRUE),
        .groups = "drop"
      ) |>
      # Only show countries with significant case counts to avoid clutter
      group_by(country) |>
      filter(sum(total_cases) >= 1000) |>
      ungroup()

    p <- plot_ly(
      cases_by_country_year,
      x = ~year,
      y = ~total_cases,
      color = ~country,
      type = "scatter",
      mode = "lines+markers"
    ) |>
      layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = "Measles Cases", tickformat = ","),
        legend = list(title = list(text = "Country"))
      )

    p
  })

  # Top countries plot
  output$top_countries_plot <- renderPlotly({
    top_countries <- mr_cases() |>
      group_by(country) |>
      summarize(
        total_cases = sum(measles_total, na.rm = TRUE),
        .groups = "drop"
      ) |>
      arrange(desc(total_cases)) |>
      head(5)

    p <- plot_ly(
      top_countries,
      x = ~total_cases,
      y = ~ reorder(country, total_cases),
      type = "bar",
      orientation = "h",
      marker = list(color = "#4582EC")
    ) |>
      layout(
        xaxis = list(title = "Total Measles Cases", tickformat = ","),
        yaxis = list(title = ""),
        showlegend = FALSE
      )

    p
  })
}

# Run the app
shinyApp(ui, server)

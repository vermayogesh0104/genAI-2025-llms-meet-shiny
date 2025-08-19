# 1. Add weather tool definition
# 2. Use annotations to add title and icon ("cloud-sun")
# 3. Add a `title` argument
# 4. Replace forecast data JSON with a table

library(shiny)
library(bslib)
library(ellmer)
library(shinychat)
library(weathR)

get_weather_forecast <- tool(
  function(lat, lon, location_name) {
    ContentToolResult(
      point_tomorrow(lat, lon, short = FALSE),
      extra = list(
        display = list(
          title = location_name
        )
      )
    )
  },
  name = "get_weather_forecast",
  description = "Get the weather forecast for a location.",
  arguments = list(
    lat = type_number("Latitude"),
    lon = type_number("Longitude"),
    location_name = type_string(
      "Name of the location for display to the user, typically 'City, State'."
    )
  ),
  annotations = tool_annotations(
    title = "Weather Forecast",
    icon = bsicons::bs_icon("cloud-sun")
  )
)

ui <- page_fillable(
  chat_mod_ui("chat")
)

server <- function(input, output, session) {
  client <- ellmer::chat("openai/gpt-4.1-nano")
  client$register_tool(get_weather_forecast)
  chat_mod_server("chat", client)
}

shinyApp(ui, server)

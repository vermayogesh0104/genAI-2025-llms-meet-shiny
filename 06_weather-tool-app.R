# 1. Add weather tool definition
# 2. Use annotations to add title and icon ("cloud-sun")
# 3. Add a `title` argument
# 4. Replace forecast data JSON with a table

library(shiny)
library(bslib)
library(ellmer)
library(shinychat)
library(weathR)

# ...weather tool here...

ui <- page_fillable(
  chat_mod_ui("chat")
)

server <- function(input, output, session) {
  client <- ellmer::chat("openai/gpt-4.1-nano")
  client$register_tool(get_weather_forecast)
  chat_mod_server("chat", client)
}

shinyApp(ui, server)

# 1. We're using the Shiny extension
# 2. Start with the shinychat snippet
# 3. {shinychat} -- pak::pak("posit-dev/shinychat/pkg-r")
# 4. {ellmer} -- use gpt-4.1-nano
# 5. Add chat_mod_ui() and chat_mod_server()

library(shiny)
library(bslib)
library(ellmer)
library(shinychat)

ui <- page_sidebar(
  title = "Demo shinychat app",
  chat_mod_ui("chat")
)

server <- function(input, output, session) {
  client <- chat_openai(model = "gpt-4.1-nano")
  chat_mod_server("chat", client)
}

shinyApp(ui, server)

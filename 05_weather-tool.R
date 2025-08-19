# ---- ✦ I can get the weather with R! ✦ ----
library(weathR)

woodstock <- list(lat = 34.0951, lon = -84.5179)

weathR::point_forecast(woodstock$lat, woodstock$lon)


# ---- ⚒️ Let's turn this into a tool 🛠️ ----
library(ellmer)

ellmer::create_tool_def(weathR::point_forecast, verbose = TRUE)

get_weather <- tool(
  \(lat, lon) weathR::point_forecast(lat, lon),
  name = "point_forecast",
  description = "Get forecast data for a specific latitude and longitude.",
  arguments = list(
    lat = type_number("Latitude of the location."),
    lon = type_number("Longitude of the location.")
  )
)

# The tool is callable!
get_weather(34.0951, -84.5179)

# ---- 🧰 Teach an LLM that we have this tool ----
chat <- chat_openai(model = "gpt-4.1-nano", echo = "output")

# Register the tool with the chatbot
chat$register_tool(get_weather)

chat$chat("Is today a good day to go to the pool in Woodstock, GA?")

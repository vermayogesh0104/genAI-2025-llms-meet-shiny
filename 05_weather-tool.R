# ---- ✦ I can get the weather with R! ✦ ----
library(weathR)

woodstock <- list(lat = 34.0951, lon = -84.5179)

weathR::point_forecast(woodstock$lat, woodstock$lon)


# ---- ⚒️ Let's turn this into a tool 🛠️ ----
library(ellmer)

ellmer::create_tool_def(weathR::point_forecast, verbose = TRUE)

get_weather <- tool(
  \(lat, lon) weathR::point_forecast(lat, lon),
  name = "get_weather",
  description = "Get point meteorological forecast data for a specified latitude and longitude.",
  arguments = list(
    lat = type_number("Latitude."),
    lon = type_number("Longitude.")
  )
)

get_weather(woodstock$lat, woodstock$lon)


# ---- 🧰 Teach an LLM that we have this tool ----
chat <- chat_openai(model = "gpt-4.1-nano")
chat$register_tool(get_weather)

chat$chat("Is today a good day to go to the pool in Woodstock, GA?")

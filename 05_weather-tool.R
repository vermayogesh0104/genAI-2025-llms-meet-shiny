# ---- ✦ I can get the weather with R! ✦ ----
library(weathR)

woodstock <- list(lat = 34.0951, lon = -84.5179)

weathR::point_forecast


# ---- ⚒️ Let's turn this into a tool 🛠️ ----
library(ellmer)

ellmer::create_tool_def(_____, verbose = TRUE)

get_weather <- tool()

# The tool is callable!

# ---- 🧰 Teach an LLM that we have this tool ----
chat <- chat_openai(model = "gpt-4.1-nano")

# Register the tool with the chatbot

chat$chat("Is today a good day to go to the pool in Woodstock, GA?")

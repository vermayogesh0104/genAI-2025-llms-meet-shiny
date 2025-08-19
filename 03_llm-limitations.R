library(ellmer)

# ========[ LLMs don't have access to realtime info ]========
chat <- chat_openai(model = "gpt-4.1-nano")

chat$chat("What has Posit been up to lately?")

chat$chat("Read https://posit.co/blog/ to find out!")

chat$chat("Wait, what's today's date?")

# ========[ LLMs don't store knowledge in a database ]========
chat <- chat_openai(model = "gpt-4.1-nano")
shinychat::chat_app(chat)

# ❯❯ List all ZIP codes in the U.S. that start with 18 and have a population of more than 20,000.

if (FALSE) {
  # We might need these
  library(tidycensus)
  library(dplyr)
  library(stringr)
}

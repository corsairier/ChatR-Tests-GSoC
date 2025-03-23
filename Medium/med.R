if(!require(ellmer)) install.packages("ellmer")
library(ellmer)

# Chat with the Llama with specified timeout
chat_function <- function(text, tout = 60) {
    chat <- ellmer::chat_ollama(model = "llama3.2:3b-instruct-q4_K_M")
    options(ellmer_timeout_s = tout)
    chat$chat(text)
}

question <- "What is the github of sundialr R package?"
tout = 300


chat_function(question, tout)

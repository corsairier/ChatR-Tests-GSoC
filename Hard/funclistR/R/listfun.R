#' List exported functions of an R package using ellmer and Ollama with timeout handling
#'
#' @param pkg_name Character. The name of the R package.
#' @return Character vector of exported function names, even if timeout occurs.
#' @export
#' @import ellmer
#' @importFrom ellmer chat_ollama
list_functions <- function(pkg_name) {
  options(ellmer_timeout_s = 300)  # Increased timeout to 5 minutes


  chat <- ellmer::chat_ollama(
    model = "llama3.2:3b-instruct-q4_K_M",
    system_prompt = "You are an R expert. Your task is to list all exported functions from an R package. 
                      Always return the complete and accurate list as it appears in the NAMESPACE file.
                      Only return the function names as a comma-separated list.
                      Do NOT provide links, references, explanations, or excuses.
                      No partial answers. No redirects. No unnecessary context. Only the complete list of functions."
  )

  prompt <- paste0(
    "List the functions exported by the R package '", pkg_name, "'. Only return the function names as a comma-separated list."
  )

  # Initialize result storage
  result_chunks <- character(0)

  tryCatch({
    stream <- chat$stream(prompt)

    # Collect output from the stream
    coro::loop(for (chunk in stream) {
      result_chunks <- c(result_chunks, chunk)
    })


  }, error = function(e) {
    warning("Timeout or error occurred. Returning partial result.")
  })

  # Combine all chunks into a single string
  full_result <- paste(result_chunks, collapse = "")

  full_result <- gsub("\n", "", full_result)         # Remove newlines
  full_result <- gsub("\\s*,\\s*", ",", full_result) # Remove spaces around commas

  # Parse the result into a vector
  function_vector <- strsplit(full_result, ",")[[1]]

  cat("Exported functions:\n", paste(function_vector, collapse = ", "), "\n")

  return(function_vector)
}

# GSOC TESTS ChatR

## Easy Test

### Steps

#### Install Ollama
I installed Ollama by running the following commands:
```bash
# Download and install Ollama
curl -fsSL https://ollama.com/install.sh | sh
```

#### Pull the Specified Model
```bash
# Pull the model
ollama pull llama3.2:3b-instruct-q4_K_M
```

#### Ask the Question
```bash
# Run and ask a question
ollama run llama3.2:3b-instruct-q4_K_M <<EOF > output.txt
How to register native routines written in C/C++ in an R package using the .Call interface?
EOF
```

The Result is stored in the file **output.txt** and can be accessed using 
```bash
cat output.txt
```

## Medium Test

Successfully wrote the `chat_function` which was the best programmatic way to create the chat object inside a function. 


## Hard Test
- Developed an R package to list all the functions exported by a package.
- It does not print all the packages correctly or completely, but it can be corrected using proper tooling/function calling.
- It can be done by creating a function, which can scrape the web for finding the `NAMESPACE` file from their respective github repositories.
- Also, currently it works very slow on my PC since it does not have a GPU and also `llama3.2:3b-instruct-q4_K_M` is a very heavy model.
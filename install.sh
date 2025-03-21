!#/bin/bash

# Download and install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull the model
ollama pull llama3.2:3b-instruct-q4_K_M

# Run and ask a question
ollama run llama3.2:3b-instruct-q4_K_M <<EOF > output.txt
How to register native routines written in C/C++ in an R package using the .Call interface?
EOF

cat output.txt
#!/bin/bash

# Compile the C++ program
g++ file.cpp -o program

# Check if compilation was successful
if [ $? -eq 0 ]; then
    # Run the compiled program with input from input.txt and display the output
    ./program < inp.txt
else
    echo "Compilation failed."
fi

#!/bin/bash

# Function to display help message
display_help() {
    echo "Usage: $0 -f input_json_file -o output_txt_file"
    echo "Options:"
    echo "  -f, --file      Input JSON file."
    echo "  -o, --output    Output plain text file."
    echo "  --help          Display this help message."
    echo "Example: $0 -f input.json -o output.txt"
}

# Check if help flag is provided
if [[ "$1" == "--help" ]]; then
    display_help
    exit 0
fi

# Parse command line options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -f|--file)
            input_file="$2"
            shift
            shift
            ;;
        -o|--output)
            output_file="$2"
            shift
            shift
            ;;
        *)
            echo "Error: Unknown option '$key'."
            display_help
            exit 1
            ;;
    esac
done

# Check if input and output file arguments are provided
if [ -z "$input_file" ] || [ -z "$output_file" ]; then
    echo "Error: Input and output file arguments are required."
    display_help
    exit 1
fi

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

# Extract domain and IP address, and write to output file
jq -r '.[] | "\(.domain)\n\(.ip[0])"' "$input_file" > "$output_file"

echo "Domain and IP addresses extracted from '$input_file' and saved into '$output_file'."

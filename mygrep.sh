#!/bin/bash

# Function to show usage/help
usage() {
    echo "Usage: $0 [-n] [-v] search_string filename"
    echo "Options:"
    echo "  -n    Show line numbers for matching lines"
    echo "  -v    Invert match (show lines that do not match)"
    echo "  --help   Show this help message"
    exit 1
}

# Initialize flags
show_line_numbers=false
invert_match=false

# Parse options using getopts
while getopts ":nv-:" opt; do
  case "$opt" in
    n) show_line_numbers=true ;;
    v) invert_match=true ;;
    -)
      case "$OPTARG" in
        help) usage ;;
        *) echo "Invalid option: --$OPTARG"; usage ;;
      esac
      ;;
    \?) 
      echo "Invalid option: -$OPTARG"
      usage
      ;;
  esac
done

# Shift away the parsed options
shift $((OPTIND -1))

# Validate remaining arguments
if [ $# -lt 2 ]; then
    echo "Error: Missing arguments."
    usage
fi

search_string="$1"
file="$2"

# Check if file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' does not exist."
    exit 1
fi

# Build grep command options
grep_options="-i"  # case-insensitive

if [ "$invert_match" = true ]; then
    grep_options="$grep_options -v"
fi

# Execute grep with or without line numbers
if [ "$show_line_numbers" = true ]; then
    grep $grep_options -n "$search_string" "$file"
else
    grep $grep_options "$search_string" "$file"
fi

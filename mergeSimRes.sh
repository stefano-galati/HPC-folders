#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Usage $0 resultsFolder"
	exit 1
fi

base_dir="$(pwd)/$1"
target_file="simRes.txt"

if ! [[ -d $base_dir ]]; then
	echo "Folder $base_dir does not exist"
	exit 1
fi

# Output file
output_file="$base_dir/mergedSimRes.txt"
echo $output_file

# Clear output file if it exists
> "$output_file"

# Find all file.txt files in subdirectories and merge them
find "$base_dir" -type f -name "simRes.txt" | while read -r file; do
    cat "$file" >> "$output_file"
    echo -e "\n" >> "$output_file"
done

echo "Merged files saved into $output_file"

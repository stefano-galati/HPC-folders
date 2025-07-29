#!/bin/bash

if [[ $# -ne 4 ]]; then
  echo "Usage: $0 faultList numJobs initialFolder finalFolder"
  exit 1
fi

FAULTLISTFOLDER="e"
RESULTFOLDER="env/common/splitFaultLists"


faultListFolder="$3"
resultFolder="$4"
input_file="$faultListFolder/$1"
numJobs="$2"


name="${1%.*}"  # Remove file extension from input filename

# Extract the header (first line)
header=$(head -n 1 "$input_file")

# Get total number of lines excluding the header
total_lines=$(( $(wc -l < "$input_file") - 1 ))

# Calculate lines per file (excluding header)
lines_per_file=$(( (total_lines + numJobs - 1) / numJobs ))

# Create a temporary file for the content without header
tail -n +2 "$input_file" > tmp_content.txt

# Split the content (without header)
split -l "$lines_per_file" -d --additional-suffix=.txt tmp_content.txt part_

# Now add header to each split file and rename
i=1
mkdir -p "$resultFolder"
for f in part_*.txt; do
  # Prepend the header line safely
  { echo "$header"; cat "$f"; } > "${f}.tmp" && mv "${f}.tmp" "$f"

  # Rename to file1.txt, file2.txt, ...
  mv "$f" "${resultFolder}/${name}_${i}.txt"
  ((i++))
done

# Clean up temp file
rm tmp_content.txt


#!/bin/bash

# Parent directory containing all the subfolders
PARENT_DIR="./env/workspace"
PARENT_DEST_DIR="./results"
LOGS_FOLDER="./logs"

#let COUNT=$(find $PARENT_DEST_DIR -mindepth 1 -maxdepth 1 | wc -l)+1
#echo "Simulation n°$COUNT"

#DEST_DIR="$PARENT_DEST_DIR/$COUNT"

# Create destination directory if it doesn't exist
#mkdir -p "$DEST_DIR"

# Find the maximum number present in /results
max=$(find "./results" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort -n | tail -n 1)
let new=$max+1

echo "Simulation n°$new"

DEST_DIR="$PARENT_DEST_DIR/$new"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Find and loop through all subdirectories inside the parent directory
for SUBDIR in "$PARENT_DIR"/*/; do
    echo "Entering: $SUBDIR"
    
    #the subdir contains a single folder
    SUBSUBDIR=$(find "${SUBDIR}/database" -mindepth 1 -maxdepth 1 -type d | head -n 1)
    if [[ -z "$SUBSUBDIR" ]]; then
	echo "Database folder empty"
    	echo "${SUBDIR}/outputs -> $DEST_DIR/$(basename $SUBDIR)"
        echo "Copying content..."
        cp -r $SUBDIR/outputs $DEST_DIR/$(basename $SUBDIR)
    else
	echo "${SUBSUBDIR} -> $DEST_DIR/$(basename $SUBSUBDIR)" 
    	echo "Copying content..."
    	cp -r $SUBSUBDIR $DEST_DIR/$(basename $SUBSUBDIR) 
    fi
done

echo "Copying log files..."

mkdir "$DEST_DIR/logs"
cp $LOGS_FOLDER/*.log "$DEST_DIR/logs"

echo "All files copied to $DEST_DIR"

# merging simRes files
echo "Merging simRes files inside $DEST_DIR..."
./mergeSimRes.sh $DEST_DIR

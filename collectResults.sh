#!/bin/bash

# Parent directory containing all the subfolders
PARENT_DIR="./env/workspace"
PARENT_DEST_DIR="./results"

let COUNT=$(find $PARENT_DEST_DIR -mindepth 1 -maxdepth 1 | wc -l)+1
echo "Simulation n°$COUNT"

DEST_DIR="$PARENT_DEST_DIR/$COUNT"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"


# Find and loop through all subdirectories inside the parent directory
for SUBDIR in "$PARENT_DIR"/*/; do
    echo "Entering: $SUBDIR"
    
    #the subdir contains a single folder
    SUBSUBDIR=$(find "$SUBDIR/database" -mindepth 1 -maxdepth 1 -type d | head -n 1)
    
    cp -r $SUBSUBDIR $DEST_DIR/$(basename $SUBSUBDIR) 

done

echo "All files copied to $DEST_DIR"


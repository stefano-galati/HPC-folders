#!/bin/bash

# TO BE RUN IN ROOT FOLDER OF THE PROJECT (/HPC_Folders)

if [[ $# -ne 2 ]]; then
	echo "Wrong number of arguments. Usage $0 faultList numThreads"
	exit 1
fi

faultList=$1
numThreads=$2

ROOTFOLDER=$(pwd)
FAULTLISTSFOLDER="$ROOTFOLDER/env/common/faultLists"
SPLITFAULTLISTSFOLDER="$ROOTFOLDER/env/common/splitFaultLists"
WORKSPACEFOLDER="$ROOTFOLDER/env/workspace"

echo "Hello!"

#Copy configuration file inside original simulations folder
cp injectorConfig.txt env/simulations/injectorConfig.txt

#Remove files inside env/common/splitFaultLists
rm -rf $SPLITFAULTLISTSFOLDER/*

#Create split fault lists
./splitFaultList.sh $faultList $numThreads $FAULTLISTSFOLDER $SPLITFAULTLISTSFOLDER

#Remove any sim folder in the workspace folder
rm -rf $WORKSPACEFOLDER/*

#For every fault list generated
for filepath in $SPLITFAULTLISTSFOLDER/*; do
    if [ -f "$filepath" ]; then
	file=$(basename $filepath)
        echo "Processing: $file"

        # Create dedicated simulations folder
    	let num=$(find "$WORKSPACEFOLDER" -mindepth 1 -maxdepth 1 -type d | wc -l)+1
	cp -r "$ROOTFOLDER/env/simulations" "$WORKSPACEFOLDER/sim_$num"
	#Empty folders if not empty
	rm -r $WORKSPACEFOLDER/sim_$num/database/*
	rm -r $WORKSPACEFOLDER/sim_$num/outputs/*

	#Usage: $0 simFolder faultListFile
	sbatch $ROOTFOLDER/runContainer.sbatch "$WORKSPACEFOLDER/sim_$num" "$file"
	
    fi
done




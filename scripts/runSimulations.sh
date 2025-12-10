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

#Copy input file
cp "in.txt" "env/simulations/in.txt"

#Copy fault time intervals
cp "faultTimeIntervals.txt" "env/simulations/faultTimeIntervals.txt"

#Remove files inside env/common/splitFaultLists
rm -rf $SPLITFAULTLISTSFOLDER/* 2> /dev/null

#Create split fault lists
echo "Splitting the fault list into $numThreads fault lists..."
./scripts/splitFaultList.sh $faultList $numThreads $FAULTLISTSFOLDER $SPLITFAULTLISTSFOLDER

#Remove any sim folder in the workspace folder
rm -rf $WORKSPACEFOLDER/* 2> /dev/null

#For every fault list generated
for filepath in $SPLITFAULTLISTSFOLDER/*; do
    if [ -f "$filepath" ]; then
	let num=$(find "$WORKSPACEFOLDER" -mindepth 1 -maxdepth 1 -type d | wc -l)+1
	    
	file=$(basename $filepath)
        echo "Processing: $file -> sim_$num"

        # Create dedicated simulations folder
    	cp -r "$ROOTFOLDER/env/simulations" "$WORKSPACEFOLDER/sim_$num"
	#Empty folders if not empty
	rm -rf $WORKSPACEFOLDER/sim_$num/database/* 2> /dev/null
	rm -rf $WORKSPACEFOLDER/sim_$num/outputs/* 2> /dev/null

	#Usage: $0 simFolder faultListFile
	sbatch $ROOTFOLDER/scripts/runContainer.sbatch "$WORKSPACEFOLDER/sim_$num" "$file"
	
    fi
done



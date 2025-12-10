#!/bin/bash

#SBATCH --job-name=simulate
#SBATCH --mail-type=NONE
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=03:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=logs/simulate.log
#SBATCH --mem-per-cpu=10M

# TO BE RUN IN ROOT FOLDER OF THE PROJECT (/HPC_Folders)

if [[ $# -ne 2 ]]; then
        echo "Wrong number of arguments. Usage $0 faultList numThreads"
        exit 1
fi

faultList=$1
numThreads=$2

if [[ $numThreads -le 0 ]]; then
	echo "numThreads must be >= 1"
	exit 1
fi


echo "Starting the simulation..."
./scripts/runSimulations.sh $faultList $numThreads

echo "Waiting for active jobs to finish"
./scripts/wait.sh

echo "Collecting results..."
./scripts/collectResults.sh

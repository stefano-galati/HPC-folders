#!/bin/bash

#SBATCH --job-name=simulate
#SBATCH --mail-type=NONE
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=00:05:00
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

echo "Starting the simulation..."
./runSimulations.sh $faultList $numThreads

echo "Waiting for active jobs to finish"
./wait.sh

echo "Collecting results..."
./collectResults.sh

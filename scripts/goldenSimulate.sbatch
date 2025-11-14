#!/bin/bash

#SBATCH --job-name=simulate
#SBATCH --mail-type=NONE
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=01:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=logs/simulate.log
#SBATCH --mem-per-cpu=10M

# TO BE RUN IN ROOT FOLDER OF THE PROJECT (/HPC_Folders)

echo "Starting the simulation..."
./scripts/runGoldenSimulation.sh

echo "Waiting for active jobs to finish"
./scripts/wait.sh

echo "Collecting results..."
./scripts/collectResults.sh

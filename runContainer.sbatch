#!/bin/bash

#SBATCH --job-name=faultInjector
#SBATCH --mail-type=ALL
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=test.log
#SBATCH --mem-per-cpu=10M


module load singularity

singularity run --bind ./simulations:/simulations faultInjectorContainer.sif

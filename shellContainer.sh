#!/bin/bash

#SBATCH --job-name=debugContainer
#SBATCH --mail-type=NONE
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=logs/debugContainer_%j.log
#SBATCH --mem-per-cpu=10M

apptainer shell --bind ./:/simulations,./env/common:/common faultInjectorContainer.sif

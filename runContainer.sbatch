#!/bin/bash

#SBATCH --job-name=faultInjector
#SBATCH --mail-type=NONE
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=test.log
#SBATCH --mem-per-cpu=10M


if [[$# -ne 2]]; then
	echo "Wrong number of args. Usage: $0 simFolder faultListFile"
	exit 1
fi

#To be run inside the target sim folder
simFolder=$1 

singularity exec --bind $simFolder:/simulations,./env/common:/common faultInjectorContainer.sif /simulations/firstCommands.sh FAULTLISTFILE=$2 FAULTLISTSFOLDER=/common/splitFaultLists

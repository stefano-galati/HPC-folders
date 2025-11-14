#!/bin/bash

module load singularity

singularity exec --bind ./env/simulations:/simulations,./env/common:/common faultInjectorContainer.sif /simulations/firstCommands.sh $@

#!/bin/bash

module load singularity

singularity run --bind ./simulations:/simulations faultInjectorContainer.sif

#!/bin/bash

# Wait for any active job to complete
while [ 1 ] 
do
	if [[ $(squeue --name=faultInjector | wc -l) -eq 1 ]]; then
        	break;
	fi
	echo "Waiting..."
	sleep 10
done

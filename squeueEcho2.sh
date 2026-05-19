#!/bin/bash

let delta=10

if [[ $# -eq 1 ]]; then
	let delta=$1
fi

while [[ $(squeue --name simulate | wc -l) -ne 1 ]]
do
	echo "$(squeue --name simulate)"
	sleep $delta
done

#!/bin/bash

for file in env/common/faultLogs/*; do
	uniq $file > tmp.txt
	mv tmp.txt $file
done

# TO BE RUN IN ROOT FOLDER OF THE PROJECT (/HPC_Folders)

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 binaryFile inputFile"
	exit 1
fi

INPUTFILESFOLDER=env/common/inputs

binary=$1
inputFile=$2

if [[ -n "$binary" ]]; then
        sed -i "s/^BINARYFILE=.*/BINARYFILE=$binary/" injectorConfig.txt
fi

cp "$INPUTFILESFOLDER/$inputFile" "in.txt"

echo "0" > faultTimeIntervals.txt
echo "0" >> faultTimeIntervals.txt

# remove old log files
rm logs/*.log

source simulate.sh golden.txt 1

# TO BE RUN IN ROOT FOLDER OF THE PROJECT (/HPC_Folders)

if [[ $# -ne 2 ]]; then
        echo "Wrong number of arguments. Usage $0 faultList numThreads"
        exit 1
fi

faultList=$1
numThreads=$2

# remove old log files	
cd logs

for f in *.log; do
	[[ "$f" != "manySimulations.log" ]] && rm "$f"
done

cd ..

sbatch scripts/simulate.sbatch $faultList $numThreads

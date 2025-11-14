# TO BE RUN IN ROOT FOLDER OF THE PROJECT (/HPC_Folders)

# remove old log files
rm logs/*.log

sbatch scripts/goldenSimulate.sbatch

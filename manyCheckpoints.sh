#!/bin/bash

#SBATCH --job-name=manySimulations
#SBATCH --mail-type=NONE
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=23:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=logs/manySimulations.log
#SBATCH --mem-per-cpu=100M


INPUTS_FOLDER="/home/sgalati/HPC-folders/env/common/inputs"
TIME_INTERVALS_FOLDER="/home/sgalati/HPC-folders/env/common/timeIntervals/minor"

modify_config() {
  local binary=$1
  if [[ -n "$binary" ]]; then
    	echo "sed -i s|^BINARYFILE=.*|BINARYFILE=$binary| injectorConfig.txt"
	sed -i "s|^BINARYFILE=.*|BINARYFILE=$binary|" injectorConfig.txt
  fi

  local faultLogs=$2
  if [[ -n "$faultLogs" ]]; then
	echo "sed -i s|^FAULTLOGS=.*|FAULTLOGS=$faultLogs| injectorConfig.txt"
	sed -i "s|^FAULTLOGS=.*|FAULTLOGS=$faultLogs|" injectorConfig.txt
  fi
}

modify_files() {
  local inputFile=$1
  local timeIntervalsFile=$2
  
  if [[ -f "$inputFile" ]]; then
    cp $inputFile "in.txt"
    echo "cp $inputFile in.txt"
  fi
  
  if [[ -f "$timeIntervalsFile" ]]; then
    cp $timeIntervalsFile "faultTimeIntervals.txt"
    echo "cp $timeIntervalsFile faultTimeIntervals.txt" 
  fi
}


#matrix convolution 1
modify_config checkpoints/matrixConvolution_1.elf no
modify_files "$INPUTS_FOLDER/matrixConvolution.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh

#matrix convolution 2
modify_config checkpoints/matrixConvolution_2.elf no
modify_files "$INPUTS_FOLDER/matrixConvolution.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh

#dijkstra 1
modify_config checkpoints/dijkstra_1.elf no
modify_files "$INPUTS_FOLDER/dijkstra.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh

#dijkstra 2
modify_config checkpoints/dijkstra_2.elf no
modify_files "$INPUTS_FOLDER/dijkstra.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh

#matrix multiplication 1
modify_config checkpoints/matrixMultiplication_1.elf no
modify_files "$INPUTS_FOLDER/matrixMultiplication.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh

#matrix multiplication 2
modify_config checkpoints/matrixMultiplication_2.elf no
modify_files "$INPUTS_FOLDER/matrixMultiplication.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh

#fft 1
modify_config checkpoints/fft_1.elf no
modify_files "$INPUTS_FOLDER/fft.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh

#qsort 1 
modify_config checkpoints/qsort_1.elf no
modify_files "$INPUTS_FOLDER/qsort.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh

#qsort 2
modify_config checkpoints/qsort_2.elf no
modify_files "$INPUTS_FOLDER/qsort.txt" "no"

source simulate.sh golden.txt 1
source squeueEcho2.sh


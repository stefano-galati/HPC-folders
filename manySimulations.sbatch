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
    	sed -i "s/^BINARYFILE=.*/BINARYFILE=$binary/" injectorConfig.txt
  fi

  local faultLogs=$2
  if [[ -n "$faultLogs" ]]; then
	sed -i "s/^FAULTLOGS=.*/FAULTLOGS=$faultLogs/" injectorConfig.txt
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


#test
modify_files "$INPUTS_FOLDER/matrixConvolution.txt" "$TIME_INTERVALS_FOLDER/matrixConvolution.txt"
modify_files "$INPUTS_FOLDER/qsort.txt" "$TIME_INTERVALS_FOLDER/qsort.txt"
modify_files "$INPUTS_FOLDER/matrixMultiplication.txt" "$TIME_INTERVALS_FOLDER/matrixMultiplication.txt"
modify_files "$INPUTS_FOLDER/dijkstra.txt" "$TIME_INTERVALS_FOLDER/dijkstra.txt"
modify_files "$INPUTS_FOLDER/fft.txt" "$TIME_INTERVALS_FOLDER/fft.txt"


#matrix convolution
modify_config matrixConvolution.elf yes
modify_files "$INPUTS_FOLDER/matrixConvolution.txt" "$TIME_INTERVALS_FOLDER/matrixConvolution.txt"

# bitflip time instants
source simulate.sh golden.txt 1
source squeueEcho2.sh
source uniqueFaultLogs.sh

modify_config matrixConvolution.elf no

#faulty simulations
source simulate.sh someBitflips.txt 16
source squeueEcho2.sh

rm faultTimeIntervals.txt

#golden simulation
source simulate.sh golden.txt 1
source squeueEcho2.sh


#quick sort
modify_config qsort.elf yes
modify_files "$INPUTS_FOLDER/qsort.txt" "$TIME_INTERVALS_FOLDER/qsort.txt"

source simulate.sh golden.txt 1
source squeueEcho2.sh
source uniqueFaultLogs.sh

modify_config qsort.elf no

source simulate.sh someBitflips.txt 16
source squeueEcho2.sh

rm faultTimeIntervals.txt

source simulate.sh golden.txt 1
source squeueEcho2.sh

#matrix multiplication
modify_config matrixMultiplication.elf yes
modify_files "$INPUTS_FOLDER/matrixMultiplication.txt" "$TIME_INTERVALS_FOLDER/matrixMultiplication.txt"

source simulate.sh golden.txt 1
source squeueEcho2.sh
source uniqueFaultLogs.sh

modify_config matrixMultiplication.elf no

source simulate.sh someBitflips.txt 16
source squeueEcho2.sh

rm faultTimeIntervals.txt

source simulate.sh golden.txt 1
source squeueEcho2.sh


#dijkstra
modify_config dijkstra.elf yes
modify_files "$INPUTS_FOLDER/dijkstra.txt" "$TIME_INTERVALS_FOLDER/dijkstra.txt"

source simulate.sh golden.txt 1
source squeueEcho2.sh
source uniqueFaultLogs.sh

modify_config dijkstra.elf no

source simulate.sh someBitflips.txt 16
source squeueEcho2.sh

rm faultTimeIntervals.txt

source simulate.sh golden.txt 1
source squeueEcho2.sh



#fft
modify_config fft.elf yes
modify_files "$INPUTS_FOLDER/fft.txt" "$TIME_INTERVALS_FOLDER/fft.txt"

source simulate.sh golden.txt 1
source squeueEcho2.sh
source uniqueFaultLogs.sh

modify_config fft.elf no

source simulate.sh someBitflips.txt 16
source squeueEcho2.sh

rm faultTimeIntervals.txt

source simulate.sh golden.txt 1
source squeueEcho2.sh



echo "Done"

# Fault injector environment

## Usage
`./simulate.sh faultListName numParallelJobs`

While the simulation is running, logs can be viewed in files:
* simulate.log
* runContainer.log
  
To watch jobs info in real time using squeue, use the script squeueEcho.sh

## Documentation
To run multiple containers in parallel, a script is used. It runs many singularity containers.
Every container needs a "simulations" folder, where it can create and delete files.
At the end of the simulation, all the results present in every simulations folder will be collected.

Example:
Let's suppose we run a simulation where a fault list of 100 elements is used. We want to create 5 threads to speed up execution.
The launching script will create:
* /env
	* /simulations (original folder, to be copied)
	* /sim_1 (used by execution 1)
	* /sim_2
	* /sim_3
	* /sim_4
	* /sim_5
	* /common (configs, exec, faultLists, splitFaultLists)


sim1, sim2, sim3, sim4, sim5 are copied of env/simulations and contain folders m5out, outputs, database(of the results of a single simulation).

In the script launching every container, /simulations is mapped to ./sim_i while /common is mapped to ./common

WARNING
At the moment, to change the executable injectorConfig.txt has to be changed. The input file in.txt in the main folder has to be changed too. Manually copy env/common/inputs/inputFile.txt to the main folder with the name "in.txt"

If a simulation appears to be stuck, be careful to add the tick limit parameter to the injectorConfig.txt file.

At the moment, if a job is assigned to node 7-7, an error occurs. 

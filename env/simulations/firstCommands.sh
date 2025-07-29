#!/bin/bash

mkdir /simulations

#run faultInjector.sh with command line arguments

cd /faultInjector
./faultInjector.sh $@

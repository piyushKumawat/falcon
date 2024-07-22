#!/bin/bash
#PBS -N zfrac_2m 
#PBS -l select=1:ncpus=48:mpiprocs=6
#PBS -l place=scatter:excl
#PBS -l walltime=1:00:00
#PBS -P forge

cd $PBS_O_WORKDIR

module load use.moose moose-dev

mpiexec /home/kumap/sawtooth2/projects/falcon/falcon-opt -i /home/kumap/sawtooth2/projects/falcon/examples/2dFractures/2dFrac_1fluid.i



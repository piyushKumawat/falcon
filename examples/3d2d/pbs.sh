#!/bin/bash
#PBS -N inj_mech
#PBS -l select=18:ncpus=48:mpiprocs=48
#PBS -l place=scatter:excl
#PBS -l walltime=15:00:00
#PBS -P forge

cd $PBS_O_WORKDIR

module purge
module load use.moose moose-dev/binary
mpiexec ~/projects_sawtooth/falcon/falcon-opt -i stochastic_driver.i

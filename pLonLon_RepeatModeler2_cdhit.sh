#!/bin/bash
# Job name:
#SBATCH --job-name=cdhit
#
# Account:
#SBATCH --account=fc_nachman    #ALLOWANCE
#
# Partition:
#SBATCH --partition=savio3
#
# Nodes to use
#SBATCH --nodes=1
#
# Number of tasks needed for use case (example):
#SBATCH --ntasks=1
#
# Processors per task:
#SBATCH --cpus-per-task=40
#
# Wall clock limit:
#SBATCH --time=1:00:00
#
#SBATCH --mail-user=kozakk@berkeley.edu
#SBATCH --mail-type=ALL
#
## Command(s) to run (example):
module load python

source /global/home/users/kozakk/.bashrc
conda -V
source activate cdhit
conda list
/media/data1/bin/cdhit/cd-hit-est -i repbase.msrepdb.sinebase.l1base.RM2.redundant.fasta -o repbase.msrepdb.sinebase.l1base.RM2.reduced.fasta -d 20 -aS 0.8 -c 0.8 -G 0 -g 1 -b 500 -T 11 -M 0/media/data1/bin/cdhit/cd-hit-est -i repbase.msrepdb.sinebase.l1base.RM2.redundant.fasta -o repbase.msrepdb.sinebase.l1base.RM2.reduced.fasta -d 20 -aS 0.8 -c 0.8 -G 0 -g 1 -b 500 -T 40 -n 5 -M 900000


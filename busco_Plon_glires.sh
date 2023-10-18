#!/bin/bash
# Job name:
#SBATCH --job-name=BUSCO_Plon_glires
#
# Account:
#SBATCH --account=fc_nachman    #ALLOWANCE
#
# Partition:
#SBATCH --partition=savio2
#
# Nodes to use
#SBATCH --nodes=1
#
# Number of tasks needed for use case (example):
#SBATCH --ntasks=1
#
# Processors per task:
#SBATCH --cpus-per-task=28
#
# Wall clock limit:
#SBATCH --time=7-0
#
#SBATCH --mail-user=kozakk@berkeley.edu
#SBATCH --mail-type=ALL
#
## Command(s) to run (example):
module load python

source /global/home/users/kozakk/.bashrc
conda -V
source activate busco
busco -m genome -i /global/scratch/users/kozakk/CCGP/ref/mPerLon1.NCBI.p_ctg.fasta -o ./mPerLon1.NCBI.p_ctg.fasta.BUSCO.glires -l glires_odb10 --augustus -c 28


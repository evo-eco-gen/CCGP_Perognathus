#!/bin/bash
# Job name:
#SBATCH --job-name=liftoff
#
# Account:
#SBATCH --account=fc_nachman
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
#SBATCH --time=1-0
#
#SBATCH --mail-user=kozakk@berkeley.edu
#SBATCH --mail-type=ALL
#
## Command(s) to run (example):
module load python

###Annotation of the Perognathus longimembris longimembris genome with sequences from P. l. pacificus.

source /global/home/users/kozakk/.bashrc
source activate liftoff
#San Diego reference annotation (GCF_023159225.1) without unplaced scaffolds; mapped onto our reference (pLonLon.unplaced.scaf)
liftoff -copies -polish -g genomic.GCF_023159225.1.unplaced_removed.gff -o pLonLon.unplaced.scaf.liftoff.gff -u pLonLon.unplaced.scaf.unmapped pLonLon.unplaced.scaf.fasta GCF_023159225.1.unplaced_removed.fasta

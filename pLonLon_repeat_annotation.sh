#!/bin/bash
# Job name:
#SBATCH --job-name=pLonLon_repeats
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
# Number of tasks needed for use case:
#SBATCH --ntasks=1
#
# Processors per task:
#SBATCH --cpus-per-task=40
#
# Wall clock limit:
#SBATCH --time=3-0
#
#SBATCH --mail-user=kozakk@berkeley.edu
#SBATCH --mail-type=ALL
#
## Command(s) to run:

# 0. Model repeats with emphasis on LTRs:
export SINGULARITY_CACHEDIR='/global/scratch/users/kozakk/singularity_cache/'
export SINGULARITY_TMPDIR='/global/scratch/users/kozakk/'

singularity exec /global/scratch/users/kozakk/bin/dfam-tetools-latest.sif BuildDatabase -name GCA_024363575.1_mPerLon1.0.p_genomic.RM2_database /global/scratch/users/kozakk/CCGP/ref/Perognathus/GCA_024363575.1_mPerLon1.0.p_genomic.fna
singularity exec /global/scratch/users/kozakk/bin/dfam-tetools-latest.sif RepeatModeler -database GCA_024363575.1_mPerLon1.0.p_genomic.RM2_database -pa 40 -LTRStruct

#cd-hit

#TSI

# 1. Mask simple repeats
module load python
source /global/home/users/kozakk/.bashrc
source activate repeatmasker

RepeatMasker -pa 40 -a -e ncbi -ace -gff -u -xm -poly -xsmall -noint -dir /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/noint /global/scratch/users/kozakk/CCGP/ref/Perognathus/GCA_024363575.1_mPerLon1.0.p_genomic.fna

# 2. Mask de novo predicted sequences.
RepeatMasker -pa 40 -a -e ncbi -dir /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/de_novo/ -nolow \
-lib pLonLon.RM2.nonredundant.classified.ProtExcluded.fasta /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/noint/GCA_024363575.1_mPerLon1.0.p_RMnointMask.fna

# 3. Mask with RepBase
RepeatMasker -pa 40 -a -e ncbi -dir /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/repbase/ -nolow \
-lib Repbase.nonRedundant.headersForMasker.txt /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/de_novo/GCA_024363575.1_mPerLon1.0.p_RMnointMask.RM2Mask.fna


# 4. mask with L1base, SINEbase, msrepDB
RepeatMasker -pa 40 -a -e ncbi -dir /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/databases/ -nolow \
-lib L1.SINE.msrepDB.nonredundant.fasta /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/repbase/GCA_024363575.1_mPerLon1.0.p_RMnointMask.RM2Mask.repbaseMask.fna

# 5. Mask with curated Zoonomia sequences on Dfam  (as an alternative to Repbase)
RepeatMasker -pa 40 -a -e ncbi -dir /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/dfam_glires/ -nolow \
-species glires /global/scratch/users/kozakk/CCGP/ref/Perognathus/repeatable/databases/GCA_024363575.1_mPerLon1.0.p_RMnointMask.RM2Mask.repbaseMask.otherMasks.fna

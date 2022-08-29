#!/bin/bash -login
#SBATCH -D /home/jemizzi/biogeo
#SBATCH -J snakemake_fastqc
#SBATCH -t 3-0:00:00
#SBATCH -N 1
#SBATCH --output /home/jemizzi/biogeo/scripts/snakemake_fastqc-%j.out
#SBATCH --error /home/jemizzi/biogeo/scripts/snakemake_fastqc-%j.err

# activate conda in general
source /home/jemizzi/.bashrc # if you have the conda init setting

# activate a specific conda environment, if you so choose
conda activate snakemake 

# go to a particular directory
cd /home/jemizzi/biogeo 

# make things fail on errors
set -o nounset
set -o errexit
set -x

### run your commands here!

snakemake -s Snakefile --use-conda --cluster "sbatch -t 0:30:00 -N 1 -c 14 -J snakemake_fq --mem=30gb " --jobs 1

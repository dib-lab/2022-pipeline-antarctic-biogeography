#! /bin/bash -login
#SBATCH -p bmm
#SBATCH -J transfer_data
#SBATCH -t 9-0:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=80gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jelumian@ucdavis.edu

# load sra toolkit
module load sratoolkit

# go to a particular directory
cd /home/jemizzi/biogeo/data

# run will not stop if line fail
set x

# lines commented out are files that have already been downloaded when rerunning script

# download files 
# microcoleus
#fastq-dump --gzip SRR855414
#fastq-dump --gzip SRR5855413
#fastq-dump --gzip SRR2952554
#fastq-dump --gzip SRR5247052
#fastq-dump --gzip ERR3588763
#fastq-dump --gzip SRR5891573
#fastq-dump --gzip SRR10953298
#fastq-dump --gzip ERR1333181
#fastq-dump --gzip SRR5459769
#fastq-dump --gzip SRR6048908
#fastq-dump --gzip SRR12473531
#fastq-dump --gzip ERR3192241
#fastq-dump --gzip SRR5468150
#fastq-dump --gzip SRR6266358
#fastq-dump --gzip SRR6048908

# phormidium
#fastq-dump --gzip SRR7528444
#fastq-dump --gzip SRR5216658
#fastq-dump --gzip SRR7428116
#fastq-dump --gzip SRR7769747
#fastq-dump --gzip SRR12522841
#fastq-dump --gzip SRR7428132
#fastq-dump --gzip ERR3503286
#fastq-dump --gzip SRR9691033
#fastq-dump --gzip SRR10186387
#fastq-dump --gzip ERR738546
#fastq-dump --gzip SRR6262267

# pseudanabaena
#fastq-dump --gzip SRR6266338
#fastq-dump --gzip SRR5829599
#fastq-dump --gzip SRR5468149
#fastq-dump --gzip ERR4192538
#fastq-dump --gzip SRR7769784
fastq-dump --gzip SRR2657229
fastq-dump --gzip SRR5198900

#neosynechococcus
fastq-dump --gzip SRR5208701
fastq-dump --gzip SRR5198900
fastq-dump --gzip SRR490140
fastq-dump --gzip SRR2657237

# leptolyngbya
fastq-dump --gzip SRR5468150
fastq-dump --gzip SRR6683740
fastq-dump --gzip SRR5198900

# neosynechococcus and leptolyngbya (same data set)
#fastq-dump --gzip SRR5468153

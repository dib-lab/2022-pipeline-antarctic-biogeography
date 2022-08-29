#! /bin/bash -login
#SBATCH -J fqc_biogeo
#SBATCH -t 6:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=30gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jelumian@ucdavis.edu

# load fastqc
module load fastqc/0.11.9t

# go to a particular directory
cd /home/jemizzi/biogeo/data

# run will not stop if line fail
set x

# run fasqc
# fastqc -o 00_fastqc_reads SRR5855414.fastq.gz
# fastqc -o 00_fastqc_reads SRR5855413.fastq.gz
# fastqc -o 00_fastqc_reads SRR2952554.fastq.gz
# fastqc -o 00_fastqc_reads SRR5247052.fastq.gz
# fastqc -o 00_fastqc_reads ERR3588763.fastq.gz
# fastqc -o 00_fastqc_reads SRR5891573.fastq.gz
# fastqc -o 00_fastqc_reads SRR10953298.fastq.gz
# fastqc -o 00_fastqc_reads ERR1333181.fastq.gz
# fastqc -o 00_fastqc_reads SRR5459769.fastq.gz
# fastqc -o 00_fastqc_reads SRR6048908.fastq.gz
# fastqc -o 00_fastqc_reads SRR12473531.fastq.gz
# fastqc -o 00_fastqc_reads ERR3192241.fastq.gz
fastqc -o 00_fastqc_reads SRR7528444.fastq.gz
fastqc -o 00_fastqc_reads SRR5216658.fastq.gz
fastqc -o 00_fastqc_reads SRR7428116.fastq.gz
fastqc -o 00_fastqc_reads SRR6266338.fastq.gz
fastqc -o 00_fastqc_reads SRR5829599.fastq.gz
fastqc -o 00_fastqc_reads SRR5468153.fastq.gz

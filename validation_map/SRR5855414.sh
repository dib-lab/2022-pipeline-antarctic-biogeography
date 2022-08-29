#! /bin/bash -login
#SBATCH -p bmm
#SBATCH -J SRR5855414_validmap
#SBATCH -t 20:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=60gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jelumian@ucdavis.edu
#SBATCH -o /home/jemizzi/biogeo/scripts/report/SRR5855414_validmap.out
#SBATCH -e /home/jemizzi/biogeo/scripts/report/SRR5855414_validmap.err

# activate conda
. "/home/jemizzi/miniconda3/etc/profile.d/conda.sh"

# activate mapping env
conda activate biogeo

# set name and match
name="SRR5855414"
match="MP8IB2_171.fa"

# go to a particular directory
cd /home/jemizzi/biogeo/data

# make validation directory
mkdir 02_mapping/${name}_validation

# mapping commands
bowtie2-build ${match} 02_mapping/${name}_validation/${match}_ref

bowtie2 --threads 32 -x 02_mapping/${name}_validation/${match}_ref -r ${name}.fastq.gz -S 02_mapping/${name}_validation/${name}-to-${match}.sam

samtools view -F 4 -bS 02_mapping/${name}_validation/${name}-to-${match}.sam -o 02_mapping/${name}_validation/${name}-to-${match}-RAW.bam

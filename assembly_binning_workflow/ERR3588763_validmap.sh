#! /bin/bash -login
#SBATCH -p bmm
#SBATCH -J ukpig_validmap
#SBATCH -t 20:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=60gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jelumian@ucdavis.edu
#SBATCH -o /home/jemizzi/biogeo/scripts/report/ukpig_validmap.out
#SBATCH -e /home/jemizzi/biogeo/scripts/report/ukpig_validmap.err

# activate conda
. "/home/jemizzi/miniconda3/etc/profile.d/conda.sh"

# activate mapping env
conda activate biogeo

# set name and match
name="ERR3588763"
match="MP8IB2_171.fa"

# go to a particular directory
cd /home/jemizzi/biogeo/data

# make validation directory
mkdir 02_mapping/${name}/validation

# mapping commands
bowtie2-build ${match} 02_mapping/${name}/validation/query_contigs

bowtie2 --threads 32 -x 02_mapping/${name}/validation/query_contigs -r ${name}.fastq.gz -S 02_mapping/${name}/validation/${name}-to-${match}.sam

samtools view -F 4 -bS 02_mapping/${name}/validation/${name}-to-${match}.sam -o 02_mapping/${name}/validation/${name}-to-${match}-RAW.bam

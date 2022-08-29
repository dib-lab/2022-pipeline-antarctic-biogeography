#! /bin/bash -login
#SBATCH -p bmm
#SBATCH -J ukpig_revalidmap
#SBATCH -t 20:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=60gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jelumian@ucdavis.edu
#SBATCH -o /home/jemizzi/biogeo/scripts/report/ukpig_reverse_validmap.out
#SBATCH -e /home/jemizzi/biogeo/scripts/report/ukpig_reverse_validmap.err

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
mkdir 02_mapping/${name}/validation/reverse

# mapping commands
bowtie2-build ${name}.fastq.gz 02_mapping/${name}/validation/reverse/${name}_contigs

bowtie2 --threads 32 -x 02_mapping/${name}/validation/reverse/${name}_contigs -U ${match} -S 02_mapping/${name}/validation/reverse/${match}-to-${name}.sam

samtools view -F 4 -bS 02_mapping/${name}/validation/reverse/${match}-to-${name}.sam -o 02_mapping/${name}/validation/${match}-to-${name}-RAW.bam

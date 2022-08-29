#! /bin/bash -login
#SBATCH -p bmm
#SBATCH -J phorm_ace_asm
#SBATCH -t 60:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=60gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jelumian@ucdavis.edu
#SBATCH -o /home/jemizzi/biogeo/scripts/report/phormidium_ace.out
#SBATCH -e /home/jemizzi/biogeo/scripts/report/phormidium_ace.err

# load fastqc
module load megahit/1.0.6

# go to a particular directory
cd /home/jemizzi/biogeo/data

# set name
name="SRR7528444"

# run will not stop if line fail
set x

# remove directory before running or job will fail then run
rm -fr 01_megahit/${name}
megahit -r ${name}.fastq.gz -o 01_megahit/${name}

# activate conda
. "/home/jemizzi/miniconda3/etc/profile.d/conda.sh"

# activate mapping env
conda activate biogeo

rm -fr 02_mapping/${name}
mkdir 02_mapping/${name}

# mapping commands
bowtie2-build 01_megahit/${name}/final.contigs.fa 02_mapping/${name}/contigs

bowtie2 --threads 32 -x 02_mapping/${name}/contigs --interleaved ${name}.fastq.gz -S 02_mapping/${name}/${name}.sam

samtools view -F 4 -bS 02_mapping/${name}/${name}.sam -o 02_mapping/${name}/${name}-RAW.bam

# activate env
conda activate anvio-7.1

rm -fr 03_binning/${name}
mkdir 03_binning/${name}

# depth commands
anvi-init-bam 02_mapping/${name}/${name}-RAW.bam -o 02_mapping/${name}/${name}.bam

conda activate biogeo

jgi_summarize_bam_contig_depths --outputDepth 03_binning/${name}/depth.txt 02_mapping/${name}/${name}.bam

# switch to metabat env
conda activate biogeo

# metabat2 binning code
metabat2 -i 01_megahit/${name}/final.contigs.fa -a 03_binning/${name}/depth.txt -o 03_binning/${name}

# look at bin quality
rm -rf 03_binning/${name}/checkm_lineage
checkm lineage_wf --reduced_tree -x fa 03_binning/${name} 03_binning/${name}/checkm_lineage


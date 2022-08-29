#! /bin/bash -login
#SBATCH -p bmm
#SBATCH -J arabid
#SBATCH -t 60:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=60gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jelumian@ucdavis.edu
#SBATCH -o /home/jemizzi/biogeo/scripts/report/arabid.out
#SBATCH -e /home/jemizzi/biogeo/scripts/report/arabid.err

# load fastqc
module load megahit/1.0.6

# go to a particular directory
cd /home/jemizzi/biogeo/data

# set name
name="ERR3192241"

# run will not stop if line fail
set x

## ASSEMBLY
# remove directory before running or job will fail then run
rm -fr 01_megahit/${name}
megahit --12 ${name}.fastq.gz -o 01_megahit/${name}

## MAPPING
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

## BINNING
# switch to metabat env
conda activate biogeo

# metabat2 binning code
metabat2 -i 01_megahit/${name}/final.contigs.fa -a 03_binning/${name}/depth.txt -o 03_binning/${name}

# look at bin quality
rm -rf 03_binning/${name}/checkm_lineage
checkm lineage_wf --reduced_tree -x fa 03_binning/${name} 03_binning/${name}/checkm_lineage

## VALIDATION MAPPING
# set name of matching MAG
match="MP8IB2_171.fa"

# make validation directory
mkdir 02_mapping/${name}/validation

# mapping commands
bowtie2-build ${match} 02_mapping/${name}/validation/query_contigs

bowtie2 --threads 32 -x 02_mapping/${name}/validation/query_contigs -r ${name}.fastq.gz -S 02_mapping/${name}/validation/${name}-to-${match}.sam

samtools view -F 4 -bS 02_mapping/${name}/validation/${name}-to-${match}.sam -o 02_mapping/${name}/validation/${name}-to-${match}-RAW.bam

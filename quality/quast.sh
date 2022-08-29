#! /bin/bash -login
#SBATCH -p bmm
#SBATCH -J quast
#SBATCH -t 20:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=60gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jelumian@ucdavis.edu
#SBATCH -o /home/jemizzi/biogeo/scripts/report/quast.out
#SBATCH -e /home/jemizzi/biogeo/scripts/report/quast.err

# activate conda
. "/home/jemizzi/miniconda3/etc/profile.d/conda.sh"

# activate env
conda activate quast

# force to continue if there is an error (such as assembly not found)
set x

# go to a particular directory
cd /home/jemizzi/biogeo/data

quast.py 01_megahit/SRR5216658/final.contigs.fa
quast.py 01_megahit/SRR5891573/final.contigs.fa
quast.py 01_megahit/SRR7528444/final.contigs.fa
quast.py 01_megahit/SRR7428116/final.contigs.fa
quast.py 01_megahit/SRR5459769/final.contigs.fa
quast.py 01_megahit/SRR12473531/final.contigs.fa

#quast.py 01_megahit/ERR3192241/final.contigs.fa
#quast.py 01_megahit/SRR10953298/final.contigs.fa

#for assembly in 01_megahit/*/final.contigs.fa;
#do
#	echo ${assembly}
#	quast.py ${assembly}
#done

#!/bin/bash
#$ -q genomics
#$ -j y
#$ -cwd
#$ -N merge
#$ -l h_vmem=95G
#$ -l virtual_free=30G

. $HOME/.bashrc

export TEMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp
MAXMEM=95

#novosort -t /genefs/MikheyevU/temp -c 5 --compression 1 --tmpcompression 0 -m 95G -i -o merged.bam *realigned.bam

ref=/home/s/sasha/was/final/scf.fa
alias GA="java -Xmx"$MAXMEM"g -Djava.io.tmpdir=/genefs/MikheyevU/temp -jar /apps/MikheyevU/sasha/GATK/GenomeAnalysisTK.jar"
alias picard="java -Xmx"$MAXMEM"g -Djava.io.tmpdir=/genefs/MikheyevU/temp -jar /apps/MikheyevU/picard-tools-1.66/"

 GA \
    -nct 12 \
    -T BaseRecalibrator \
    -I merged.bam  \
    -R $ref \
    -knownSites hq_snps/hq2.vcf \
    -o recal_data.table

 GA \
     -nct 12 \
    -T PrintReads \
    -R $ref  \
    -I $base.realigned.bam  \
    -BQSR recal_data.table \
    -o merged.recal1.bam


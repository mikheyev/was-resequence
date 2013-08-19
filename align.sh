#!/bin/bash
#$ -q long
#$ -j y
#$ -cwd
#$ -N align
#$ -l h_vmem=5G
#$ -l virtual_free=5G

. $HOME/.bashrc
#28 files
#SGE_TASK_ID=2
a=(*1.fastq)
b=(*2.fastq)
f=${a["SGE_TASK_ID"-1]} 
r=${b["SGE_TASK_ID"-1]} 
bowbase=~/was/final/scf
base=$(basename $f _1.fastq)
ref=~/was/final/scf.fa
export TEMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp

alias GA="java -Xmx3g -jar /apps/MikheyevU/sasha/GATK/GenomeAnalysisTK.jar"

#bowtie2 -p 1 --phred33 --sam-rg ID:$base --sam-rg LB:Truseq --sam-rg SM:$base --sam-rg PL:ILLUMINA  -x $bowbase -1 $f -2 $r  | samtools view -Su   - | novosort -t /genefs/MikheyevU/temp -i -o $base.bam -

java -Xmx4g -Djava.io.tmpdir=/genefs/MikheyevU/temp -jar /apps/MikheyevU/picard-tools-1.66/MarkDuplicates.jar METRICS_FILE=$base"_duplicates.txt" ASSUME_SORTED=1 INPUT=$base".bam" OUTPUT=$base"_nodup.bam" TMP_DIR=/genefs/MikheyevU/temp  REMOVE_DUPLICATES=1 MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=500

samtools index $base"_nodup.bam"

GA \
   -I $base"_nodup.bam" \
   -R $ref \
   -T RealignerTargetCreator \
   -o $base"_IndelRealigner.intervals" 

GA  \
   -I $base"_nodup.bam" \
   -R $ref \
   -T IndelRealigner \
   -targetIntervals $base"_IndelRealigner.intervals" \
   --maxReadsInMemory 1000000 \
   --maxReadsForRealignment 100000 \
   -o $base.realigned.bam

samtools index $base.realigned.bam



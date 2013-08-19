#!/bin/bash
#$ -q long
#$ -j y
#$ -cwd
#$ -N was_hct
#$ -l h_vmem=10G
#$ -l virtual_free=10G

. $HOME/.bashrc

export TEMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp
MAXMEM=9

allfiles=$(for i in *realigned.bam; do echo -ne "-I" $i" "; done)
ref=/home/s/sasha/was/final/scf.fa
alias GA="java -Xmx"$MAXMEM"g -Djava.io.tmpdir=/genefs/MikheyevU/temp -jar /apps/MikheyevU/sasha/GATK/GenomeAnalysisTK.jar"
alias picard="java -Xmx"$MAXMEM"g -Djava.io.tmpdir=/genefs/MikheyevU/temp -jar /apps/MikheyevU/picard-tools-1.66/"

#SGE_TASK_ID=2
old_IFS=$IFS
IFS=$'\n'
a=($(cat scaffolds.txt))
IFS=$old_IFS
limit=${a[$SGE_TASK_ID-1]}

GA \
    -T HaplotypeCaller\
    -R $ref \
    $allfiles \
    $limit \
    -A QualByDepth -A RMSMappingQuality -A FisherStrand -A HaplotypeScore -A InbreedingCoeff -A MappingQualityRankSumTest -A Coverage -A ReadPosRankSumTest -A BaseQualityRankSumTest -A ClippingRankSumTest \
    --genotyping_mode DISCOVERY \
    --output_mode EMIT_ALL_CONFIDENT_SITES \
    --heterozygosity 0.005 \
    -stand_call_conf 10 \
    -stand_emit_conf 4 \
    -o test/$SGE_TASK_ID.vcf
#    -o variants/$SGE_TASK_ID.vcf

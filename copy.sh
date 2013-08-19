#!/bin/bash
#$ -q short
#$ -j y
#$ -cwd
#$ -N copy
#$ -l h_vmem=2G
#$ -l virtual_free=2G

. $HOME/.bashrc

export TEMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp

d=(/genefs/SQC/130612_SN1077_0120_BD21KPACXX/Unaligned_SingleIndex/Project_MikheyevU/S*)
sample=${d["SGE_TASK_ID"-1]} 
gunzip -c  $sample/*R1*gz > $(basename $sample)"_1.fastq"
gunzip -c  $sample/*R2*gz > $(basename $sample)"_2.fastq"
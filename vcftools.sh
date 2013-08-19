#!/bin/bash
#$ -q long
#$ -j y
#$ -cwd
#$ -l h_vmem=4G
#$ -l virtual_free=4G
#$ -N fst
. $HOME/.bashrc
export TEMPDIR=/genefs/MikheyevU/temp
export TMPDIR=/genefs/MikheyevU/temp
export TEMP=/genefs/MikheyevU/temp
export TMP=/genefs/MikheyevU/temp

#(head -77784 raw.vcf ; awk '$0!~/^#/ && $6>=20 && $9=="GT:AD:GQ:PL"' raw.vcf) > variants.vcf 
#vcftools --vcf variants.vcf --minGQ 13 --geno 0.85 --out dna --keep  dna_samples.txt --recode
#vcftools --vcf dna.recode.vcf --geno 0.85 --out dna2 --recode
#python vcf2fasta.py tab.txt > was.fasta
#vcftools --vcf dna2.recode.vcf --keep sexqueens.txt --counts --out sexqueen
vcftools --vcf dna2.recode.vcf --out fst  --weir-fst-pop clonqueen.txt --weir-fst-pop  sexqueens.txt

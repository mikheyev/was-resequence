from Bio import SeqIO,Seq
from textwrap import fill
import sys,pdb
from collections import defaultdict
#takes tab and converts it into fasta
#first row contains column names

iupac = {
'G/G' : 'G',
'C/C' : 'C',
'T/T' : 'T',
'A/A' : 'A',
'G/T' : 'K',
'T/G' : 'K',
'A/C' : 'M',
'C/A' : 'M',
'C/G' : 'S',
'G/C' : 'S',
'A/G' : 'R',
'G/A' : 'R',
'A/T' : 'W',
'T/A' : 'W',
'C/T' : 'Y',
'T/C' : 'Y',
'./.' : 'N',
}

skipsamples = map(lambda x: x+3,[0,2,8])

outseq = defaultdict(str)

infile = open(sys.argv[1])
names = infile.next().split()
for line in infile:
	line = line.split()
	if len(line[2]) == 1:
		for i in range(3,len(line)):
			if len(line[i].split(":")[0]) != 3:
				break
		else:
			for i in range(3,len(line)):
				if i in skipsamples:
					continue
				gt = line[i].split(":")[0]
				outseq[names[i-3]]+=iupac[gt]


for i in outseq:
	print ">"+i
	print fill(outseq[i])
from __future__ import division
from scipy.stats import fisher_exact
from Bio import SeqIO
import itertools,pdb

def swap(a,b):
    temp=a
    a=b
    b=temp
    return a,b
clonin = open("clonqueen.frq.count")
sexin = open("sexqueen.frq.count")
clonin.next()
sexin.next()
for (clon,sex) in itertools.izip(clonin,sexin):
    (clon1,clon2)=clon.split()[4:6]
    (sex1,sex2)=sex.split()[4:6]
    o1 = int(clon1.split(":")[1])
    o2 = int(clon2.split(":")[1])
    m1 = int(sex1.split(":")[1])
    m2 = int(sex2.split(":")[1])

#    if clon[4].split(":")[0] != ref:
#        (m1,m2) = swap(m1,m2)
#    pdb.set_trace()
    try:
        fisher = fisher_exact([[o1,m1],[o2,m2]])[1]
    except:
        continue
    print clon.split()[0],clon.split()[1],fisher,sum([m1,m2,o1,o2])
    



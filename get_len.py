from Bio import SeqIO

print "scaf,size"
for rec in SeqIO.parse("/home/s/sasha//was/final/scf.fa","fasta"):
    print "%s,%s" % (rec.id, len(rec.seq))
    

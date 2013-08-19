import sets,pdb
for line in open("hq.vcf"):
    if line[0] == "#":
        print line
        continue
    line = line.rstrip().split()
    if 'GQ' not in line[8].split(":"):
        continue
    gq = line[8].split(":").index('GQ')
    goodGT = []
    for i in range(9,13):
        gt = line[i].split(":")
        if gt[0]=="./." or int(gt[gq]) < 13:
            gt[0] = "./."
        else:
            goodGT.append(gt[0])
        line[i] = ":".join(gt)
    if len(set(goodGT)) == 1 and len(goodGT) >=2 and '0/0' not in goodGT:
        if float(line[5])>=20:
            print "\t".join(line)


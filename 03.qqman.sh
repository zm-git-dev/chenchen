# install.packages("qqman")
library(qqman)
#add files
dat_fs_1 <- read.csv('FS_E1/MVP.V17.GLM.csv',header = T)
head(dat_fs_1)
##########################
data <- dat_fs_1 [,c(1,2,3,6)]
#
head(data)
data <- na.omit(data)
#
#
Gh.chr=c("A1","A2","A3","A4","A5","A6","A7","A8","A9","A10","A11","A12","A13","D1","D2","D3","D4","D5","D6","D7","D8","D9","D10","D11","D12","D13")
Gh.chr.number=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26)
######
chr.dat <-data.frame(Gh.chr,Gh.chr.number)
head(chr.dat)
names(chr.dat) <-c("CHROM","ID")
############
############
cc <- merge(data,chr.dat, by = 'CHROM')
head(cc)
#
dat.cc <- cc[,c(2,5,3,4)]
head(dat.cc)
names(dat.cc)<-c("SNP","CHR","BP","P")
###########
head(dat.cc)
##########
manhattan(dat.cc, chr = "CHR", bp = "BP", p = "P", snp = "SNP",
          col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
          highlight = NULL, logp = TRUE, annotatePval = NULL,
          annotateTop = TRUE)
#############
manhattan(dat.cc,chr = "CHR", bp = "BP", p = "P", snp = "SNP",
          col = c("blue4", "orange3"), 
          chrlabs = c("A01","A02","A03","A04","A05","A06","A07","A08","A09","A10","A11","A12","A13","D01","D02","D03","D04","D05","D06","D07","D08","D09","D10","D11","D12","D13"))
#############
manhattan(dat.cc,chr = "CHR", bp = "BP", p = "P", snp = "SNP",
          col = c("blue4", "orange3"), 
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
          chrlabs = c("A01","A02","A03","A04","A05","A06","A07","A08","A09","A10","A11","A12","A13","D01","D02","D03","D04","D05","D06","D07","D08","D09","D10","D11","D12","D13"))
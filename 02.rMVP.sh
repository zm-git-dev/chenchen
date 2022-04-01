#rm(list=ls()); gc();
#install.packages('rMVP')
#
library(rMVP)
MVP.Data(filePhe = "FSBLUPs.phe", fileVCF = "cy_0.05.ree2.vcf", out = "FSBLUPs")
# Step1
MVP.Data(filePhe = "FSBLUPs.phe", fileVCF = "cy_0.05.ree2.vcf", out = "FSBLUPs")

# Step2
pheno <- read.table("FSBLUPs.phe", header = TRUE)
geno  <- attach.big.matrix("FSBLUPs.geno.desc")
map   <- read.table("FSBLUPs.geno.map", header = TRUE)
# Step3
imMVP <- MVP(
    phe=pheno,
    geno=geno,
    map=map,
    method=c("GLM", "MLM", "FarmCPU")
)

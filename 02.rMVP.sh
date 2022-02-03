#rm(list=ls()); gc();
#install.packages('rMVP')
#
library(rMVP)
MVP.Data(filePhe = "FSBLUPs.phe", fileVCF = "cy_0.05.ree2.vcf", out = "FSBLUPs")
# Step1: 数据格式转换
MVP.Data(filePhe = "FSBLUPs.phe", fileVCF = "cy_0.05.ree2.vcf", out = "FSBLUPs")

# Step2: 读取转换好的数据
pheno <- read.table("FSBLUPs.phe", header = TRUE)       # 表型文件中第一列为个体 ID，第二列是要分析的性状
geno  <- attach.big.matrix("FSBLUPs.geno.desc")         # rMVP 使用的基因型文件是 .geno.desc 和 .geno.bin 两个文件一组，前者储存的是元数据，后者是以二进制格式储存的基因型数据。
map   <- read.table("FSBLUPs.geno.map", header = TRUE)  # map 文件中存储的是标记的位置信息

# Step3: 进行分析
imMVP <- MVP(
    phe=pheno,
    geno=geno,
    map=map,
    method=c("GLM", "MLM", "FarmCPU")                # 模型可以设置多个同时进行分析。
)

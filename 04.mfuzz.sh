options()$repos 
options()$BioC_mirror
options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
options("repos" = c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options()$repos 
options()$BioC_mirror
#add mfuzz
library(Mfuzz)
data<-read.table("fpkm.txt",sep="\t",header=T,row.names = 1)
data=na.omit(data)
data=data[rowSums(abs(data))!=0,]
#
count<-as.matrix(data)##L22.filber

# Mfuzz -------------------------------------------------------------------
if(T){
  eset <- new ("ExpressionSet",exprs = count)
  mydata.r <- filter.NA(eset, thres = 0.25)
  mydata.f <- fill.NA(mydata.r, mode ="mean")
  tmp <- filter.std(mydata.f, min.std =0.1)
  mydata.s <- standardise(tmp)
  c <- 12
  m <- mestimate(mydata.s)
  m
  tmp <-cselection(mydata.s,m=1.33,crange=seq(5,40,5),repeats=5,visu=TRUE)
  cl <- mfuzz(mydata.s, c = c, m =m)
}
pdf(file='mfuzz.TM-1.pdf')
mfuzz.plot2(mydata.s, cl = cl, mfrow =c(4,3), xlab="Period",
            ylab="Exp",colo="fancy", ax.col="red", col.sub = "blue", x11 = FALSE, col = "blue")

dev.off()



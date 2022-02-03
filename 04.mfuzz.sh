options()$repos 
options()$BioC_mirror
options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
options("repos" = c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options()$repos 
options()$BioC_mirror
#add mfuzz
library(Mfuzz)
#
data<-read.table("fpkm.txt",sep="\t",header=T,row.names = 1)
#
data=na.omit(data)#去掉含有NA的数据
#去除全部为0的行
data=data[rowSums(abs(data))!=0,]
#
count<-as.matrix(data)##L22.filber

# Mfuzz -------------------------------------------------------------------
#使用Mfuzz进行时间序列表达模式聚类分析
if(T){
  eset <- new ("ExpressionSet",exprs = count)# 构建Mfuzz所需要的ExpressionSet对象
  #View(eset)
  ## 过滤数据 ##
  mydata.r <- filter.NA(eset, thres = 0.25)# 表达值在25%的样本中缺失，则丢掉该基因
  mydata.f <- fill.NA(mydata.r, mode ="mean") # 剩余的缺失值用该基因的表达均值来代替
  tmp <- filter.std(mydata.f, min.std =0.1) # 丢掉表达值变化不大的基因，如house-keeping
  mydata.s <- standardise(tmp) # 基因的表达值被标准化到0-1之间
  # 根据我的经验，这一步可能产生新的NA，导致下面的步骤报错，解决方法之一就是重新# 运行上面的过滤步骤，把筛选参数变得更严格，尽量去掉噪音基因
  #参数为希望最终得到的聚类的个数，这个参数由我们直接指定
  c <- 12
  ## 筛选聚类参数 ##
  m <- mestimate(mydata.s)
  m # 计算平滑因子m的值
  tmp <-cselection(mydata.s,m=1.33,crange=seq(5,40,5),repeats=5,visu=TRUE)
  # 计算c值，即该数据应该聚多少类
  # 如下图，X与红线分离的x轴，就是c值，（因为输入文件没有规律，下图未出现分离）
  ## 软聚类 ##
  cl <- mfuzz(mydata.s, c = c, m =m) #上面已计算出c与m，该步计算聚类的结果
}

#聚类的结果太多，可能报错：画板太大，无法展示图片。
pdf(file='mfuzz.TM-1.pdf')
mfuzz.plot2(mydata.s, cl = cl, mfrow =c(4,3), xlab="Period",
            ylab="Exp",colo="fancy", ax.col="red", col.sub = "blue", x11 = FALSE, col = "blue")

dev.off()



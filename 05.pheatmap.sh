library(pheatmap)
#
G1 <- read.csv('hub gene 50.csv',sep = ',',header=T,row.names = 1)

group<-read.csv('group.L22.L343.fpkm.hub(1).csv',row.names = 1,sep = ',',header = T)
#
pheatmap(G1, scale = "row", clustering_distance_rows = "correlation",
         cluster_cols = F,cluster_rows = F,treeheight_row = 30,
         annotation_col = group,color = colorRampPalette(c("blue", "white", "firebrick3"))(50))
##########


rep = list.files(pattern=".div.bed",full.names=TRUE)
library("ggpubr")
pdf("Figure_S10.pdf",height=10,width=20)
for (i in rep){
a <- read.table(file=i,header=F)
repclass <- gsub("_"," ",sapply(strsplit(sapply(strsplit(sapply(strsplit(i,"[/]"),`[`,2),"[.]",1),`[`,1),"[.]"),`[`,1))
p <- ggboxplot(a,x="V1",y="V5",fill="red",colour="black",xlab="Atomic Interval",ylab="Percent Divergence")+stat_compare_means(label.x.npc = 0.5)
P <- ggpar(p, font.x = c(14, "bold"),font.y = c(14, "bold"),font.main = c(18,"bold.italic"))
print(P+ggtitle(repclass))
}
dev.off()


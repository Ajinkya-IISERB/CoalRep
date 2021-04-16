rep = list.files(pattern=".cov.tmp.bed",full.names=TRUE)
library(reshape2)
library("ggpubr")
pdf("Figure_S1.pdf",height=15,width=20,onefile=TRUE)
for (i in rep){
a <- read.table(file=i,header=T)
repclass <- gsub("_"," ",sapply(strsplit(sapply(strsplit(sapply(strsplit(i,"[/]"),`[`,2),"[.]",1),`[`,1),"[.]"),`[`,1))
melt(a,id.var=c("Scaffold","Atomic_Interval"))->df
my_comparisons <- list( c("CALLABLE", "POORLY_MAPPED"), c("CALLABLE", "NO_COVERAGE"), c("CALLABLE", "LOW_COVERAGE"), c("CALLABLE","REF_N") )
p <- ggboxplot(df, x = "variable", y = "value", fill = "variable", palette = "jco", facet.by = "Atomic_Interval", short.panel.labs = FALSE,ylab="Fraction of sites")+labs(fill="Callability class")
P <- p + stat_compare_means(comparisons = my_comparisons,label =  "p.signif")+ stat_compare_means(label =  "p.signif",label.x.npc = 0.5,label.y.npc=0.5)
pl <- ggpar(P, ylim = c(0,1.5),xlab=FALSE,legend = "right",font.y = c(14, "bold"),font.legend = c(14, "bold"),font.main = c(18,"bold.italic"))
Pl <- pl + rremove("x.text")
print(Pl+ggtitle(repclass))
}
dev.off()


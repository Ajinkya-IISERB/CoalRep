rep = list.files(pattern=".autosomes_AFS_50.20",full.names=TRUE)
pdf("Figure_S2.pdf",onefile=TRUE)
repclass <- unique(sapply(strsplit(sapply(strsplit(sapply(strsplit(rep,"[/]"),`[`,2),"[.]",1),`[`,1),"[.]"),`[`,1))
for (i in repclass){
read.table(paste(i,".rc.ALL.autosomes_AFS_50.20",sep=""))->AF20
read.table(paste(i,".rc.ALL.autosomes_AFS_50.40",sep=""))->AF40
read.table(paste(i,".rc.ALL.autosomes_AFS_50.60",sep=""))->AF60
read.table(paste(i,".rc.ALL.autosomes_AFS_50.80",sep=""))->AF80
as.data.frame(table(round(AF20$V1,1)))-> A20
as.data.frame(table(round(AF40$V1,1)))-> A40
as.data.frame(table(round(AF60$V1,1)))-> A60
as.data.frame(table(round(AF80$V1,1)))-> A80
data.frame(Q20=A20$Freq,Q40=A40$Freq,Q60=A60$Freq,Q80=A80$Freq)-> q
library(plyr)
library(ggplot2)
library(reshape2)
Names=seq(0,0.5,0.1)
data=data.frame(cbind(q),Names)
data.m <- melt(data, id.vars='Names')
cbbPalette <- c("#000000","#E69F00","#56B4E9","#009E73","F0E442","#007282")
P <- ggplot(data.m,aes(Names,value,fill= variable))+geom_bar(stat="identity",position="dodge")+labs(x="Allele Frequency Bin",y="Number of Sites",fill="Quality")
print(P+ggtitle(i))
}
dev.off()


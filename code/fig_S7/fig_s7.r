a <- read.table("populus_all.hets")
a$allhet <- a$V5/a$V6
a$nonrephet <- a$V10/(a$V6-a$V15)
a$allhet - a$nonrephet -> a$hetdiff
data.frame(AI=c(a$V1,a$V1),Het=c(a$allhet,a$nonrephet),Class=c(rep("All",length(a$allhet)),rep("Nonrep",length(a$nonrephet))))-> b
data.frame(AI=a$V1,Het=a$allhet,Class=rep("All",length(a$allhet)))-> wr
data.frame(AI=a$V1,Het=a$nonrephet,Class=rep("Nonrep",length(a$nonrephet)))-> nr
ma <- c()
for (i in unique(wr$AI)){
wr[wr$AI==i,]->z
c(ma,mean(z$Het))-> ma
}
cor.test(unique(wr$AI),ma,method="kendall")

pdf("Figure_S7A.pdf",height=20,width=40)
boxplot(b$Het~b$Class*b$AI,outline=FALSE,col=c("red","blue"),las=2,par(mar=c(15,12,4,2)+ 0.1),frame.plot=2,cex.axis=2,xlab="",ylab="",font=2)
mtext("Atomic Intervals",side = 1, line = 13, cex = 3, font = 2)
mtext("Percent Heterozygosity",side = 2, line = 7, cex = 3, font = 2)
seq(2.5,150,2)->vl
for(i in vl){
abline(v=i,col="red",lty=2)
}
legend("top",legend=c("Kendall's rank correlation tau","Tau = 0.7707391, p-value = 7.343e-16"),cex=3,text.font=2,bg="white")
counter=-0.6
for (i in sort(unique(b$AI))){
b[b$AI==i,]->z
z[z$Class=="All",]-> un
z[z$Class=="Nonrep",]-> hm
counter=counter+2
if ((length(un$Het) > 1) && (length(hm$Het) > 1)){
wilcox.test(un$Het,hm$het,alternative="greater")-> x
if (x$p.value > 0.05){
text(counter,0.025,labels="ns",cex=3,font=2)
} else {
text(counter,0.025,labels="*",cex=3,font=2)
}
} else {
text(counter,0.025,labels="nt",cex=3,font=2)
}
}
legend("topleft",legend=c("Unmasked","Masked"),fill=c("red","blue"),cex=3,text.font=2,bg="white")
dev.off()


a <- read.table("human_all.hets")
a$allhet <- a$V5/a$V6
a$nonrephet <- a$V10/(a$V6-a$V15)
a$allhet - a$nonrephet -> a$hetdiff
data.frame(AI=c(a$V1,a$V1),Het=c(a$allhet,a$nonrephet),Class=c(rep("All",length(a$allhet)),rep("Nonrep",length(a$nonrephet))))-> b
data.frame(AI=a$V1,Het=a$allhet,Class=rep("All",length(a$allhet)))-> wr
data.frame(AI=a$V1,Het=a$nonrephet,Class=rep("Nonrep",length(a$nonrephet)))-> nr
ma <- c()
for (i in unique(wr$AI)){
wr[wr$AI==i,]->z
c(ma,mean(z$Het))-> ma
}
cor.test(unique(wr$AI),ma,method="kendall")

pdf("Figure_S7B.pdf",height=20,width=40)
boxplot(b$Het~b$Class*b$AI,outline=FALSE,col=c("red","blue"),las=2,par(mar=c(15,12,4,2)+ 0.1),frame.plot=2,cex.axis=2,xlab="",ylab="",font=2)
mtext("Atomic Intervals",side = 1, line = 13, cex = 3, font = 2)
mtext("Percent Heterozygosity",side = 2, line = 7, cex = 3, font = 2)
seq(2.5,150,2)->vl
for(i in vl){
abline(v=i,col="red",lty=2)
}
legend("top",legend=c("Kendall's rank correlation tau","Tau = 0.9332498,  p-value < 2.2e-16"),cex=3,text.font=2,bg="white")
counter=-0.6
for (i in sort(unique(b$AI))){
b[b$AI==i,]->z
z[z$Class=="All",]-> un
z[z$Class=="Nonrep",]-> hm
counter=counter+2
if ((length(un$Het) > 1) && (length(hm$Het) > 1)){
wilcox.test(un$Het,hm$het,alternative="greater")-> x
if (x$p.value > 0.05){
text(counter,0.017,labels="ns",cex=3,font=2)
} else {
text(counter,0.017,labels="*",cex=3,font=2)
}
} else {
text(counter,0.017,labels="nt",cex=3,font=2)
}
}
legend("topleft",legend=c("Unmasked","Masked"),fill=c("red","blue"),cex=3,text.font=2,bg="white")
dev.off()


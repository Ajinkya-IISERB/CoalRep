read.table(file="pt.PT_test2.hm.s100.int.lengths")->hm
read.table(file="pt.PT_test2.un.s100.int.lengths")->un
data.frame(AI=c(hm$V1,un$V1),Length=c(hm$V2,un$V2),Class=c(rep("hm",length(hm$V1)),rep("un",length(un$V1))))->b
data.frame(AI=un$V1,Length=un$V2,Class=rep("un",length(un$V1)))->u
data.frame(AI=hm$V1,Length=hm$V2,Class=rep("hm",length(hm$V1)))->r
ma <- c()
for (i in unique(u$AI)){
u[u$AI==i,]->z
c(ma,mean(z$Length))-> ma
}
cor.test(unique(u$AI),ma,method="kendall")

pdf("Figure_S8A.pdf",height=20,width=50)
boxplot(b$Length~b$Class*b$AI,outline=FALSE,col=c("blue","red"),las=2,par(mar=c(15,12,4,2)+ 0.1),ylim=c(100,2000000),frame.plot=2,cex.axis=2,xlab="",ylab="",font=2,log="y")
mtext("Atomic Intervals",side = 1, line = 7, cex = 3, font = 2)
mtext("Lengths of genomic regions",side = 2, line = 7, cex = 3, font = 2)
seq(2.5,150,2)->vl
for(i in vl){
abline(v=i,col="red",lty=2)
}
wilcox.test(u$Length,r$Length) -> wt
legend("top",inset=0.25,legend=c("Kendall's rank correlation tau","Tau = -0.800905,  p-value < 2.2e-16"),cex=3,text.font=2,bg="white")
counter=-0.6
for (i in sort(unique(b$AI))){
b[b$AI==i,]->z
z[z$Class=="un",]-> un
z[z$Class=="hm",]-> hm
counter=counter+2
if ((length(un$Length) > 1) && (length(hm$Length) > 1)){
wilcox.test(un$Length,hm$Length,alternative="less")-> x
if (x$p.value > 0.05){
text(counter,800000,labels="ns",cex=3,font=2)
} else {
text(counter,800000,labels="*",cex=5,font=2,col="red")
}
} else {
text(counter,800000,labels="nt",cex=3,font=2)
}
}
legend("topright",legend=c("Unmasked","Masked"),fill=c("red","blue"),cex=3,text.font=2,bg="white")

counter=-0.6
for (i in sort(unique(b$AI))){
b[b$AI==i,]->z
z[z$Class=="un",]-> un
z[z$Class=="hm",]-> hm
counter=counter+2
if ((length(un$Length) > 1) && (length(hm$Length) > 1)){
wilcox.test(un$Length,hm$Length,alternative="greater")-> x
if (x$p.value > 0.05){
text(counter,600000,labels="ns",cex=3,font=2)
} else {
text(counter,600000,labels="*",cex=5,font=2,col="blue")
}
} else {
text(counter,600000,labels="nt",cex=3,font=2)
}
}
legend("topright",legend=c("Unmasked","Masked"),fill=c("red","blue"),cex=3,text.font=2,bg="white")
dev.off()

#human
read.table(file="NA12878.hm.1000g.int.lengths")->hm
read.table(file="NA12878.un.1000g.int.lengths")->un
data.frame(AI=c(hm$V1,un$V1),Length=c(hm$V2,un$V2),Class=c(rep("hm",length(hm$V1)),rep("un",length(un$V1))))->b
data.frame(AI=un$V1,Length=un$V2,Class=rep("un",length(un$V1)))->u
data.frame(AI=hm$V1,Length=hm$V2,Class=rep("hm",length(hm$V1)))->r

ma <- c()
for (i in unique(u$AI)){
u[u$AI==i,]->z
c(ma,mean(z$Length))-> ma
}
cor.test(unique(u$AI),ma,method="kendall")

pdf("Figure_S8B.pdf",height=20,width=50)
boxplot(b$Length~b$Class*b$AI,outline=FALSE,col=c("blue","red"),las=2,par(mar=c(15,12,4,2)+ 0.1),ylim=c(100,8000000),frame.plot=2,cex.axis=2,xlab="",ylab="",font=2,log="y")
mtext("Atomic Intervals",side = 1, line = 7, cex = 3, font = 2)
mtext("Lengths of genomic regions",side = 2, line = 7, cex = 3, font = 2)
seq(2.5,150,2)->vl
for(i in vl){
abline(v=i,col="red",lty=2)
}
wilcox.test(u$Length,r$Length) -> wt
legend("top",inset=0.25,legend=c("Kendall's rank correlation tau","Tau = -0.800905,  p-value < 2.2e-16"),cex=3,text.font=2,bg="white")
counter=-0.6
for (i in sort(unique(b$AI))){
b[b$AI==i,]->z
z[z$Class=="un",]-> un
z[z$Class=="hm",]-> hm
counter=counter+2
if ((length(un$Length) > 1) && (length(hm$Length) > 1)){
wilcox.test(un$Length,hm$Length,alternative="less")-> x
if (x$p.value > 0.05){
text(counter,2800000,labels="ns",cex=3,font=2)
} else {
text(counter,2800000,labels="*",cex=5,font=2,col="red")
}
} else {
text(counter,2800000,labels="nt",cex=3,font=2)
}
}
legend("topright",legend=c("Unmasked","Masked"),fill=c("red","blue"),cex=3,text.font=2,bg="white")

counter=-0.6
for (i in sort(unique(b$AI))){
b[b$AI==i,]->z
z[z$Class=="un",]-> un
z[z$Class=="hm",]-> hm
counter=counter+2
if ((length(un$Length) > 1) && (length(hm$Length) > 1)){
wilcox.test(un$Length,hm$Length,alternative="greater")-> x
if (x$p.value > 0.05){
text(counter,2000000,labels="ns",cex=3,font=2)
} else {
text(counter,2000000,labels="*",cex=5,font=2,col="blue")
}
} else {
text(counter,2000000,labels="nt",cex=3,font=2)
}
}
legend("topright",legend=c("Unmasked","Masked"),fill=c("red","blue"),cex=3,text.font=2,bg="white")
dev.off()


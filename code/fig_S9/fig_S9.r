O_s100 <- read.table("pt.PT_test2.rep.profile.head",header=TRUE)
N_s100 <- O_s100[is.finite(O_s100$Ts.Tv_ratio),]
N_s100 <- N_s100[is.finite(N_s100$Hety_percent),]
M_s100 <- N_s100[order(N_s100$Atomic_Interval),]
pdf("Figure_S9.pdf",height=15,width=20)
par(mfrow=c(4,5))
N <- O_s100[is.finite(O_s100$Ts.Tv_ratio),]
N <- N[is.finite(N$Hety_percent),]
M <- N[order(N$Atomic_Interval),]
colcount<-1
for (repclass in unique(M$Repeatclass)) {
colcount<-colcount+1
par(mar = c(6, 5.2, 4, 6))
plot(M$Atomic_Interval[M$Repeatclass==repclass],M$Hety_percent[M$Repeatclass==repclass],axes=FALSE,ylim=c(0,max(M$Hety_percent[M$Repeatclass==repclass],na.rm=TRUE)),xlim=c(0,max(M$Atomic_Interval[M$Repeatclass==repclass],na.rm=TRUE)),type="l",lwd=3,main=gsub("_"," ",repclass),xlab="Atomic Interval",ylab="",col="black",cex.main=2,cex.axis=1.5,font.axis=2,cex=1.5,font.lab=2,cex.lab=2,font=2)
axis(1, xlim=c(0,max(M$Atomic_Interval[M$Repeatclass==repclass],na.rm=TRUE)),col="black",las=1,cex.lab=1.5,font.lab=2,cex.axis=1.5,font.axis=2)
axis(2, ylim=c(0,max(M$Hety_percent[M$Repeatclass==repclass],na.rm=TRUE)),col="black",las=1,cex.lab=1.5,font.lab=2,cex.axis=1.5,font.axis=2)
mtext("hety %",side=2,line=3,cex=1.5,font=2)
box()
par(new=TRUE)
plot(M$Atomic_Interval[M$Repeatclass==repclass],M$Ts.Tv_ratio[M$Repeatclass==repclass],axes=FALSE,ylim=c(0,max(M$Ts.Tv_ratio[M$Repeatclass==repclass],na.rm=TRUE)),type="l",lwd=3,xlab="",ylab="",col="red",cex.main=2,cex.axis=1.5,cex=1.5,font.lab=2,cex.lab=1.5,font=2)
mtext("Ts/Tv",side=4,col="red",line=3.5,cex=1.5,font=2)
axis(4, ylim=c(0,max(M$Ts.Tv_ratio[M$Repeatclass==repclass]),na.rm=TRUE),col="red",col.axis="red",las=1,cex.lab=1.5,font.lab=2,cex.axis=1.5,font.axis=2)
}
dev.off()


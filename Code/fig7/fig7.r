O_s100 <- read.table("pt.PT_test2.rep.profile.head",header=TRUE)
N_s100 <- O_s100[is.finite(O_s100$Ts.Tv_ratio),]
N_s100 <- N_s100[is.finite(N_s100$Hety_percent),]
M_s100 <- N_s100[order(N_s100$Atomic_Interval),]
pdf("Figure_7.pdf",height=15,width=20)
par(mfrow=c(4,5))
N <- O_s100[is.finite(O_s100$Ts.Tv_ratio),]
N <- N[is.finite(N$Hety_percent),]
M <- N[order(N$Atomic_Interval),]
colcount<-1
for (repclass in unique(M$Repeatclass)) {
colcount<-colcount+1
par(mar = c(6, 4, 4, 6))
plot(M$Atomic_Interval[M$Repeatclass==repclass],M$Hety_percent[M$Repeatclass==repclass],axes=FALSE,ylim=c(0,max(M$Hety_percent[M$Repeatclass==repclass],na.rm=TRUE)),xlim=c(0,max(M$Atomic_Interval[M$Repeatclass==repclass],na.rm=TRUE)),type="l",main=repclass,xlab="Atomic Interval",ylab="",col="black")
axis(1, xlim=c(0,max(M$Atomic_Interval[M$Repeatclass==repclass],na.rm=TRUE)),col="black",las=1)
axis(2, ylim=c(0,max(M$Hety_percent[M$Repeatclass==repclass],na.rm=TRUE)),col="black",las=1)
mtext("hety %",side=2,line=2.5)
box()
par(new=TRUE)
plot(M$Atomic_Interval[M$Repeatclass==repclass],M$Ts.Tv_ratio[M$Repeatclass==repclass],axes=FALSE,ylim=c(0,max(M$Ts.Tv_ratio[M$Repeatclass==repclass],na.rm=TRUE)),type="l",xlab="",ylab="",col="red")
mtext("Ts/Tv",side=4,col="red",line=2.5)
axis(4, ylim=c(0,max(M$Ts.Tv_ratio[M$Repeatclass==repclass]),na.rm=TRUE),col="red",col.axis="red",las=1)
}
dev.off()


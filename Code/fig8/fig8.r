hm <- read.table("pt.PT_test2.hm.s100.0.txt")
rep = list.files(pattern=".rep_int.txt",full.names=TRUE)
pdf("Figure_8.pdf",height=15,width=20)
par(mfrow=c(4,5))
for (i in rep){
read.table(file=i,header=FALSE)-> R
repclass <- sapply(strsplit(sapply(strsplit(i,"[.]"),`[`,2),"[/]"), `[`, 2)
Q <- data.frame(hm$V2,R$V4)
Q[Q$R.V4>0,]-> S
reg <- lm(S$R.V4~S$hm.V2)
coeff <- coefficients(reg)
eq <- paste0("y = ", round(coeff[2],1), " x ", round(coeff[1],1))
ken <- cor.test(S$R.V4,S$hm.V2,method="kendall")
tau <- paste0("Tau = ",ken$estimate)
pval <- paste0("P-value = ", ken$p.value)
plot(S$R.V4~S$hm.V2,xlab="Masked Ne Estimate",ylab="Repeat Content in %",pch=20,main=repclass)
abline(reg, col="blue",lwd=2,lty=4)
text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 4, labels=eq, srt=0.2, col = "red")
text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 6, labels=tau, col = "red")
text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 8, labels=pval, col = "red")
}
dev.off()

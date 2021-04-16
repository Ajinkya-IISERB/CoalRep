hm <- read.table("pt.PT_test2.hm.s100.0.txt")
rep = list.files(pattern=".rep_int.txt",full.names=TRUE)
pdf("Figure_S11.pdf",height=15,width=20)
par(mfrow=c(4,5))
for (i in rep){
read.table(file=i,header=FALSE)-> R
repclass <- gsub("_"," ",sapply(strsplit(sapply(strsplit(i,"[.]"),`[`,2),"[/]"), `[`, 2))
Q <- data.frame(hm$V2,R$V4)
Q[Q$R.V4>0,]-> S
reg <- lm(S$R.V4~S$hm.V2)
coeff <- coefficients(reg)
eq <- paste0("y = ", round(coeff[2],1), " x ", round(coeff[1],1))
ken <- cor.test(S$R.V4,S$hm.V2,method="kendall")
tau <- paste0("Tau = ",round(ken$estimate,2))
pval <- paste0("P-value = ", formatC(ken$p.value,format="e",digits=1))
par(mar = c(6, 5.2, 4, 4))
plot(S$R.V4~S$hm.V2,xlab="Masked Ne Estimate",ylab="Repeat Content in %",pch=20,main=gsub("_"," ",repclass),cex.main=2,cex.axis=1.5,cex=1.5,font.lab=2,cex.lab=2,font=2)
abline(reg, col="blue",lwd=2,lty=4)
text(min(S$hm.V2)+0.9,0.2*max(S$R.V4) + 6, labels=tau, col = "red",cex=2,font=2)
text(min(S$hm.V2)+0.9,0.2*max(S$R.V4) + 10, labels=pval, col = "red",cex=2,font=2)
}
dev.off()

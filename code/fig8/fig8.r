hm <- read.table("pt.PT_test2.hm.s100.0.txt")
rep = c("LTR_Gypsy.rep_int.txt","LTR_Copia.rep_int.txt","LTR_Caulimovirus.rep_int.txt","RC_Helitron.rep_int.txt")
pdf("Figure_8.pdf",height=15,width=20)
hm <- read.table("pt.PT_test2.hm.s100.0.txt")
par(mar = c(8.1,6.1, 3.1, 3.1))
par(mfrow=c(2,2))
read.table("LTR_Gypsy.rep_int.txt",header=FALSE)-> R
repclass <- sapply(strsplit("LTR_Gypsy.rep_int.txt","[.]"),`[`,1)
Q <- data.frame(hm$V2,R$V4)
Q[Q$R.V4>0,]-> S
reg <- lm(S$R.V4~S$hm.V2)
coeff <- coefficients(reg)
eq <- paste0("y = ", round(coeff[2],1), " x ", round(coeff[1],1))
ken <- cor.test(S$R.V4,S$hm.V2,method="kendall")
tau <- paste0("Tau = ",round(ken$estimate,2))
pval <- paste0("P-value = ", round(ken$p.value,3))
plot(S$R.V4~S$hm.V2,xlab="Masked Ne Estimate",ylab="Repeat Content in %",pch=20,main="LTR Gypsy",cex.main=2,cex.axis=1.5,cex=1.5,font.lab=2,cex.lab=1.5,font=2)
abline(reg, col="blue",lwd=2,lty=4)
text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 6, labels=paste(tau,"(*)",sep=" "),col = "red",cex=2,font=2)

read.table("LTR_Copia.rep_int.txt",header=FALSE)-> R
repclass <- sapply(strsplit("LTR_Copia.rep_int.txt","[.]"),`[`,1)
Q <- data.frame(hm$V2,R$V4)
Q[Q$R.V4>0,]-> S
reg <- lm(S$R.V4~S$hm.V2)
coeff <- coefficients(reg)
eq <- paste0("y = ", round(coeff[2],1), " x ", round(coeff[1],1))
ken <- cor.test(S$R.V4,S$hm.V2,method="kendall")
tau <- paste0("Tau = ",round(ken$estimate,2))
pval <- paste0("P-value = ", round(ken$p.value,3))
plot(S$R.V4~S$hm.V2,xlab="Masked Ne Estimate",ylab="Repeat Content in %",pch=20,main="LTR Copia",cex.main=2,cex.axis=1.5,cex=1.5,font.lab=2,cex.lab=1.5,font=2)
abline(reg, col="blue",lwd=2,lty=4)
text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 6, labels=paste(tau,"(***)",sep=" "), col = "red",cex=2,font=2)

read.table("LTR_Caulimovirus.rep_int.txt",header=FALSE)-> R
repclass <- sapply(strsplit("LTR_Caulimovirus.rep_int.txt","[.]"),`[`,1)
Q <- data.frame(hm$V2,R$V4)
Q[Q$R.V4>0,]-> S
reg <- lm(S$R.V4~S$hm.V2)
coeff <- coefficients(reg)
eq <- paste0("y = ", round(coeff[2],1), " x ", round(coeff[1],1))
ken <- cor.test(S$R.V4,S$hm.V2,method="kendall")
tau <- paste0("Tau = ",round(ken$estimate,2))
pval <- paste0("P-value = ", round(ken$p.value,3))
plot(S$R.V4~S$hm.V2,xlab="Masked Ne Estimate",ylab="Repeat Content in %",pch=20,main="LTR Caulimovirus",cex.main=2,cex.axis=1.5,cex=1.5,font.lab=2,cex.lab=1.5,font=2)
abline(reg, col="blue",lwd=2,lty=4)
text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 6, labels=paste(tau,"(***)",sep=" "), col = "red",cex=2,font=2)

read.table("RC_Helitron.rep_int.txt",header=FALSE)-> R
repclass <- sapply(strsplit("RC_Helitron.rep_int.txt","[.]"),`[`,1)
Q <- data.frame(hm$V2,R$V4)
Q[Q$R.V4>0,]-> S
reg <- lm(S$R.V4~S$hm.V2)
coeff <- coefficients(reg)
eq <- paste0("y = ", round(coeff[2],1), " x ", round(coeff[1],1))
ken <- cor.test(S$R.V4,S$hm.V2,method="kendall")
tau <- paste0("Tau = ",round(ken$estimate,2))
pval <- paste0("P-value = ", round(ken$p.value,3))
plot(S$R.V4~S$hm.V2,xlab="Masked Ne Estimate",ylab="Repeat Content in %",pch=20,main="RC Helitron",cex.main=2,cex.axis=1.5,cex=1.5,font.lab=2,cex.lab=1.5,font=2)
abline(reg, col="blue",lwd=2,lty=4)
text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 6, labels=paste(tau,"(***)",sep=" "), col = "red",cex=2,font=2)
dev.off()



#for (i in rep){
#read.table(file=i,header=FALSE)-> R
#repclass <- sapply(strsplit(i,"[.]"),`[`,1)
#Q <- data.frame(hm$V2,R$V4)
#Q[Q$R.V4>0,]-> S
#reg <- lm(S$R.V4~S$hm.V2)
#coeff <- coefficients(reg)
#eq <- paste0("y = ", round(coeff[2],1), " x ", round(coeff[1],1))
#ken <- cor.test(S$R.V4,S$hm.V2,method="kendall")
#tau <- paste0("Tau = ",round(ken$estimate,3))
#pval <- paste0("P-value = ", round(ken$p.value,3))
#plot(S$R.V4~S$hm.V2,xlab="Masked Ne Estimate",ylab="Repeat Content in %",pch=20,main=repclass,cex.axis=1.5,cex=1.5,font.lab=4,cex.lab=1.5,font=4)
#abline(reg, col="blue",lwd=2,lty=4)
#text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 4, labels=eq, srt=0.2, col = "red",cex=1.5,font=4)
#text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 6, labels=tau, col = "red",cex=1.5,font=4)
#if (pval < 0.01){
#text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 8, labels="***", col = "red",cex=1.5,font=4)
#} else if (pval < 0.05){
#text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 8, labels="**", col = "red",cex=1.5,font=4)
#} else if (pval < 0.1){
#text(min(S$hm.V2)+0.7,0.2*max(S$R.V4) + 8, labels="*", col = "red",cex=1.5,font=4)
#}
#legend("topleft",legend=c("* = p-value < 0.1","** = p-value < 0.05","*** = p-value < 0.01"),col="red",cex=1.5,text.font=2)
#}
#dev.off()

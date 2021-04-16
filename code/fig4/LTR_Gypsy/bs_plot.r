gyp_bs = list.files(pattern="LTR_Gypsy.combined.*.txt")
gyp_bs_orig <- read.table(file="LTR_Gypsy.0.txt",header=FALSE)
pt_un <- read.table("~/ajs/psun/test/t1/pt/s100/pt.un.s100.0.txt")
pt_hm <- read.table("~/ajs/psun/test/t1/pt/s100/pt.hm.s100.0.txt")
pdf("LTR_Gypsy_BS.pdf",height=10,width=20)
plot(pt_un$V1,pt_un$V2,type="n",col="orangered",log="x",lwd=3,ylim=c(0,4.5),xlab="Years ago", ylab="Effective population size x 10e4", main="Effect of LTR Gypsy repeat class on PSMC")
lines(pt_un$V1,pt_un$V2,type="s",col="orangered",lwd=3)
lines(pt_hm$V1,pt_hm$V2,type="s",col="blue",lwd=3)
for (i in gyp_bs){
read.table(file=i,header=FALSE)-> gyp_bs_all
lines(gyp_bs_all$V1,gyp_bs_all$V2, type="s",col=scales::alpha(rgb(col2rgb("plum1")[1,],col2rgb("plum1")[2,],col2rgb("plum1")[3,],max = 255), 0.15))
}
lines(gyp_bs_orig$V1,gyp_bs_orig$V2,type="s",col="plum1",lwd=3)
legend("topleft",legend=c("Unmasked", "Hardmasked", "Hardmaksked + Unmasked LTR Gypsy"), fill=c("orangered", "blue", "plum1"), cex=1.5)
dev.off()


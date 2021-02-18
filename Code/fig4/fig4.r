
pdf("Figure_4.pdf",height=12,width=16)
par(mar = c(7, 6, 4, 7))

library("scales")
pt_un <- read.table("pt_un/pt_un.0.txt")
pt_hm <- read.table("pt_hm/pt_hm.0.txt")
pt_hm_bs = list.files("pt_hm",pattern="pt_hm.combined.*.txt", full.names = TRUE)
pt_un_bs = list.files("pt_un",pattern="pt_un.combined.*.txt", full.names = TRUE)

plot(pt_un$V1/1000,pt_un$V2,ylim=c(0,5),log="x",type="n",lwd="3",xlab="",ylab="",axes=F,cex.main=1.75)

rect(0.1,4.8,127,6, col=scales::alpha(rgb(col2rgb("cyan")[1,],col2rgb("cyan")[2,],col2rgb("cyan")[3,],max = 255), 0.25),border="transparent")
text(127/2,4.9,"Holocene",cex=1.5,font=4)
rect(128,4.8,2580,6, col=scales::alpha(rgb(col2rgb("yellow")[1,],col2rgb("yellow")[2,],col2rgb("yellow")[3,],max = 255), 0.25),border="transparent")
text(2580/2,4.9,"Pleistocene",cex=1.5,font=4)
rect(2580,4.8,5330,6, col=scales::alpha(rgb(col2rgb("green")[1,],col2rgb("green")[2,],col2rgb("green")[3,],max = 255), 0.25),border="transparent")
text(3500,4.9,"Pliocene",cex=1.5,font=4,srt=90)
abline(v=800,lwd=4,lty=3)
text(1600,0.1,"Ancient Time Period",cex=1.5,font=4)
abline(v=50,lwd=4,lty=3)
text(250,0.1,"Mid-Time Period",cex=1.5,font=4)
text(10,0.1,"Recent Time Period",cex=1.5,font=4)

for (i in pt_un_bs){
read.table(file=i,header=FALSE)-> pt_un_bs_all
lines(pt_un_bs_all$V1/1000,pt_un_bs_all$V2, type="s",col=scales::alpha(rgb(col2rgb("red")[1,],col2rgb("red")[2,],col2rgb("red")[3,],max = 255), 0.15))
}
lines(pt_un$V1/1000,pt_un$V2,type="s",col="red",lwd=3)
for (i in pt_hm_bs){
read.table(file=i,header=FALSE)-> pt_hm_bs_all
lines(pt_hm_bs_all$V1/1000,pt_hm_bs_all$V2, type="s",col=scales::alpha(rgb(col2rgb("blue")[1,],col2rgb("blue")[2,],col2rgb("blue")[3,],max = 255), 0.15))
}
lines(pt_hm$V1/1000,pt_hm$V2,type="s",col="blue",lwd=3)
gyp_bs = list.files("LTR_Gypsy",pattern="LTR_Gypsy.combined.*.txt", full.names = TRUE)
gyp_bs_orig <- read.table(file="LTR_Gypsy/LTR_Gypsy.0.txt")
for (i in gyp_bs){
read.table(file=i,header=FALSE)-> gyp_bs_all
lines(gyp_bs_all$V1/1000,gyp_bs_all$V2, type="s",col=scales::alpha(rgb(col2rgb("plum1")[1,],col2rgb("plum1")[2,],col2rgb("plum1")[3,],max = 255), 0.15))
}
lines(gyp_bs_orig$V1/1000,gyp_bs_orig$V2,type="s",col="plum1",lwd=3)

axis(1, col="black",las=1,font=2,font.axis=4,cex.axis=1.75)
mtext(side=1, line=3.2, "Time in past (KYA)", col="black", font=2,cex=1.75)
axis(2, col="black",las=1,font=2,font.axis=4,cex.axis=1.75)
mtext(side=2, line=3.2, "Effective Population Size x 1e04",col="black", font=2,cex=1.75)
legend("topleft", inset=0.12, legend=c("PSMC Unmasked","PSMC Masked","LTR_Gypsy"),fill=c("red","blue","plum1"),cex=1.5,text.font=2)

box()

par(new=TRUE)

plot(c(1:58),c(1:58),ylim=c(0,0.3),type="n",xlab="",ylab="",axes=FALSE,font=2,font.axis=4)

rep_col <- c("blue","red","plum1","hotpink","darkolivegreen","peru","olivedrab1","orange2","darkseagreen1","palevioletred1","navy",
"khaki","gray50","cornflowerblue","yellowgreen","chartreuse4","cadetblue4","burlywood4","brown4","blueviolet","bisque4","aquamarine1","aq
uamarine3","aquamarine4","azure3","azure4","brown3","burlywood3","cadetblue2","chartreuse1","chocolate2","coral","coral2","coral3","coral
4","cornsilk4","cyan3","cyan4","darkblue","darkgoldenrod","darkgoldenrod2","darkgoldenrod4","darkmagenta")
colcount <- 0
colcount <- colcount+1
read.table(file="pt_hm/pt_hm.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="pt_un/pt_un.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="DNA_CMC-EnSpm.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="DNA.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="DNA_hAT-Ac.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="DNA_hAT-Tag1.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="DNA_hAT-Tip100.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="DNA_PIF-Harbinger.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="LINE_L1.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="Low_complexity.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="LTR_Caulimovirus.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="LTR_Copia.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="LTR_Gypsy/LTR_Gypsy.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="RC_Helitron.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="rRNA.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="Satellite.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="Simple_repeat.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="SINE.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="SINE_tRNA.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="snRNA.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])
colcount <- colcount+1
read.table(file="tRNA.agg",header=FALSE)->A
as.data.frame(aggregate(A$V2,list(A$V6),sd))->B
as.data.frame(aggregate(A$V2,list(A$V6),mean))->Bm
B$x/Bm$x->B$cv
lines(B$Group.1,B$cv,col=rep_col[colcount])

axis(3, ylim=c(1,58),las=1,font=2,font.axis=4,cex.axis=1.75)
mtext("Atomic Interval",side=3,line=2.5,font=2,font.axis=4,cex=1.75)
axis(4, ylim=c(1,58),las=1,font=2,font.axis=4,cex.axis=1.75)
mtext("CV across Ne of bootstraps",side=4,line=4.5,font=2,font.axis=4,cex=1.75)

dev.off()


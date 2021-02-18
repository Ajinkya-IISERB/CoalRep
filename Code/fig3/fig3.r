pt_hm_s100 <- read.table("pt.PT_test2.hm.s100.0.txt")
pt_un_s100 <- read.table("pt.PT_test2.un.s100.0.txt")

rep_col <- c("plum1","hotpink","darkolivegreen","peru","olivedrab1","orange2","darkseagreen1","palevioletred1","navy","khaki","gray50","cornflowerblue","yellowgreen","chartreuse4","cadetblue4","burlywood4","brown4","blueviolet","bisque4","aquamarine1","aquamarine3","aquamarine4","azure3","azure4","brown3","burlywood3","cadetblue2","chartreuse1","chocolate2","coral","coral2","coral3","coral4","cornsilk4","cyan3","cyan4","darkblue","darkgoldenrod","darkgoldenrod2","darkgoldenrod4","darkmagenta")
colcount <- 0
rep = list.files("psmc",pattern=".0.txt",full.names=TRUE)
repclass <- sapply(strsplit(sapply(strsplit(sapply(strsplit(rep,"[/]"), `[`, 2), "[.]",1), `[`,1),"[.]"), `[`,1)
pdf("Figure_3.pdf",height=12,width=16)
par(mar = c(7, 6, 4, 4))
plot(pt_un_s100$V1/1000,pt_un_s100$V2,ylim=c(0,5),log="x",type="n",lwd="3",xlab="",ylab="",axes=F,cex.main=1.75)

rect(0.1,4.8,127,6, col=scales::alpha(rgb(col2rgb("cyan")[1,],col2rgb("cyan")[2,],col2rgb("cyan")[3,],max = 255), 0.25),border="transparent")
text(127/2,4.9,"Holocene",cex=1.5,font=4)
rect(128,4.8,2580,6, col=scales::alpha(rgb(col2rgb("yellow")[1,],col2rgb("yellow")[2,],col2rgb("yellow")[3,],max = 255), 0.25),border="transparent")
text(2580/2,4.9,"Pleistocene",cex=1.5,font=4)
rect(2580,4.8,5330,6, col=scales::alpha(rgb(col2rgb("green")[1,],col2rgb("green")[2,],col2rgb("green")[3,],max = 255), 0.25),border="transparent")
text(3500,4.9,"Pliocene",cex=1.5,font=4,srt=90)
abline(v=800,lwd=4,lty=3)
text(2000,0.1,"Ancient Time Period",cex=1.5,font=4)
abline(v=50,lwd=4,lty=3)
text(250,0.1,"Mid-Time Period",cex=1.5,font=4)
text(10,0.1,"Recent Time Period",cex=1.5,font=4)

for (i in rep){
colcount <- colcount+1
read.table(file=i,header=FALSE)-> repc
lines(repc$V1/1000,repc$V2,type="s",col=rep_col[colcount],lwd=2)
}

lines(pt_un_s100$V1/1000,pt_un_s100$V2,type="s",lwd="3",col="red")
lines(pt_hm_s100$V1/1000,pt_hm_s100$V2,type="s",lwd="3",col="blue")

axis(1, col="black",las=1,font=2,font.axis=4,cex.axis=1.75)
mtext(side=1, line=3.2, "Time in past (KYA)", col="black", font=2,cex=1.75)
axis(2, col="black",las=1,font=2,font.axis=4,cex.axis=1.75)
mtext(side=2, line=3.2, "Effective Population Size x 1e04",col="black", font=2,cex=1.75)
box()
legend("top", inset=0.1, legend=repclass,fill=rep_col,ncol = 5,cex=1.25,text.font=2)
legend("left",legend=c("PSMC Unmasked","PSMC Masked"),fill=c("red","blue"),cex=1.5,text.font=2)
dev.off()




ceu_hm <- read.csv("smcpp_hm.csv")
ceu_un <- read.csv("smcpp_un.csv")


pdf("Figure_1D.pdf",height=12,width=16)
par(mar = c(7, 6, 4, 4))
plot(ceu_un$x/1000,ceu_un$y/10000,xlim=c(1,10000),log="x",type="n",lwd="3",xlab="",ylab="",axes=F,cex.main=1.7,ylim=c(0,2.5))

rect(0.1,2.3,127,6, col=scales::alpha(rgb(col2rgb("cyan")[1,],col2rgb("cyan")[2,],col2rgb("cyan")[3,],max = 255), 0.25),border="transparent")
text(127/2,2.4,"Holocene",cex=1.5,font=4)
rect(128,2.3,2580,6, col=scales::alpha(rgb(col2rgb("yellow")[1,],col2rgb("yellow")[2,],col2rgb("yellow")[3,],max = 255), 0.25),border="transparent")
text(2580/2,2.4,"Pleistocene",cex=1.5,font=4)
rect(2580,2.3,15330,6, col=scales::alpha(rgb(col2rgb("green")[1,],col2rgb("green")[2,],col2rgb("green")[3,],max = 255), 0.25),border="transparent")
text(9000,2.4,"Pliocene",cex=1.5,font=4)
abline(v=800,lwd=4,lty=3)
text(2000,0.1,"Ancient Time Period",cex=1.5,font=4)
abline(v=50,lwd=4,lty=3)
text(250,0.1,"Mid-Time Period",cex=1.5,font=4)
text(10,0.1,"Recent Time Period",cex=1.5,font=4)

lines(ceu_un$x/1000,ceu_un$y/10000,type="s",lwd="3",col="red")
lines(ceu_hm$x/1000,ceu_hm$y/10000,type="s",lwd="3",col="blue")
axis(1, col="black",las=1,font=2,font.axis=4,cex.axis=1.75)
mtext(side=1, line=3.2, "Time in years (KYA)", col="black", font=2,cex=1.75)
axis(2, col="black",las=1,font=2,font.axis=4,cex.axis=1.75)
mtext(side=2, line=3.2, "Effective Population Size x 1e04",col="black", font=2,cex=1.75)
box()
legend("top", inset=0.1, legend=c("Human CEU SMC++ Unmasked","Human CEU SMC++ Masked"),fill=c("red","blue"),cex=1.5,text.font=2)
dev.off()


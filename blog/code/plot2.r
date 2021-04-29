#Script for plotting per scaffold distribution of sequences across atomic intervals, callability and heterozygosity for differnt -t parameter of PSMC.
#Written By: Ajinkya Bharatraj Patil.

#######################################################################################################################################
####################################################  PLOT GAME CONSOLE  ##############################################################
#######################################################################################################################################

colvec <- c("tomato4","darkolivegreen","turquoise3","peru","orange2","darkseagreen1","slateblue4","cornflowerblue","burlywood4","brown4",
"blueviolet","bisque4","aquamarine1","aquamarine3","aquamarine4","azure3","azure4","brown3","burlywood3","cadetblue2","chartreuse1","chocolate2","coral","coral2","coral3","coral4","cornsilk4","cyan3","cyan4","darkblue","darkgoldenrod","darkgoldenrod2","darkgoldenrod4","darkmagenta","yellow4","tan","tan1","tan2","tan3","tomato",   "turquoise4", "violetred", "violetred4", "wheat3","plum1","tomato3","hotpink", "wheat4","slategrey", "slateblue","slategray4","slateblue2","slategray","yellowgreen","chartreuse4","cadetblue4","violet","navy","khaki","gray50","slategray1","turquoise","olivedrab1","slateblue3","violetred2","slategray2","violetred3","slategray3")
callcol <- c("green","skyblue", "red", "yellow", "magenta")
call_ind <- read.table("../scaffold1281_iw_callable_status.bed")
het_ind <- read.table("../ind_iw_hetcount_5k.bed")
scaf <- "scaffold1281"
for (i in scaf){
jpeg("plot2.jpeg",width=2500,height=1500)
par(mar=c(4,14,2.5,2.5))
read.table(file="../RES1386-IW.rg.qf.s100.t500.dc",header=FALSE)->M
M[M$V1==scaf,]-> Ms
plot(c(0:max(Ms$V3)),rep(5,max(Ms$V3)+1),type="n",ylim=c(0,20),main=i,xlab="",ylab="",axes=FALSE,cex.main=3,col.lab="red")
axis(1, xlim=c(0,max(Ms$V3)+1),col="black",las=1,lwd=4,font.axis=2,cex.axis=2)
mtext(side=1, line=3, "Genomic Co-ordinates", col="black", font=2,cex=2.25)
rect(Ms$V2,rep(0,length(Ms$V2)),Ms$V3,rep(2,length(Ms$V2)),col=colvec[Ms$V4])
read.table(file="../RES1386-IW.rg.qf.s100.t65.dc",header=FALSE)->M
M[M$V1==scaf,]-> Ms
rect(Ms$V2,rep(2.1,length(Ms$V2)),Ms$V3,rep(4,length(Ms$V2)),col=colvec[Ms$V4])
read.table(file="../RES1386-IW.rg.qf.s100.t55.dc",header=FALSE)->M
M[M$V1==scaf,]-> Ms
rect(Ms$V2,rep(4.1,length(Ms$V2)),Ms$V3,rep(6,length(Ms$V2)),col=colvec[Ms$V4])
read.table(file="../RES1386-IW.rg.qf.s100.t45.dc",header=FALSE)->M
M[M$V1==scaf,]-> Ms
rect(Ms$V2,rep(6.1,length(Ms$V2)),Ms$V3,rep(8,length(Ms$V2)),col=colvec[Ms$V4])
read.table(file="../RES1386-IW.rg.qf.s100.t35.dc",header=FALSE)->M
M[M$V1==scaf,]-> Ms
rect(Ms$V2,rep(8.1,length(Ms$V2)),Ms$V3,rep(10,length(Ms$V2)),col=colvec[Ms$V4])
call_ind[call_ind$V1==scaf,] -> Cs
rect(Cs$V2,rep(10.1,length(Cs$V2)),Cs$V3,rep(12,length(Cs$V2)),col=callcol[Cs$V4])
het_ind[het_ind$V1==scaf,] -> Hs
Hs$V7 <- log(Hs$V4+1)
Hs$V8 <- Hs$V7+12.1-min(Hs$V7)
lines(Hs$V3,Hs$V8,type="l",col="blue",lwd=3)
legend(max(Ms$V3)/12,17.5,legend=seq(0,63,1),ncol = 20,bty="n",fill=colvec,cex=2.45,text.font=2)
text(max(Ms$V3)/2,18,"Atomic Intervals",cex=2.35,font=2)
legend("topright",legend=c(levels(Cs$V4)), bty="n",fill=callcol,cex=2,text.font=2)
legend("topleft",inset=.05,fill="blue", cex=2.5, bty="n", legend=expression(bold(paste("Heterozygosity ", theta[w]))))
y.label.position<-c(1,3,5,7,9,11,14)
y.label <- c("-t 500", "-t 65", "-t 55", "-t 45", "-t 35", "Callability", "Heterozygosity")
axis(2, at=y.label.position, label=y.label,las=2, lwd=0,font=2,cex.axis=2)
box(lwd=2)
dev.off()
}

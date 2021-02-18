#######################################################################################################################################
########################################  FUNCTION TO TRANSFORM MATRIX  ###############################################################
#######################################################################################################################################

data.frame2matrix = function(data, rowtitle, coltitle, datatitle, 
                             rowdecreasing = FALSE, coldecreasing = FALSE,
                             default_value = NA) {

  # check, whether titles exist as columns names in the data.frame data
  if ( (!(rowtitle%in%names(data))) 
       || (!(coltitle%in%names(data))) 
       || (!(datatitle%in%names(data))) ) {
    stop('data.frame2matrix: bad row-, col-, or datatitle.')
  }

  # get number of rows in data
  ndata = dim(data)[1]

  # extract rownames and colnames for the matrix from the data.frame
  rownames = sort(unique(data[[rowtitle]]), decreasing = rowdecreasing)
  nrows = length(rownames)
  colnames = sort(unique(data[[coltitle]]), decreasing = coldecreasing)
  ncols = length(colnames)

  # initialize the matrix
  out_matrix = matrix(NA, 
                      nrow = nrows, ncol = ncols,
                      dimnames=list(rownames, colnames))

  # iterate rows of data
  for (i1 in 1:ndata) {
    # get matrix-row and matrix-column indices for the current data-row
    iR = which(rownames==data[[rowtitle]][i1])
    iC = which(colnames==data[[coltitle]][i1])

    # throw an error if the matrix entry (iR,iC) is already filled.
    if (!is.na(out_matrix[iR, iC])) stop('data.frame2matrix: double entry in data.frame')
    out_matrix[iR, iC] = data[[datatitle]][i1]
  }

  # set empty matrix entries to the default value
  out_matrix[is.na(out_matrix)] = default_value

  # return matrix
  return(out_matrix)

}

########################################################################################################################################


#######################################################################################################################################

#########################################################################################################################################
####################################### INTERVAL WISE REPEAT DISTRIBUTION ###############################################################
#########################################################################################################################################

ai <- "AI_geno_perc.txt"
if (file.exists(ai))
file.remove(ai)
temp_s100 = list.files("rc",pattern=".rc.bed",full.names=TRUE)
rep_col <- c("plum1","hotpink","darkolivegreen","peru","olivedrab1","orange2","darkseagreen1","palevioletred1","navy","khaki","gray50","cornflowerblue","yellowgreen","chartreuse4","cadetblue4","burlywood4","brown4","blueviolet","bisque4","aquamarine1","aquamarine3","aquamarine4","azure3","azure4","brown3","burlywood3","cadetblue2","chartreuse1","chocolate2","coral","coral2","coral3","coral4","cornsilk4","cyan3","cyan4","darkblue","darkgoldenrod2","darkgoldenrod4","darkmagenta")
#unlink("AI_geno_perc.txt")
#file.remove("AI_geno_perc.txt")
for (i in temp_s100){
read.table(file=i,header=FALSE)-> rc
rc$V3-rc$V2 -> rc$diff
as.data.frame(aggregate(rc$diff,list(rc$V4),sum))-> aggr_rc
aggr_rc$percent_cont <- (aggr_rc$x/434289848)*100
data.frame(Percent=aggr_rc$percent_cont,Rep_class=aggr_rc$Group.1,atomInt=sapply(strsplit(sapply(strsplit(i,"[/]"), `[`, 2),"[.]"),`[`,1),length(aggr_rc$Group.1))->X
write.table(file="AI_perc_geno.txt",X,row.names=FALSE,col.names=FALSE,sep="\t",quote=FALSE,append=TRUE)
}
read.table(file="AI_perc_geno.txt",header=FALSE)->M
myMatrix = data.frame2matrix(M, 'V2', 'V3', 'V1')
myMatrix[is.na(myMatrix)] <- 0
pdf("Figure_6.pdf",height=15,width=20)
par(mar = c(15,4.1, 3.1, 3.1),xpd=TRUE)
barplot(myMatrix, col=rep_col, main="Fraction of genome covered by repeat classes in each atomic interval",xlab="Atomic Interval",ylab="Genome Fraction",font.lab=2,cex.lab=1.5,cex.main=1.5,font.axis=2)
legend("bottom", inset=c(0,-0.25),legend=c(row.names(myMatrix)),fill=rep_col,ncol = 6, border=NA,box.lty=2,cex=1.3,text.font=2)
box()
dev.off()


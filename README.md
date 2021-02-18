# CoalRep
<h1> Evaluating the impact of repetitive elements during coalescent demographic inferences. </h1>

<h2> Third party tools required- </h2>
You will need all these tools installed and available in the path.
SAMTOOLS
BCFTOOLS
BEDTOOLS
PSMC
SEQTK
MSMC 
MSMC-TOOLS
R

  
<h2>Step 1: Repeat Identification and creating input for repeat analysis. </h2>

#Download the repeat masker output file from NCBI (or generate your own by running repeat masker).

<pre><code>wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/985/GCF_000002985.6_WBcel235/GCF_000002985.6_WBcel235_rm.out.gz</code></pre>
Uncompress the repeat masker output and convert it to a BED format file. Note that the repeat type is encoded as a the fourth column.
<pre><code>gunzip GCF_000002985.6_WBcel235_rm.out.gz
cat GCF_000002985.6_WBcel235_rm.out|tail -n +4|awk '{print $5,$6,$7,$11}'|sed 's/ /\t/g' > GCF_000002985.6_WBcel235_rm.bed
</code></pre>

Having created the read alignment file in bam format and the repeat location and type file in bed format, we are ready to start running the CoalRep module.

<h2>Step 2: Performing Repeat Effect Analysis. </h2>

<pre><code>coalrep -g GCF_000002985.6_WBcel235_genomic.fna -b cel_PB306_ERR3063486/cel_PB306_ERR3063486.sort.bam -p cel_PB306_ERR3063486_repeats -n 10 -m GCF_000002985.6_WBcel235_rm.bed -t 0.1 -u 2.7e-09 -P 1*20+10*5+5*2+1 </code></pre>

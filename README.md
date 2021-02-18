# CoalRep
<h1> Evaluation of impact of repetitive elements during coalescent demographic inferences. </h1>




<h2> Setting Up the Environment for running the wrapper and scripts. </h2>
Follow these steps: 
  
<pre><code> cd coalqc </pre></code>

<pre><code> pwd </pre></code>

copy the path where all the scripts are present and use export path to "coalpath" to save in your working environment. i.e. path which you will obtain after executing pwd in your coalqc folder.

<pre><code> export coalpath={paste the path here} </pre></code>

Now, you have setup the environment for the scripts, you can execute coalqc from anywhere on your computer.

<h2>Step 1: Preparing the bam alignment file.</h2>
<p>Prior to assessing the quality of genomic regions for performing coalescent analysis, we need to prepare an alignment of the short read data against a reference genome in the bam format. While this can be done using a short-read alignment program of your choice, we recommend using the coalmap command that uses the bwa read mapper to perform the read mapping. The following programs need to be installed and present in the PATH: bwa, samtools</p>
<pre><code>coalqc map -g genome -f fastqread1 -r fastqread2 -p prefix -n threads</code></pre>

<p>The coalmapscript will perform indexing of genome fasta file using the bwa index command and will also align the short read data to the genome using the bwa mem command. You may use the coalmapmulti.sh command to map the reads from multiple individuals.</p>

<p>As an example, we will download the genome assembly of the worm Caenorhabditis elegans from the NCBI website and use the publicly available short read data from the wild isolate PB306.</p>
<p>#Download genome reference file<pre><code><br />wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/985/GCF_000002985.6_WBcel235/GCF_000002985.6_WBcel235_genomic.fna.gz</code></pre>
<p>#Uncompress the reference fasta file<pre><code><br />
gunzip GCF_000002985.6_WBcel235_genomic.fna.gz</code></pre></p>

<p>#Download short read data files<pre>
<code><br />wget <a href="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR306/006/ERR3063486/ERR3063486_1.fastq.gz">ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR306/006/ERR3063486/ERR3063486_1.fastq.gz</a></code></pre></p>
<pre>
<code><br />wget <a href="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR306/006/ERR3063486/ERR3063486_2.fastq.gz">ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR306/006/ERR3063486/ERR3063486_2.fastq.gz</a></code></pre></p>

<p>#Use coalmap command to index the genome and map the short read data.<pre>
<code><br />
coalqc map -g GCF_000002985.6_WBcel235_genomic.fna -f ERR3063486_1.fastq.gz -r ERR3063486_2.fastq.gz -p cel_PB306_ERR3063486 -n 10
</code></pre></p>

The following information about the genome assembly used and percent of reads mapped to the genome are reported.
<code>
<p>Percent of N's or hardmasked bases is 0.</p>
<p>Analysis will be performed by using this fasta file but make sure you are not using hardmasked genome.<p>
<p>Now, mapping the reads to the reference genome.</p>
<p>Mapping finished</p>
<p>The mapped percentage for this assembly is 98.91%.</p>
<p>Now, calculating coverage.</p>
<p>The mean coverage of reads is 27.1474</p>
</code>

<h2>Step 2: Repeat Identification and creating input for repeat analysis. </h2>

#Download the repeat masker output file from NCBI (or generate your own by running repeat masker).

<pre><code>wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/985/GCF_000002985.6_WBcel235/GCF_000002985.6_WBcel235_rm.out.gz</code></pre>
Uncompress the repeat masker output and convert it to a BED format file. Note that the repeat type is encoded as a the fourth column.
<pre><code>gunzip GCF_000002985.6_WBcel235_rm.out.gz
cat GCF_000002985.6_WBcel235_rm.out|tail -n +4|awk '{print $5,$6,$7,$11}'|sed 's/ /\t/g' > GCF_000002985.6_WBcel235_rm.bed
</code></pre>

Having created the read alignment file in bam format and the repeat location and type file in bed format, we are ready to start running the coalqc repeat module.

<h2>Step 3: Performing Repeat Effect Analysis. </h2>

<pre><code>coalqc repeat -g GCF_000002985.6_WBcel235_genomic.fna -b cel_PB306_ERR3063486/cel_PB306_ERR3063486.sort.bam -p cel_PB306_ERR3063486_repeats -n 10 -m GCF_000002985.6_WBcel235_rm.bed -t 0.1 -u 2.7e-09 -P 1*20+10*5+5*2+1 </code></pre>

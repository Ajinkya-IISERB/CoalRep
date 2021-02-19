# CoalRep
<h1> Evaluating the impact of repetitive elements on coalescent demographic inferences. </h1>

<h2> Third party tools required- </h2>
You will need all these tools installed and available in the path.
<pre><code>- SAMTOOLS
- BCFTOOLS
- BEDTOOLS
- PSMC
- SEQTK
- MSMC 
- MSMC-TOOLS
- R</pre></code>

<pre><code>**Add mod_dec.pl, decode2bed.pl and psmc_plot.pl file to the path and make sure it is available globally on the PC.</pre></code>
<h2>Step 1: Preparing the bam alignment file.</h2>
<p>Prior to assessing the quality of genomic regions for performing coalescent analysis, we need to prepare an alignment of the short read data against a reference genome in the bam format. While this can be done using a short-read alignment program of your choice, we recommend using the coalmap command that uses the bwa read mapper to perform the read mapping. The following programs need to be installed and present in the PATH: bwa, samtools</p>
<pre><code>coalmap -g genome -f fastqread1 -r fastqread2 -p prefix -n threads</code></pre>

<p>As an example, we will download the genome assembly of the *Populus trichocarpa* from the NCBI website and use the publicly available short read data from the SRA dataset.</p>
<p>#Download genome reference file<pre><code><br />wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/775/GCF_000002775.4_Pop_tri_v3/GCF_000002775.4_Pop_tri_v3_genomic.fna.gz </code></pre>
<p>#Uncompress the reference fasta file<pre><code><br />
gzip -d GCF_000002775.4_Pop_tri_v3_genomic.fna.gz</code></pre></p>

<p>#Download short read data files<pre> 
<code><br />wget <a href="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR625/009/SRR6256359/SRR6256359_1.fastq.gz">ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR625/009/SRR6256359/SRR6256359_1.fastq.gz</a></code></pre></p>
<pre>
<code><br />wget <a href="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR625/009/SRR6256359/SRR6256359_2.fastq.gz">ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR625/009/SRR6256359/SRR6256359_2.fastq.gz</a></code></pre></p>
<p>#Use coalmap command to index the genome and map the short read data.<pre>
<code><br />
coalmap -g GCF_000002775.4_Pop_tri_v3_genomic.fna -f SRR6256359_1.fastq.gz -r SRR6256359_2.fastq.gz -p pt -n 24
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

<pre><code>wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/775/GCF_000002775.4_Pop_tri_v3/GCF_000002775.4_Pop_tri_v3_rm.out.gz</code></pre>
Uncompress the repeat masker output and convert it to a BED format file. Note that the repeat type is encoded as a the fourth column.
<pre><code>gzip -d GCF_000002775.4_Pop_tri_v3_rm.out.gz
cat GCF_000002775.4_Pop_tri_v3_rm.out|tail -n +4|awk '{print $5,$6,$7,$11}'| sed 's/\?//g' | sed 's/\//_/g' |sed 's/ /\t/g' > GCF_000002775.4_Pop_tri_v3_rm.bed
</code></pre>

Having created the read alignment file in bam format and the repeat location and type file in bed format, we are ready to start running the CoalRep module.

<h2>Step 3: Performing Repeat Effect Analysis. </h2>

<pre><code>coalrep -g GCF_000002775.4_Pop_tri_v3_genomic.fna -b pt/pt.sort.bam -p pt -n 24 -m GCF_000002775.4_Pop_tri_v3_rm.bed -t 5 -u 3.75e-08 -P "4+25*2+4+6"</code></pre>

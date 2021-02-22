# CoalRep
<h2> Evaluating the impact of repetitive elements on coalescent demographic inferences. </h2>

<h2> Third party tools required- </h2>
You will need all these tools installed and available in the path.
<pre><code> -BWA
- SAMTOOLS
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
<p>#Uncompress the reference fasta file<pre><code><br />gzip -d GCF_000002775.4_Pop_tri_v3_genomic.fna.gz</code></pre></p>
<p>#Download short read data files<pre> <code><br />wget <a href="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR625/009/SRR6256359/SRR6256359_1.fastq.gz">ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR625/009/SRR6256359/SRR6256359_1.fastq.gz</a></code></pre></p>
<pre><code><br />wget <a href="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR625/009/SRR6256359/SRR6256359_2.fastq.gz">ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR625/009/SRR6256359/SRR6256359_2.fastq.gz</a></code></pre></p>
<p>#Use coalmap command to index the genome and map the short read data.<pre><code><br />
coalmap -g GCF_000002775.4_Pop_tri_v3_genomic.fna -f SRR6256359_1.fastq.gz -r SRR6256359_2.fastq.gz -p pt -n 24
</code></pre></p>

The following information about the genome assembly used and percent of reads mapped to the genome are reported.
<pre><code>
<p>Percent of N's or hardmasked bases is 0.</p>
<p>Analysis will be performed by using this fasta file but make sure you are not using hardmasked genome.<p>
<p>Now, mapping the reads to the reference genome.</p>
<p>Mapping finished</p>
<p>The mapped percentage for this assembly is 98.91%.</p>
<p>Now, calculating coverage.</p>
<p>The mean coverage of reads is 27.1474</p>
</pre></code>
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

This will print on the screen some stuff like this 
<pre><code>Approximate genome size is 439719174
Now, calculating coverage
The mean coverage of reads is 42.5397
The variants will be called now
[warning] samtools mpileup option `u` is functional, but deprecated. Please switch to using bcftools mpileup in future.
[mpileup] 1 samples in 1 input files
Note: none of --samples-file, --ploidy or --ploidy-file given, assuming all sites are diploid
[warning] samtools mpileup option `u` is functional, but deprecated. Please switch to using bcftools mpileup in future.
Note: none of --samples-file, --ploidy or --ploidy-file given, assuming all sites are diploid
[mpileup] 1 samples in 1 input files
Variants are ready
Making PSMC fasta from variants
Creating heterozygosity profile
Now, running PSMC
PSMC output is done
Now, creating plotting information
Now, running MSMC analysis
[warning] samtools mpileup option `u` is functional, but deprecated. Please switch to using bcftools mpileup in future.
Note: none of --samples-file, --ploidy or --ploidy-file given, assuming all sites are diploid
[mpileup] 1 samples in 1 input files
parsing position 135
parsing position 10773
parsing position 20773
parsing position 30773
parsing position 40773
parsing position 50926
parsing position 60926
parsing position 70926
parsing position 80926
parsing position 90926
</pre></code>
This will go on for quite a long time as it will perform PSMC and MSMC analyses on your dataset and explore the repeat families and its effects on the demography.
After run finishes you will see some lines like this.
<pre><code>
pdf 
  2 
Finished running Coalrep
</pre></code>
If you get this output at the end that means your run was successful and the results are produced and already kept in the results folder for your observation. In results folder there would be 6 folder namely, PSMC_plots, Recomb_events, Repeat_correlation, Repeat_Distribution_in_AI, Repeat_length, Ts_Tv. What results these folders contain and what to look for in these, their details are given below.

<h2> Guide for output of CoalRep </h2>

The results directory will have 6 subdirectories: 1.PSMC_plots, 2.Recomb_events, 3.Repeat_correlation, 
4.Repeat_Distribution_in_AI, 5.Repeat_length and 6.Ts_Tv.

<h3>1. PSMC_plots directory:</h3>
PSMC trajectories differ due to inclusion/exclusion of repeats. Extent of change in trajectories due to these repeats are
assessed in these plots. PSMC plots showing repeat content across atomic intervals, and comparative msmc inferred curves.
Filename strucure is followed like this: {bamfile}.{prefix}_repeat_effect_{bin_size}.pdf for masked/unmasked psmc runs and
{bamfile}.{prefix}_repclass_PSMC_s100.pdf for all repeat class PSMC. 
File ending with repclass_PSMC_s100.pdf will have PSMC plot having all the repeat classes plotted in single panel to get 
comparative differences due to inclusion of each repeat class during PSMC analyses.
There should be 5 plots, one for each bin sizes, one combined and one for repeat classes.

<h3>2. Recomb_events directory:</h3>
Occurance of sufficient number of recombinations in each atomic interval after 20th interval is one of the necessities 
for accurate coalescent inferrence in PSMC. These plots will show if there are sufficient number of recombiantions for 
your PSMC runs. 
Plots for Number of recombinations in each interval across 25 iterations for each PSMC run. 
Filename structure for masked and unmasked genomes PSMC runs is followed like this: 
{bamfile}.{prefix}.{mask_status}.{bin_size}.nrcomb_RecQC.pdf.
For repeat class PSMC runs filemname structure is followed like this: {repeat_class}.nrcomb_RecQC.pdf.
There will be 6 plots for masked/unmasked PSMC runs and equal number of plots corresponding to repeat classes.

<h3>3. Repeat_Correlation directory:</h3>
Correlation for repeat content in atomic intervals with differences in Effective population sizes (Ne) is tested using 
regression and Kendall's correlation test. If repeats are really affecting the PSMC inferrence, this correlation should 
be high.
Filename structure is followed like this: {bamfile}.{prefix}_correlation_repeat_{bin_size}.pdf.
In total 4 plots should be there.

<h3>4. Repeat_Distribution_in_AI directory:</h3>
Contribution or abundance of repeat classes across intervals in each interval and across genome is shown to better
assess which repeat classes have higher contribution to that atomic interval.
Filename structure is followed like this: {bin_size}.AI_perc.pdf for abundance in each interval 
and {bin_size}.AI_perc_geno.pdf for abundance across genome.
In total there should be 6 plots, 2 for each bin size.

<h3>5. Repeat_length directory:</h3>
Lengths of sequences used for inference of Ne in each atomic interval varies. The distribution of lengths of sequences 
across atomic intervals is plotted for each PSMC run. 
Filename structure for masked/unmasked PSMC is followed like this: 
{bamfile}.{prefix}.{mask_status}.{bin_size}.RepLength_{bin_size}.pdf
and for repeat class PSMC runs a single file RepLength_repclass.pdf will be produced.
In total there should be 7 plots, 2 for each bin size and one for repeats.

<h3>6. Ts_Tv directory:</h3>
Heterozygosity and Ts/Tv ratio of corresponding atomic interval is calculated and plotted. 
Distribution of heterozygosity is expected to increase across intervals in increasing order of atomic itervals but 
corresponding Ts/Tv values should be randomly distributed.
Filename structure is followed like this: {bamfile}.{prefix}.rep_tstv.{bin_size}.pdf
There should be 3 plots in total one for each bin size.

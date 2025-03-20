 # Differential Gene Expression Analysis
 1. A data set contains 6 RNA-seq samples. Samples 0 − 2 belong to condition A and samples 3 − 5 are condition B
    (RNA seq- "https://nextcloud.th-deg.de/s/C4bJdNYA3R4WSeL/download/fastq_files.tar")
 2. Perform a differential gene expression analysis between samples of condition A and B
  • fastqc: for quality control of the raw and quality filtered data.
  • cutadapt: for quality filtering of the raw reads.
  • STAR: to map reads to the genome.
  • featureCounts: to obtain reads counts on the gene level.
  • DESeq2: to detect differentially expressed genes.
3. Use reference genome and annotation files
4. featureCounts_output.txt
– This file contains the featureCounts results of your 6 samples.
– Ensure that the order of the columns matches the order of the sample file names. Thus, the
columns of this file should match the counts for sample_0, sample_1, . . .  , sample_5.
5. deseq2_up.txt
– Contains the subset of your DESeq2 results for genes with a log2 fold-change >= 2.
  deseq2_down.txt
– Contains the subset of your DESeq2 results for genes with a log2 fold-change <= -2.
6. workflow.smk: Your snakemake workflow used to generate your results
7. protocol.pdf contains description of analysis

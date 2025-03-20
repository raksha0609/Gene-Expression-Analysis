rule all:
    input:
        "featureCounts_output.txt",
        "deseq2_up.txt",
        "deseq2_down.txt"

rule fastqc:
    input:
        "sample_{sample}.fastq"
    output:
        "fastqc_reports/sample_{sample}_fastqc.html"
    shell:
        "mkdir -p fastqc_reports && fastqc {input} --outdir=fastqc_reports"

rule cutadapt:
    input:
        "sample_{sample}.fastq"
    output:
        "trimmed_reads/sample_{sample}_trimmed.fastq"
    shell:
        "mkdir -p trimmed_reads && cutadapt -a file:/home/ubuntu/illumina_adapter.fa -o {output} {input}"

rule star:
    input:
        "trimmed_reads/sample_{sample}_trimmed.fastq"
    output:
        bam="star_alignment/sample_{sample}_Aligned.out.bam",
        sam="star_alignment/sample_{sample}_Aligned.out.sam"
    params:
        prefix="star_alignment/sample_{sample}_"
    shell:
        """
        STAR --runThreadN 4 \
             --genomeDir /home/ubuntu/genome_index \
             --readFilesIn {input} \
             --outFileNamePrefix {params.prefix} \
             --outSAMtype BAM Unsorted \
             --outSAMattributes All

        samtools view -h -o {output.sam} {output.bam}
        """

rule featurecounts:
    input:
        bam_files=expand("star_alignment/sample_{sample}_Aligned.out.bam", sample=["0", "1", "2", "3", "4", "5"]),
        annotation="/home/ubuntu/annotation.gtf"
    output:
        "featureCounts_output.txt"
    shell:
        "featureCounts -T 4 -a {input.annotation} -o {output} -s 1 {input.bam_files}"

rule deseq2:
    input:
        "featureCounts_output.txt"
    output:
        "deseq2_up.txt", "deseq2_down.txt"
    shell:
        "Rscript run_deseq2.R {input} {output}"

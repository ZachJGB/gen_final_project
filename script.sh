#! Final project code

!/bin/bash

*MAKE DIRECTORIES FOR PROJECT*
mkdir final-project ~
cd final-project
mkdir qiime2-fmt-tutorial
cd qiime2-fmt-tutorial

*RETRIEVE INITIAL SAMPLE INFORMATION*
wget \
  -O "sample-metadata.tsv" \
  "https://data.qiime2.org/2022.2/tutorials/fmt/sample_metadata.tsv"

*INITIAL RAW DATA DOWNLOAD FROM 10% SAMPLES*
wget \
  -O "fmt-tutorial-demux-1.qza" \
  "https://data.qiime2.org/2022.2/tutorials/fmt/fmt-tutorial-demux-1-10p.qza"
wget \
  -O "fmt-tutorial-demux-2.qza" \
  "https://data.qiime2.org/2022.2/tutorials/fmt/fmt-tutorial-demux-2-10p.qza"

*INSTALLED QIIME ON LOCAL ENVIRONMENT*
wget https://data.qiime2.org/distro/core/qiime2-2022.2-py38-linux-conda.yml
conda env create -n qiime2-2022.2 --file qiime2-2022.2-py38-linux-conda.yml
# OPTIONAL CLEANUP
rm qiime2-2022.2-py38-linux-conda.yml

conda activate qiime2-2022.2
qiime --help

*DENOISE RAW DATA*
qiime demux summarize \
  --i-data fmt-tutorial-demux-1.qza \
  --o-visualization demux-summary-1.qzv
qiime demux summarize \
  --i-data fmt-tutorial-demux-2.qza \
  --o-visualization demux-summary-2.qzv

*IN POWERSHELL RETRIEVED VISUAL DOCUMENTS .QZV*
sftp rmw1063@ron.sr.unh.edu
        entered password 

sftp> cd final-project/qiime2-fmt-tutorial
sftp> get demux-summary-1.qzv
sftp> get demux-summary-2.qzv 
sftp> ^C to leave sftp

on local device: mv demux-summary-1.qzv Desktop
on local device: mv demux-summary-2.qzv Desktop 

! viewed both documents using qiime view 2 !
! downloaded pdf files for both read frequencies !

*TRIMMED READS*
conda activate qimme2-2022.2
cd ~/final-project/qiime2-fmt-tutorial
qiime dada2 denoise-single \
  --p-trim-left 13 \
  --p-trunc-len 150 \
  --i-demultiplexed-seqs fmt-tutorial-demux-1.qza \
  --o-representative-sequences rep-seqs-1.qza \
  --o-table table-1.qza \
  --o-denoising-stats stats-1.qza
qiime dada2 denoise-single \
  --p-trim-left 13 \
  --p-trunc-len 150 \
  --i-demultiplexed-seqs fmt-tutorial-demux-2.qza \
  --o-representative-sequences rep-seqs-2.qza \
  --o-table table-2.qza \
  --o-denoising-stats stats-2.qza

*IN POWERSHELL RETRIEVED .QZA DOCUMENTS ONTO LOCAL DEVICE*
sftp rmw1063@ron.sr.unh.edu
        entered password

sftp> cd final-project/qiime2-fmt-tutorial
sftp> get rep-seqs-1.qza
sftp> get rep-seqs-2.qza
sftp> get stats-1.qza
sftp> get stats-2.qza
sftp> get table-1.qza
sftp> get table-2.qza
sftp> ^C
on local device: mv all files to Downloads
*VIEWING DENOISING STATS*
conda activate qiime2-2022.2
cd ~/final-project/qiime2-fmt-tutorial

qiime metadata tabulate \
  --m-input-file stats-1.qza \
  --o-visualization denoising-stats-1.qzv
qiime metadata tabulate \
  --m-input-file stats-2.qza \
  --o-visualization denoising-stats-2.qzv

*IN POWERSHELL RETRIEVED .QZV DOCUMENTS ONTO LOCAL DEVICE*
        see above for protocol

*MERGING DENOISED DATA*
qiime feature-table merge \
  --i-tables table-1.qza \
  --i-tables table-2.qza \
  --o-merged-table table.qza
qiime feature-table merge-seqs \
  --i-data rep-seqs-1.qza \
  --i-data rep-seqs-2.qza \
  --o-merged-data rep-seqs.qza

*IN POWERSHELL RETRIEVED .QZA DOCUMENTS ONTO LOCAL DEVICE*
        see above for protocol 

*SUMMARIZE MERGED DATA*
qiime feature-table summarize \
  --i-table table.qza \
  --o-visualization table.qzv \
  --m-sample-metadata-file sample-metadata.tsv

*IN POWERSHELL RETRIEVED .QZV DOCUMENTS ONTO LOCAL DEVICE*
        see above for protocol

*SUMMARIZE MERGED SEQUENCES*
qiime feature-table tabulate-seqs \
  --i-data rep-seqs.qza \
  --o-visualization rep-seqs.qzv

*IN POWERSHELL RETRIEVED .QZV DOCUMENTS ONTO LOCAL DEVICE*
        see above for protocol

*PHYLOGENTIC TREE ASSEMBLY*
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences rep-seqs.qza \
  --o-alignment aligned-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza

*IN POWERSHELL RETRIEVED .QZA DOCUMENTS ONTO LOCAL DEVICE*
        see above for protocol

*DOWNLOADED REFERENCE CLASSIFIER FOR STOOL*
 wget https://zenodo.org/records/6395539/files/full-length-human-stool-classifier.qza?download=1
downloaded classifier from SILVA rRNA database

*TAXONOMIC ASSIGNMENT OF BACTERIA*
qiime feature-classifier classify-sklearn \
  --i-classifier stool-qiime 
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

*IN POWERSHELL RETRIEVED .QZV DOCUMENT ONTO LOCAL DEVICE*
        see above for protocol

*DIVERSITY ANALYSIS: CORE METRICS*
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table table.qza \
  --p-sampling-depth 1103 \
  --m-metadata-file sample-metadata.tsv \
  --output-dir core-metrics-results

*DIVERSITY ANALYSIS: ALPHA GROUP*
qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization core-metrics-results/faith-pd-group-significance.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/evenness_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization core-metrics-results/evenness-group-significance.qzv

*DIVERSITY ANALYSIS: BETA GROUP*
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file sample-metadata.tsv \
  --m-metadata-column sample-type \
  --o-visualization core-metrics-results/unweighted-unifrac-body-site-significance.qzv \
  --p-pairwise

qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file sample-metadata.tsv \
  --m-metadata-column treatment-group \
  --o-visualization core-metrics-results/unweighted-unifrac-subject-group-significance.qzv \
  --p-pairwise

*IN POWERSHELL RETRIEVED ALL .QZV DIVERSITY FILES ONTO LOCAL DEVICE*

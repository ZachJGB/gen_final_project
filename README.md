# Gen 711 final project: A Summary
By Zach Gravel-Blaney, Riley Wilson and John Kelleher
<details>
 <summary>Background</summary>
This data was taken from a study on the correlation between the human gut microbiome and autism spectrum disorder (ASD) gastrointestinal issues.
The main goal of this study was to evaluate the effect of Microbiota Transfer Therapy (MTT) on the GI of ASD-diagnosed children and overall how that impacted ASD symptoms.

Kang, DW., Adams, J.B., Gregory, A.C. et al. Microbiota Transfer Therapy alters gut ecosystem and improves gastrointestinal and autism symptoms: an open-label study. Microbiome 5, 10 (2017). https://doi.org/10.1186/s40168-016-0225-7

One group received the MTT fecal transplant (treatment group) and one group did not receive the transplant (control group).
Stool collections and fecal swab were collected bi-weekly for 12 weeks.
DNA was isolated from both sample collection avenues with PowerSoil® DNA Isolation Kit.
A 16S rRNA library prep from Illumina MiSeq was performed to amplify specifically bacterial and archaeal DNA.
(Primer tag: 515f-806r)
10% of total data was analyzed.
</details>
<details>
 <summary>Methods</summary>
 <details>
  <summary>Data Import and Qiime Installation</summary>
Performed “wget” command to download metadata and raw reads
  Downloaded forward and reverse reads 
Installed “qiime2-2022.2” onto local device using “wget” and “conda env create”
  Enabled all “qiime2” analysis to be done in terminal
 </details>
  <details>
  <summary>Denoising</summary>
“qiime demux summarize” 
  first 13 bases will be trimmed 
  150 bases total length
“qiime dada2 denoise-single” 
  trimmed and truncated both raw reads
“qiime metadata tabulate”
  output table containing all read information (feature ID, filtering statistics, how much of the data was denoised/passed filter)
  </details>
   <details>
  <summary>Merging Reads and Alignment</summary>
“qiime feature-table merge”
  merge denoised sequences together and create new aligned clean DNA 
“qiime feature-table summarize”
  create frequency table from merged sequences
“qiime feature-table tabulate-seqs”
  show table of merged DNA
   </details>
    <details>
  <summary>Taxonomy Assignment</summary>
Downloaded a reference classifier for human stool from SILVA rRNA database using “wget”
“qiime feature-classifier classify-sklearn” and “qiime metadata tabulate”
  uses reference classifier to compare sequences to known bacteria in human stool and create a list of taxa found
    </details>
     <details>
  <summary>Phylogenetic Tree Assembly</summary>
“qiime phylogeny align-to-tree-mafft-fasttree”
  utilizes all of the aligned sequences and taxonomic analysis to construct data for a phylogenetic tree
“qiime empress tree-plot”
  had to install the “empress” extension for qiime 
  creates a physical phylogenetic tree for the data
     </details>
      <details>
  <summary>Alpha and Beta Diversity Analysis</summary>
“qiime diversity core-metrics-phylogenetic”
  set the initial parameters for alpha and beta analysis 
“qiime diversity alpha-group-significance”
  produced graphs regarding the data richness and evenness 
“qiime diversity beta-group-significance”
  produced several graphs to compare how the treatment groups and sample types are associated
</details>
</details>

<details>
 <summary>Results</summary>
All important Raw data files collected thorugh our methods

## Demux Summaries
Demux 1 and 2 (Forward and Reverse)
-summary bar-plots contain # sequences relative to # samples
[demux-summary-1.pdf](https://github.com/ZachJGB/gen_final_project/files/15201459/demux-summary-1.pdf)
[demux-summary-2.pdf](https://github.com/ZachJGB/gen_final_project/files/15201461/demux-summary-2.pdf)

-summary plots 1 and 2 including sequence bases and their quality scores
![demux-summary-plot-1](https://github.com/ZachJGB/gen_final_project/assets/157840948/346813c8-8478-4990-af5f-a8b06a596469)
![demux-summary-plot-2](https://github.com/ZachJGB/gen_final_project/assets/157840948/44eb5989-05cc-49f3-b118-62d302750077)

## Frequency graphs: Denoising 
Graphs containing frequencies of features and samples relative to the # of features or samples after the denoising proccess
[feature-frequencies.pdf](https://github.com/ZachJGB/gen_final_project/files/15201499/feature-frequencies.pdf)
[stool-boxplots.pdf](https://github.com/ZachJGB/gen_final_project/files/15201500/stool-boxplots.pdf)

## Taxanomic reads
Taxonomic data including screenshot of table that contains taxa identification. As well as
![taxonomy qzv screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/e2b53bb5-697a-46cd-b4cf-baa9ad254d74)
 Graph containing taxonomic reads sorting based on phylogenetic kingdom
![taxa bar plot screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/cd4758c9-c990-47f4-81b1-496dbc45a0bc)

## Treatment scatterplots
Scatterplots containing relatedness of samples between treatments
![weighted unifrac screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/e959f4de-515b-45e1-a907-d88a10dc920a)
![unweighted unifrac screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/8fdcc879-1a2f-4ecc-ba19-47943b4a90d1)
![jaccard screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/217c360e-ccff-47af-8765-55c8cecee69f)
![bray curtis screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/9464f07a-7cac-4fa3-a009-35dda103b66f)

## Alpha diversity Box Plots
Box plots explaining alpha diversity between treatments.
-Faith pd plot and table show the rischness at the alpha diversity level
![faith pd group significance screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/7755e98d-d69e-4b81-a79b-7f745c7afebe)
![faith pd group significance table](https://github.com/ZachJGB/gen_final_project/assets/157840948/1723829a-f0d2-4aad-882a-b3879c59e2ce)

-evenness group boxpot and table show evenmenss between treatments at the alpha diversity level
![evenness group significance screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/280789fa-19c3-4bc5-8ea8-d6b12c25b330)
![evenness group significance table](https://github.com/ZachJGB/gen_final_project/assets/157840948/15eb89db-ecce-46b1-98ce-67510c7bbd03)

## Beta diversity Box Plots
Box plots containing beta diversity between treatments amd distances to and from several variables
[fmt-material-boxplots.pdf](https://github.com/ZachJGB/gen_final_project/files/15204372/fmt-material-boxplots.pdf)
[stool-boxplots.pdf](https://github.com/ZachJGB/gen_final_project/files/15204388/stool-boxplots.pdf)
[swab-boxplots.pdf](https://github.com/ZachJGB/gen_final_project/files/15204389/swab-boxplots.pdf)
[control-boxplots.pdf](https://github.com/ZachJGB/gen_final_project/files/15204391/control-boxplots.pdf)
[donor-boxplots.pdf](https://github.com/ZachJGB/gen_final_project/files/15204392/donor-boxplots.pdf)
[treatment-boxplots.pdf](https://github.com/ZachJGB/gen_final_project/files/15204394/treatment-boxplots.pdf)

## Signifcance Permanova tables
Tables including significance levels of both subject (treatment groups) and body (Sample type)
![subject permanova table](https://github.com/ZachJGB/gen_final_project/assets/157840948/a2a638ae-a9cd-4ef7-be85-3020affcf82e)
![subject permanova table 2](https://github.com/ZachJGB/gen_final_project/assets/157840948/8e35f639-7610-4645-8c2d-d3b818adbba7)
![body permanova table 2](https://github.com/ZachJGB/gen_final_project/assets/157840948/cddd180d-af97-45a5-a431-92cea008943b)
![body permanova table](https://github.com/ZachJGB/gen_final_project/assets/157840948/42352c7f-7254-4dbb-9421-53051eeaaeb6)

## Phylogenetic tree and key
Tree containing all taxanomic data, showing bacteria as the major kingdom of fecal microbiome organisms
![tree screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/45790566-96c6-4734-808a-5e4bd828c539)
![tree legend screenshot](https://github.com/ZachJGB/gen_final_project/assets/157840948/ee46521d-4c76-4995-9553-ae96fe9480de)
</details>

<details>
<summary>Major Takeaways</summary>
qiime2 is an incredibly useful tool to analyze raw reads and transform them into visual statistics 
The most difficult part of this project was trying to download all files onto a local device to be viewed
Best analysis and result: taxonomic assignment and the phylogenetic tree
  Best visualization of bacteria present
</details>
<details>
<summary>References</summary>
“Fecal Microbiota Transplant (FMT) Study: An Exercise¶.” QIIME 2 Docs, docs.qiime2.org/2022.2/tutorials/fmt/. Accessed 10 May 2024.
Kaehler BD, Bokulich NA, McDonald D, Knight R, Caporaso JG, Huttley GA. (2019). Species-level microbial sequence classification is improved by source-environment information. Nature Communications 10: 4643.
Kang, DW., Adams, J.B., Gregory, A.C. et al. Microbiota Transfer Therapy alters gut ecosystem and improves gastrointestinal and autism symptoms: an open-label study. Microbiome 5, 10 (2017). https://doi.org/10.1186/s40168-016-0225-7
Bokulich, N.A., Kaehler, B.D., Rideout, J.R. et al. (2018). Optimizing taxonomic classification of marker-gene amplicon sequences with QIIME 2's q2-feature-classifier plugin. Microbiome 6, 90.
Quast C, Pruesse E, Yilmaz P, Gerken J, Schweer T, Yarza P, Peplies J, Glöckner FO (2013) The SILVA ribosomal RNA gene database project: improved data processing and web-based tools. Nucl. Acids Res. 41 (D1): D590-D596
Robeson, M. S., O'Rourke, D. R., Kaehler, B. D., Ziemski, M., Dillon, M. R., Foster, J. T., & Bokulich, N. A. (2021). RESCRIPt: Reproducible sequence taxonomy reference database management. PLoS Comp. Bio., 17(11).
</details>

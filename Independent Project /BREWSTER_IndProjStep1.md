# Data Manipulation and Quantitative Analysis of the Effect of Microvesicles on Endothelial Cell Function using RStudio
## Introduction

Endothelial dysfunction is the harbinger of atherosclerosis. Extracellular microvesicles (MVs) are small outward blebbings of the plasma membrane, which contain various cargo such as RNA, proteins, and microRNAs and are released from almost all cell types in response to cellular apoptosis and/or activation. Recently, MVs have emerged as important mediators and effectors of endothelial dysfunction and the progression of atherosclerosis and cardiovascular disease (CVD). Importantly, there is a growing number of comorbidites with CVD where the mechanistic relationship is not well understood. For example, adults with human immunodeficiency virus (HIV)-1, chronic mountain sickness (CMS), and spinal cord injury (SCI) all have increased risk for the development of CVD. One study, which looked that the effect of MVs  isolated from HIV-seropositive adults on endothelial function, demonstrated that MVs might be responsible for the link between HIV-1 and cardiovascular risk. 

Parametric (normality) testing, which tests the homogeneity of a set of data, is an important precusor for the interpretation of data. The dsitribution of data effects the descriptive statistics that are published and compared as well as the inferential statistical testing performed to draw conclusions from the data. Depending on the breadth of the study, the dependent variables (outcomes of interest) can be vast. Therefore, efficient and streamlined methodologies of normality testing and the associated statistics should be employed.

My research explores the effects of microvesicles isolated from human populations on endothelial cell function. To determine endothelial function, we look at cellular cytokine release as well as intracellular protein and microRNA in response to MV treatment.  In the following project, I intend to use a typical set of data that my lab would use to publish in a manuscript and automate the parametric testing and the associated descriptive and inferential statistics using RStudio. As per my advisor's request, I will be using data that has already been published to test my code publicly. However, I intend to utilize data sets that are not yet in manuscript form to test the ability of my code to adapt to different data sets. 

<hr>

## Summary of Data to be Analyzed

### Goals of original study that produced the data (~1 paragraph)

The original study that produced the data for this project is titled: ![_Effects of extracellular microvesicles from spinal cord-injured adults on endothelial cell function_](https://portlandpress.com/clinsci/article/134/7/777/222483/Effects-of-circulating-extracellular-microvesicles). 

Spinal cord-injured (SCI) adults are at a greater risk for the development of CVD, but the mechanisms for this are not well understood. Some studies have shown that the functional phenotype of MVs is altered  based on their origin and have been implicated in the progression of CVD. It is possible that MVs from adults wirth SCI contribute to their increased cardiovascular risk. Accordingly, the aim of this study was to determine, _in vitro_, the effects of MVs from SCI adults on endothelial cell inflammation, oxidative stress, nitric oxide (NO) production and tissue-type plasminogen activator (t-PA) expression. 

### Brief description of methodology that produced the data

Whole venous blood was collected from SCI and healthy adults and subsequentlly centirfuged to isolate plasma. A portion of the plasma was taken to measure circulating markers of inflammation and oxidative stress by enzymne linked immunoassay (ELISA). The remaining plasma was then ultracentrifuged amnd resuspended in cell culture media to isolate MVs. Human umbilical vein endothelial cells (HUVECs) were cultured and serially passaged to the 3rd passage where experimentatin occured. HUVECs were treated with MVs isolated from the SCI or healthy adults at equal cncentrations for 24 hours. Thereafter, supernatant was collected to analyze the cellular release of IL-6, IL-8, TNF-alpha, and t-PA via ELISA. Adiditonally, supernatant was used to assess NO production using a commercially available total NO and Nitrate/Nitrite Parameter Assay. Intracellular protein was isolated using RIPA buffer and sonicaiton and total protein concentration was determined using the Bio-Rad DC protein assay. Therafter, specific intracellular protein markers (NF-kB p65, pNF-kB p65, p-eNOS Ser1177, p-eNOS Ser633, p-eNOS Thr495, SOD1, catalase, and t-PA) were measured using capillary electrophoresis immunoassay. Intracellular microRNA (miRNA) were determined by first isolating RNA from cells, reverse transcribing RNA into cDNA, and RT-PCR performed with specific primers of interest: miR-21, miR-126, miR-146a, miR-181b, miR-200c, and U6. Finally the produictive of reactive oxygen species was assessed using CellRox DeepRed reagent and measured with GEMINI EM microplate reader after 3 hours of MV treatment on HUVECs. 

Though it is not outlined in the study, statistics were performed using Statistica and StatView applicaitons (no programming or coding was involved). The details of the statistical tests performed are detailed below: 

>"The distribution of the data was assessed by the Shapiro–Wilk test and the homogeneity of variances by the Levene test. Group differences in subject characteristics, circulating inflammation and oxidative stress markers, cellular pro- tein miRNA expression as well as cellular oxidative stress were determined by either analysis of variance (normally distributed data) or Mann–Whitney U test (non-normally distributed data). Data are presented as mean +− SEM for normally distributed variables and as the median (interquartile range) for non-normally distributed variables. Pear- son correlations were determined between variables of interest. Statistical significance was set a priori at P<0.05."

### Type of data in this data set:  

#### Format of data  
The data are originally formatted in a .xlsx file and saved as a .csv file to perform statistics. The first line of the data is headers for each outcome of interest. Each row thereafter is the indivudal value for each outcome for a single subject. There is a column to identify which group the subject belongs to in order to compare groups later. An example of the dataset can be accessed ![here]().

#### Size of data (i.e., megabytes, lines, etc.)
* megabytes: 
* lines:  

_NOTE: These parameters will change depending on the dataset I am working with, the dataset used in this specific example contians the size of the data used to publish the original study. Code will be intended to accomodate various sized data._

#### Any inconsistencies in the data files?  Anything that looks problematic?  
There are some incosistencies within the data files. For exmaple, depending on the population of MVs being studied, we may not look at a certain marker, or sometimes assays justy don't work and we don't have data on the outcome. Therefore, if will be imperative that I do not hard code any magic numbers into my project so that it can evewntually work with data that is not exactly the same format each time. 

#### What the data represent about the biology? (optional; this subsection may not be needed if the biological significance has already been covered in your previous descriptions)


<hr>

## Detailed Description of Analysis to be Done and Challenges Involved

For this project I will be repeating statistical analysis from the paper using programming in RStudio. 

1. _View and Reformat Data_ 
    1.  Use str( ) function to understand details of the data  
    2. Store any size characteristics or other variables that may be important later (i.e. number of columns/rows)
    3. Understanding the headers will be important in later analysis (and the specific outcomes for the data)
        * Change headers if they do not match how you will address them later in the code (be descriptive, but concise)
    iv. Remove (or build in error messages) for any columns/rows with missing data
    
2. _User Input_
    i. The goal of this section will be to allow the user, in real-time, to give input as to what data they would like to view. For example:
        * All data 
        * Just markers of inflammation, oxidative stress, etc...
        * Just protein, microRNA, cytokine markers
        * Just a single marker/outcome 
    ii. Important things to consider: 
    * The choices of input need to reflect the outcomes in the data, that is, they should be flexible. 
    * Choices also need to be "idiot proof" (i.e. provide error messages if they do not choose a valid option)
    * Will need menu list of coices based on outcomes, loops until an option given is actually chosen, and then if statements to determine what to do in the following steps. 
    
3. _Program Output_
    i. Parametric testing: 
        * Levene test 
        * P-value used with conditional statements to determine what testing should be done and what values to report 
    ii. Appropriate Descirptive and Inferential Statistics 
        * Normal distribution: Mean +/- SEM, ANOVA
        * Non-normal distribution: Median [IQR], Mann-Whitney U test
    iii. Table and graph output 
        * Another opportunity for user input with graphing - Do they want dot plots or bar graphs? 
        * Tables should reflect: 
            * Testing done and associated P-values (for both normality tests and group comparisons) 
            * Descriptive statistics (mean and/or median)
            * Highlighted or print statement which should go into the manuscript (e.g. IL-6: mean +− SEM: 36.5 +− 1.5 vs 36.5 +− 0.8 pg/ml)
                * This will make it easy to copy and paste right into manuscript. 


        
    
    
    





<hr>

## References 

Please include working hyperlinks to original sources.  Here is an example format:

Cusack JJ, Dickman AJ, Rowcliffe JM, Carbone C, Macdonald DW, Coulson T (2015) Random versus game trail-based camera trap placement strategy for monitoring terrestrial mammal communities. PLOS ONE 10(5): e0126373. [https://doi.org/10.1371/journal.pone.0126373](https://doi.org/10.1371/journal.pone.0126373)

Cusack JJ, Dickman AJ, Rowcliffe JM, Carbone C, Macdonald DW, Coulson T (2015) Data from: Random versus game trail-based camera trap placement strategy for monitoring terrestrial mammal communities. Dryad Digital Repository. [https://doi.org/10.5061/dryad.br86d](https://doi.org/10.5061/dryad.br86d)




# Data Manipulation and Quantitative Analysis of the Effect of Microvesicles on Endothelial Cell Function using RStudio
## Introduction

_The effect of microvesicles on endothelial function and the progression of cardiocascular disease -_ Endothelial dysfunction is the harbinger of atherosclerosis (6, 7). Extracellular microvesicles (MVs) are small outward blebbings of the plasma membrane, which contain various cargo such as RNA, proteins, and microRNAs and are released from almost all cell types in response to cellular apoptosis and/or activation (2, 12, 16). Recently, MVs have emerged as important mediators and effectors of endothelial dysfunction and the progression of atherosclerosis and cardiovascular disease (CVD) (2, 9, 10). There are a growing number of diseases and conditions that are tied to increased cardiovascular risk, however, the mechanistic relations between these comorbidities are not well understood. For example, adults with human immunodeficiency virus (HIV)-1, chronic mountain sickness (CMS), and spinal cord injury (SCI) all have increased risk for the development of CVD (1, 8, 15). One study, which looked that the effect of MVs  isolated from HIV-1-seropositive adults on endothelial function, demonstrated that MVs might be responsible for the link between HIV-1 and increased cardiovascular risk (8). 

_The significance of correct statiastical analysis in biological research -_ Parametric (normality) testing, which tests the homogeneity of variance in a set of data, is an important precursor for the interpretation of all data. The distribution of data effects the descriptive statistics that are published and compared as well as the inferential statistical testing performed to draw conclusions from the data (5). Depending on the breadth of the study, the dependent variables (outcomes of interest) can be vast. Therefore, efficient and streamlined methodologies of normality testing and the associated statistics should be employed.

_The fundamental goal of my research in general_ My research explores the effects of microvesicles isolated from human populations on endothelial cell function. To determine endothelial function, we look at cellular cytokine release as well as intracellular protein and microRNA in response to MV treatment.  In the following project, I intend to use a typical set of data that my lab has used to publish in a manuscript and automate the parametric testing and the associated descriptive and inferential statistics using RStudio. As per my advisor's request, I will be using data that has already been published to test my code publicly. However, I intend to utilize data sets that are not yet in manuscript form to test the ability of my code to adapt to different data sets. 

<hr>

## Summary of Data to be Analyzed

### Goals of original study that produced the data (~1 paragraph)

The original study that produced the data for this project is titled: ![_Effects of extracellular microvesicles from spinal cord-injured adults on endothelial cell function_](https://portlandpress.com/clinsci/article/134/7/777/222483/Effects-of-circulating-extracellular-microvesicles). 

Spinal cord-injured (SCI) adults are at a greater risk for the development of CVD, but the mechanisms for this are not well understood (3, 4, 13). Some studies have shown that the functional phenotype of MVs is altered based on their origin and have been implicated in the progression of CVD (11, 14). It is possible that MVs from adults with SCI contribute to their increased cardiovascular risk. Accordingly, the aim of this study was to determine, _in vitro_, the effects of MVs from SCI adults on endothelial cell inflammation, oxidative stress, nitric oxide (NO) production and tissue-type plasminogen activator (t-PA) expression.

### Brief description of methodology that produced the data

Whole venous blood was collected from SCI and healthy adults and subsequently centrifuged to isolate plasma. A portion of the plasma was taken to measure circulating markers of inflammation and oxidative stress by enzyme linked immunoassay (ELISA). The remaining plasma was then ultracentrifuged and resuspended in cell culture media to isolate MVs. Human umbilical vein endothelial cells (HUVECs) were cultured and serially passaged to the 3rd passage where experimentation occurred. HUVECs were treated with MVs isolated from the SCI or healthy adults at equal concentrations for 24 hours. Thereafter, supernatant was collected to analyze the cellular release of IL-6, IL-8, TNF-alpha, and t-PA via ELISA. Additionally, supernatant was used to assess NO production using a commercially available total NO and Nitrate/Nitrite Parameter Assay. Intracellular protein was isolated using RIPA buffer and sonication and total protein concentration was determined using the Bio-Rad DC protein assay. Thereafter, specific intracellular protein markers (NF-kB p65, p-NF-kB p65, p-eNOS Ser1177, p-eNOS Ser633, p-eNOS Thr495, SOD1, catalase, and t-PA) were measured using capillary electrophoresis immunoassay. Intracellular microRNA (miRNA) were determined by first isolating RNA from cells, reverse transcribing RNA into cDNA, and RT-PCR performed with specific primers of interest: miR-21, miR-126, miR-146a, miR-181b, miR-200c, and U6. Finally, the productive of reactive oxygen species was assessed using CellRox Deep Red reagent and measured with GEMINI EM microplate reader after 3 hours of MV treatment on HUVECs. (1) 

Though it is not outlined in the study, statistics were performed using Statistica and StatView applicaitons (no programming or coding was involved). The details of the statistical tests performed are detailed below: 

>"The distribution of the data was assessed by the Shapiro–Wilk test and the homogeneity of variances by the Levene test. Group differences in subject characteristics, circulating inflammation and oxidative stress markers, cellular pro- tein miRNA expression as well as cellular oxidative stress were determined by either analysis of variance (normally distributed data) or Mann–Whitney U test (non-normally distributed data). Data are presented as mean +/− SEM for normally distributed variables and as the median (interquartile range) for non-normally distributed variables. Pear- son correlations were determined between variables of interest. Statistical significance was set a priori at P<0.05." (1) 

### Type of data in this data set:  

#### Format of data  
The data are originally formatted in a .xlsx file and saved as a .csv file to perform statistics. The first line of the data is headers for each outcome of interest. Each row thereafter is the indivudal value for each outcome for a single subject. There is a column to identify which group the subject belongs to in order to compare groups later. An example of the dataset can be accessed ![here](https://github.com/maddenbrewster/CompBioLabsAndHomework/blob/master/Independent%20Project%20/SCI_data.csv).

Addtionally, please view the ![SCI_README.csv]( file in order to understand and interpret the specific outcomes in this dataset. 

#### Size of data (i.e., megabytes, lines, etc.)
* Kilobytes: 4 KB
* Lines:  20
* Columns: 30 

_NOTE: These parameters will change depending on the dataset I am working with, the dataset used in this specific example contians the size of the data used to publish the original study. Code will be intended to accomodate various sized data._

#### Any inconsistencies in the data files?  Anything that looks problematic?  
There are some incosistencies within the data files. For exmaple, depending on the population of MVs being studied, we may not look at a certain marker, or sometimes assays justy do not work and we do not have data on the outcome. Therefore, it will be imperative that I do not hard code any magic numbers into my project so that it can eventually work with data that is not exactly the same format each time. 

## Detailed Description of Analysis to be Done and Challenges Involved

For this project I will be repeating statistical analysis from the paper using programming in RStudio. 

1. _View and Reformat Data_ 
    1.  Use str( ) function to understand details of the data  
    2. Store any size characteristics or other variables that may be important later (i.e. number of columns/rows)
    3. Understanding the headers will be important in later analysis (and the specific outcomes for the data)
        * Change headers if they do not match how you will address them later in the code (be descriptive, but concise)
    iv. Remove (or build in error messages) for any columns/rows with missing data
    
2. _User Input_
    1. The goal of this section will be to allow the user, in real-time, to give input as to what data they would like to view. For example:
        * All data 
        * Just markers of inflammation, oxidative stress, etc...
        * Just protein, microRNA, cytokine markers
        * Just a single marker/outcome 
    2. Important things to consider: 
        * The choices of input need to reflect the outcomes in the data, that is, they should be flexible. 
        * Choices also need to be "idiot proof" (i.e. provide error messages if they do not choose a valid option)
        * Will need menu list of choices based on outcomes, loops until an option given is actually chosen, and then if statements to determine what to do in the following steps. 
    
3. _Program Output_
    1. Parametric testing: 
        * Levene test 
        * P-value used with conditional statements to determine what testing should be done and what values to report 
    2. Appropriate Descriptive and Inferential Statistics 
        * Normal distribution: Mean +/- SEM, ANOVA
        * Non-normal distribution: Median [IQR], Mann-Whitney U test
    3. Table and graph output 
        * Another opportunity for user input with graphing - Do they want dot plots or bar graphs? 
        * Tables should reflect: 
            * Testing done and associated P-values (for both normality tests and group comparisons) 
            * Descriptive statistics (mean and/or median)
            * Highlighted or print statement which should go into the manuscript (e.g. IL-6: mean +− SEM: 36.5 +− 1.5 vs 36.5 +− 0.8 pg/ml)
                * This will make it easy to copy and paste right into manuscript. 


<hr>

## References 

1.  Brewster LM, Coombs GB, Garcia VP, Hijmans JG, DeSouza NM, Stockelman KA, Barak OF, Mijacika T, Dujic Z, Greiner JJ, Phillips AA, Ainslie PN, DeSouza CA. Effects of circulating extracellular microvesicles from spinal cord injured adults on endothelial cell function. Clinical Science ( March 27, 2020). ![https://doi.org/10.1042/cs20200047]()
2.   Chen Y, Li G, Liu M-L. Microvesicles as Emerging Biomarkers and Therapeutic Targets in Cardiometabolic Diseases. Genomics, Proteomics & Bioinformatics 16: 50–62, 2018. ![https://doi.org/10.1016/j.gpb.2017.03.006]()
3.    Cragg JJ, Noonan VK, Krassioukov A, Borisoff J. Cardiovascular disease and spinal cord injury: Results from a national population health survey. Neurology 81: 723–728, 2013. ![https://doi.org/10.1097/PHM.0b013e31802f0247]()
4.    Cragg JJ, Stone JA, Krassioukov AV. Management of Cardiovascular Disease Risk Factors in Individuals with Chronic Spinal Cord Injury: An Evidence-Based Review. Journal of Neurotrauma 29: 1999–2012, 2012. ![https://doi.org/10.1089/neu.2012.2313]()
5.    Ghasemi A, Zahediasl S. Normality Tests for Statistical Analysis: A Guide for Non-Statisticians. Int J Endocrinol Metab 10: 486–489, 2012. ![https://doi.org/10.5812/ijem.3505]()
6.    Gimbrone MA, García-Cardeña G. Endothelial Cell Dysfunction and the Pathobiology of Atherosclerosis. Circ Res 118: 620–636, 2016. ![https://doi.org/10.1161/CIRCRESAHA.115.306301]()
7.    Hadi HA, Carr CS, Al Suwaidi J. Endothelial Dysfunction: Cardiovascular Risk Factors, Therapy, and Outcome. Vasc Health Risk Manag 1: 183–198, 2005. ![https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1993955/]()
8.    Hijmans JG, Stockelman KA, Garcia V, Levy MV, Brewster LM, Bammert TD, Greiner JJ, Stauffer BL, Connick E, DeSouza CA. Circulating Microparticles Are Elevated in Treated HIV‐1 Infection and Are Deleterious to Endothelial Cell Function. Journal of the American Heart Association 8, 2019. ![https://doi.org/10.1161/JAHA.118.011134]()
9.    Liu M-L, Williams KJ. Microvesicles: potential markers and mediators of endothelial dysfunction. Curr Opin Endocrinol Diabetes Obes 19: 121–127, 2012. ![https://doi.org/10.1161/01.ATV.0000191634.13057.15]()
10.    Lovren F, Verma S. Evolving Role of Microparticles in the Pathophysiology of Endothelial Dysfunction. Clinical Chemistry 59: 1166–1174, 2013. ![https://doi.org/10.1373/clinchem.2012.199711]()
11.    Meziani F, Tesse A, Andriantsitohaina R. Microparticles are vectors of paradoxical information in vascular cells including the endothelium: role in health and diseases. Pharmacol Rep 60: 75–84, 2008. ![https://pubmed.ncbi.nlm.nih.gov/18276988/]()
12.    Muralidharan-Chari V, Clancy JW, Sedgwick A, D’Souza-Schorey C. Microvesicles: mediators of extracellular communication during cancer progression. J Cell Sci 123: 1603–1611, 2010. ![https://doi.org/10.1242/jcs.064386]()
13.    Phillips AA, Krassioukov AV. Contemporary Cardiovascular Concerns after Spinal Cord Injury: Mechanisms, Maladaptations, and Management. Journal of Neurotrauma 32: 1927–1942, 2015. ![https://doi.org/10.1089/neu.2015.3903]()
14.    Rautou Pierre-Emmanuel, Vion Anne-Clémence, Amabile Nicolas, Chironi Gilles, Simon Alain, Tedgui Alain, Boulanger Chantal M., Weber Christian, Mause Sebastian. Microparticles, Vascular Function, and Atherothrombosis. Circulation Research 109: 593–606, 2011. ![https://doi.org/10.1161/CIRCRESAHA.110.233163]()
15.    Rimoldi SF, Rexhaj E, Pratali L, Bailey DM, Hutter D, Faita F, Salinas Salmòn C, Villena M, Nicod P, Allemann Y, Scherrer U, Sartori C. Systemic Vascular Dysfunction in Patients With Chronic Mountain Sickness. Chest 141: 139–146, 2012. ![https://doi.org/10.1378/chest.11-0342]()
16.    Ståhl A, Johansson K, Mossberg M, Kahn R, Karpman D. Exosomes and microvesicles in normal physiology, pathophysiology, and renal diseases. Pediatr Nephrol 34: 11–30, 2019. ![https://doi.org/10.1007/s00467-017-3816-z]()








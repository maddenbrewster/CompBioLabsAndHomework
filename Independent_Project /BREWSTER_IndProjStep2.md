
# Data Manipulation and Quantitative Analysis of the Effect of Microvesicles on Endothelial Cell Function using RStudio

### Biological question

The primary aim of this project is to use coding/programming methods in RStudio to streamline statistical ananlysis and  graphical output in a typical dataset that my research produces. As a whole, these ananlyses will be used to determine the role of extracellular microvesicels on endothelial cell function. 

### Context (introduction) -- need to ADAPT!!

_The effect of microvesicles on endothelial function and the progression of cardiocascular disease -_ Endothelial dysfunction is the harbinger of atherosclerosis (6, 7). Extracellular microvesicles (MVs) are small outward blebbings of the plasma membrane, which contain various cargo such as RNA, proteins, and microRNAs and are released from almost all cell types in response to cellular apoptosis and/or activation (2, 12, 16). Recently, MVs have emerged as important mediators and effectors of endothelial dysfunction and the progression of atherosclerosis and cardiovascular disease (CVD) (2, 9, 10). There are a growing number of diseases and conditions that are tied to increased cardiovascular risk, however, the mechanistic relations between these comorbidities are not well understood. For example, adults with human immunodeficiency virus (HIV)-1, chronic mountain sickness (CMS), and spinal cord injury (SCI) all have increased risk for the development of CVD (1, 8, 15). One study, which looked that the effect of MVs  isolated from HIV-1-seropositive adults on endothelial function, demonstrated that MVs might be responsible for the link between HIV-1 and increased cardiovascular risk (8). 

_The significance of correct statiastical analysis in biological research -_ Parametric (normality) testing, which tests the homogeneity of variance in a set of data, is an important precursor for the interpretation of all data. The distribution of data effects the descriptive statistics that are published and compared as well as the inferential statistical testing performed to draw conclusions from the data (5). Depending on the breadth of the study, the dependent variables (outcomes of interest) can be vast. Therefore, efficient and streamlined methodologies of normality testing and the associated statistics should be employed.

_The fundamental goal of my research in general_ My research explores the effects of microvesicles isolated from human populations on endothelial cell function. To determine endothelial function, we look at cellular cytokine release as well as intracellular protein and microRNA in response to MV treatment.  In the following project, I intend to use a typical set of data that my lab has used to publish in a manuscript and automate the parametric testing and the associated descriptive and inferential statistics using RStudio. As per my advisor's request, I will be using data that has already been published to test my code publicly. However, I intend to utilize data sets that are not yet in manuscript form to test the ability of my code to adapt to different data sets. 


### Methods
##### The source of the data:
The original study that produced the data to use as a sample dataset for this project is titled: ![_Effects of extracellular microvesicles from spinal cord-injured adults on endothelial cell function_](https://portlandpress.com/clinsci/article/134/7/777/222483/Effects-of-circulating-extracellular-microvesicles). 

Spinal cord-injured (SCI) adults are at a greater risk for the development of CVD, but the mechanisms for this are not well understood (3, 4, 13). Some studies have shown that the functional phenotype of MVs is altered based on their origin and have been implicated in the progression of CVD (11, 14). It is possible that MVs from adults with SCI contribute to their increased cardiovascular risk. Accordingly, the aim of this study was to determine, _in vitro_, the effects of MVs from SCI adults on endothelial cell inflammation, oxidative stress, nitric oxide (NO) production and tissue-type plasminogen activator (t-PA) expression.

Whole venous blood was collected from SCI and healthy adults and subsequently centrifuged to isolate plasma. A portion of the plasma was taken to measure circulating markers of inflammation and oxidative stress by enzyme linked immunoassay (ELISA). The remaining plasma was then ultracentrifuged and resuspended in cell culture media to isolate MVs. Human umbilical vein endothelial cells (HUVECs) were cultured and serially passaged to the 3rd passage where experimentation occurred. HUVECs were treated with MVs isolated from the SCI or healthy adults at equal concentrations for 24 hours. Thereafter, supernatant was collected to analyze the cellular release of IL-6, IL-8, TNF-alpha, and t-PA via ELISA. Additionally, supernatant was used to assess NO production using a commercially available total NO and Nitrate/Nitrite Parameter Assay. Intracellular protein was isolated using RIPA buffer and sonication and total protein concentration was determined using the Bio-Rad DC protein assay. Thereafter, specific intracellular protein markers (NF-kB p65, p-NF-kB p65, p-eNOS Ser1177, p-eNOS Ser633, p-eNOS Thr495, SOD1, catalase, and t-PA) were measured using capillary electrophoresis immunoassay. Intracellular microRNA (miRNA) were determined by first isolating RNA from cells, reverse transcribing RNA into cDNA, and RT-PCR performed with specific primers of interest: miR-21, miR-126, miR-146a, miR-181b, miR-200c, and U6. Finally, the productive of reactive oxygen species was assessed using CellRox Deep Red reagent and measured with GEMINI EM microplate reader after 3 hours of MV treatment on HUVECs. (1) 


###### Format of the Data 
The data are originally formatted in a .xlsx file and saved as a .csv file to perform statistics. The first line of the data is headers for each outcome of interest. Each row thereafter is the indivudal value for each outcome for a single subject (i.e. the data is in wide format). There is a column to identify which group the subject belongs to in order to compare groups later. An example of the dataset can be accessed ![here](https://github.com/maddenbrewster/CompBioLabsAndHomework/blob/master/Independent%20Project%20/SCI_data.csv).

Addtionally, please view the ![SCI_README](https://github.com/maddenbrewster/CompBioLabsAndHomework/blob/master/Independent%20Project%20/SCI_README.md) file in order to understand and interpret the specific outcomes in this dataset. 

###### Size of data (i.e., megabytes, lines, etc.)
* Kilobytes: 4 KB
* Lines:  20
* Columns: 30 

_NOTE: These parameters will change depending on the dataset I am working with, the dataset used in this specific example contians the size of the data used to publish the original study. Code will be written to accomodate various sized data._

###### Original authors approach and methodology for data analysis: 
Though it is not outlined in the study, statistics were performed using Statistica and StatView applicaitons (no programming or coding was involved). The details of the statistical tests performed are detailed below: 

>"The distribution of the data was assessed by the Shapiro–Wilk test and the homogeneity of variances by the Levene test. Group differences in subject characteristics, circulating inflammation and oxidative stress markers, cellular pro- tein miRNA expression as well as cellular oxidative stress were determined by either analysis of variance (normally distributed data) or Mann–Whitney U test (non-normally distributed data). Data are presented as mean +/− SEM for normally distributed variables and as the median (interquartile range) for non-normally distributed variables. Pear- son correlations were determined between variables of interest. Statistical significance was set a priori at P<0.05." (1) 

For normality testing, a statsitcis software program called Statistica was used. Importantly, Statistica can only be run on a Windows Operating System. Additionally, the testing for each dependent variable is run one at a time and then manually entered into a separate Excel sheet (set-up by the user). This renders the resulting data, which will be used for other statistical testing and reported statistics to be prone to human error. 

For inferential statistics testing, an old statistics software program called StatView. First, a dataset in Excel must be saved as a "1997-2004 .xls" file. Importantly, this renders the file unable to be opened on newer versions of Excel and may modify formatting of the the original dataset. The .xls file must then be opened on a specific single computer and opened with an older donwloaded version of Excel (version 11.5.3). Once the .xls is opened, it must be saved as a "Worksheet 4.0." The dataset is now ready to be opened in the StatView application where statistics can be run one dependent variable at a time.  

##### My approach and methodology for data analysis:

1. The first thing I did was write out comments in my RScript of what the different components of the final goal for my code was. 
 > e.g. 
 > #Download data set 
 > #Remove missing data and any other data "debris"
 > #Do statistics 
 > #Make output: table, graph, summary statement

2. Writing functions and other small coding chunks that would do the bulk of the work (i.e. building the table, creating the graphs, performing testing and descriptive statistics)
> e.g. 
> User input functions: asking user for what data they want to analyze and how they wanted the data graphed 
> Table functions: built skeleton of table (preallocation) and function to acutally put all the correct values into the table 
> Statistics functions: normality testing, categorical determinations, interential statistics and descriptive statistics all to eventuall fill the table, make summary statements, or generate graphs

3. Next I decided to put in user input and if statements and implement it in  a "main" code section that started to call on my functions created above. 

4. Adapt. Adapt. Adapt. Based on what arguments my functions took, I sometimes had to reformat data/change the functions themselves, etc. finally, making sure I changed any "magic numbers" to flexible code. 

6. Error checks. I put in several "error" checks - mostly having to so with user input that was incompatible with my code and the options they were given.

7. Try with another dataset...To be continued. 

### Results and conclusions

Overall, this project took a lot more time and effort than I anticipated. I thought that it would be relatviely easy to format the data and run relatively simple statistics, but I kept coming up with more ideas and more errors and more rabbit holes that took _time_! Bottom line, this is still a work in progress. For the purpose of this project, I wanted to turn in working code and have it accomplish most of my goals, but there are still major limitations as outlined below. 

My code _did_ acocmplish my primary aim, which was to perform the statistical analyses and graphical output in a typical dataset that my research produces using RStudio/programming methods. As it functions now, my code produces saved PDF files of the ![graphs](kj) the user wants, as well as ![summary tables]( ddd) saved as .csv files for the data of interest. Additionally, I was able to give the user some autonomy to how they would like to view they data by using the readline( ) function in R. Finally, I was able to print summary statements for each variable to the R Console, which would be incredibly helpful to put values into a manuscript with ease. Despite the wirritng of the code taking quite a bit of time, this automated process was _infinitely_ faster than the original methodology emploed by the authors. Overall, I found that my resulsts were the same to that published in the article,* which was the intention of this project. That is, microvesicles from adults with spinal cord injury result in blunted eNOS activation, NO bioavailability, and t-PA production, which likely contirbutes to their increased cardiovascular risk. 

There are obviously some limitaitons in my code. As of today, I am unsure how "flexible" my code is with other similar datasets. As I continue to work with it, I would like to check that it functions  in a simiular manner to the sample dataset used for this project. Additionally, I would like to input a lot more error checking in order to accomplish the translational nature of the code between datasets. For example, my code assumes that the 1st two columns of the data set are character categories giving the Group and Subject names. While this is the case for almost all datasets I produce, it would still be good to put in checks to ensure this, especially since some indexing starts at 3 for this reason. There are also points in the code where I repeat some of the same functions (i.e. graphing, while loops for user input, etc), I should probably go back and re-write these chunks as my own functions to streamline the code. Further, there are points where I use loops when logical indexing or other techniques could be used, but I just wrote what first came to mind. Bottom line, there is a lot of cleaning up I can do with my code. 

If I were to re-do this project, I probably would have approached it a little differently in that I would have spent a _lot_ more time on the pseudocode and planning. There are several reasons for this, but primarily, I think my code would have been cleaner all around. I would have ultimately spent less time cutting and pasting and rewriting chunks of code as functions and jumping around from section to section if I just had a clearer plan. The interesting challenge of this project was not that I didn't know how to do everything I needed to do - I had all the tools - I just didn't know how to combine them in a clear and concise way.  

*_Disclaimer_: I did not check every single number I created in my code with the numbers published in the paper, but that is something I want to do in order to fully check my code for bugs. 


### References
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

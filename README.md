# GJRM
This project reports R code and data for the paper "Link-Based Survival Additive Models under Mixed Censoring to Assess Risks of Hospital-Acquired Infections".

The following libraries shall be installed in R before using code from
this project:

library(GJRM)

library(xtable)

Data described in the paper are given as R workspace dataInfections.RData.
These can be loaded directly into R using command load.
They report about 678 cirrhotic patients who were admitted to Policlinico Umberto I hospital in Rome, Italy, between 2009 and 2017. The endpoint is a composite one, where an event is defined as the occurrence of an infection or death before hospital discharge. Times are recorded from admission. The main scientific questions with the data at hand revolve around the possibility of an increased risk of infection or death due to the use of catheterism, paracentesis, and overcrowding of the ward.

In the data frame "dati", variables “u1” , “u2” and “cens” have the same notation as the main paper. All other variable names are self-explanatory, with the exception of “bed”, which is an indicator of crowded wards

Data can be used for research purposes, upon citation of the present paper and the clinical one (reference will be added in due course). 


File code.r contains R code for reproducing the data analysis reported in the paper. In particular, comments indicate where Figure 2, Figure 3 and Table 2 can be reproduced. 



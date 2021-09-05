# DCM pipeline
The Following series of script reproduces the analysis reported in Lorenzini L., van Wingen G., Cerliani L., "Atypically high influence of subcortical activity on primary sensory regions in Autism".
It starts from an input dataset of **pre-processed** NIfTI files and process them using Dynamic Causal Modelling (DCM) and Parametric Empirical Bayes (PEB) pipeline from [SPM](https://www.fil.ion.ucl.ac.uk/spm/), to estimate subcortico-cortical effective connectivity in ASD and TD participants from the ABIDE dataset.. 
Useful links and tutorials on DCM and PEB in SPM can be found [here]( https://www.sciencedirect.com/science/article/pii/S1053811919305233) and [here](https://en.wikibooks.org/wiki/SPM/Parametric_Empirical_Bayes_(PEB)#Overview). 



01_SPM_specification: Specify and estimate the SPM.mat from each participants NIfTI file

02_Timecourse extraction: Extract ROI timecourses from the 5 regions used in the manuscript. 

03_DCM_estimation: Estimates Dynamic Causal models (DCM) for each subject in the analysis. The DCM specify the relationship between subcortical and primary sensory cortical regions as specified in the manuscript. 

04_PEB_Group_Age: Run the PEB analysis to investigate the effect of group, age and the interaction between the two on DCM parameters (main analysis presented in the manuscript). 

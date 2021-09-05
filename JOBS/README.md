# DCM pipeline
The Following series of script reproduces the analysis reported in Lorenzini L., van Wingen G., Cerliani L., "Atypically high influence of subcortical activity on primary sensory regions in Autism".
It starts from an input dataset of **pre-processed** NIfTI files and process them using Dynamic Causal Modelling (DCM) and Parametric Empirical Bayes (PEB) pipeline from [SPM](https://www.fil.ion.ucl.ac.uk/spm/), to estimate subcortico-cortical effective connectivity in ASD and TD participants from the ABIDE dataset. 

Useful links and tutorials on DCM and PEB in SPM can be found [here]( https://www.sciencedirect.com/science/article/pii/S1053811919305233) and [here](https://en.wikibooks.org/wiki/SPM/Parametric_Empirical_Bayes_(PEB)#Overview). 

## Data Availabaility

Pre-processed NIfTI files are available in a zenodo repository ** HERE ADD THE LINK WHEN THAT IS READY **. 
** ADD Instruction to download them **

## Structure of Directories

The scripts are ordered in folders starting with numbers (01, 02) describing the order in which they should be used. Each folder contains only one script. 


In all scripts you are asked to modify the first three lines with the path to the cloned directory and to the SPM toolbox on your local PC.

```
% Change the following lines to match your own repositories
addpath('/PATH/TO/SPM') % ADD the path to your SPM repository
basedir = '/path/to/your/repository/' % Change this line with the pat to the downloaded github repository
```


The shared scripts follow a folder structure as it is presented in the github repository. The cloned directory can be placed everywhere and should include the downloaded data from zenodo (SUB_359). This is an example folder structure:

```
MyPC/github/ASD_DCM_subcortex_sensory/
├── CSVs
├── GCMs
├── ICA_results
├── SUB_359
├── pheno
└── JOBS
     └── 01_SPM_Specification
                └── do_spm_mats.m
     └── 02_ ...

```



## 01_SPM_specification
The first provided scripts specify and estimates the SPM.mat from each participant's NIfTI. SPM.mat files are the basic files for working with SPM and contain information about the fMRI session. 
As the fMRI pre-processing was previously performed, this script is limited to a NIfTI to SPM.mat conversion, and no additional processing step is performed at this stage. 
Pre-processed NIfTI files should be places in a `SUB_359` folder in the base directory (see above). 
```
SUB_359/
├── 50004
└── 50005
	└── 50005_RS_bptf_clean.nii.gz
```

Within each subject folder the script will create a `RESULTS` folder, which will store the SPM.mat and other derivatives created by the pipeline. 


```
SUB_359/
├── 50004
└── 50005
	└── 50005_RS_bptf_clean.nii.gz
	└── RESULTS
		└── SPM.mat
```



## 02_Timecourse extraction
do_timcourse_extraction.m takes as input the SPM.mat files generated in the previous step and the ICA masks defining the ROI for the analysis. 
ICA masks should be placed in:

```
ASD_DCM_subcortex_sensory/   # Cloned directory
└── ICA_results
	└── melodic_IC52_JAMA2015_bin.nii.gz

```

This script cut the needed volumes from the melodic output and uses them as masks for timecourses extraction in SPM. 
Output timeseries are saved in subjects' folders `RESULTS`. After running this job the SUB_359 should have this struture: 

```
SUB_359/
├── 50004
└── 50005
	└── 50005_RS_bptf_clean.nii.gz
	└── RESULTS
		└── SPM.mat
		└── VOI_SUBCORTICAL_1.mat
		└── VOI_V1_1.mat
		└── VOI_dS1M1_1.mat
		└── VOI_vS1M1_1.mat
		└── VOI_U1_1.mat
```


## 03_DCM_estimation
do_DCM_estimation.m specifies and estimates Dynamic Causal models (DCM) for each subject in the analysis. 
The DCMs specify the relationship between subcortical and primary sensory cortical regions as specified in the manuscript. 
The script uses inputs generated in the previous steps and stored in th `RESULTS` folders. 
1. In each `RESULTS` folder a `DCM_full.mat` will be specified in this step.
2. A `GCM_pre_estimated.mat` (group DCM before estimation) file will be saved in the `GCMs` folder]
3. Estimation of GCM will generate a `GCM_estimated.mat` in the `GCM` folder



## 04_PEB_Group_Age
This step reproduces the MAIN analyisis described in the manuscript, investigating the effect of age and its interaction with group (ASD/TD) on the subcortico-cortical effective connectivity. Inputs to this script are the files created in the previous steps of the pipeline.
The script is follows two main steps: 
1. Creation of the design matrix including mean (1s), age, group, age*group, motion (FD).
2. Second level PEB analysis: This step will run the PEB analysis as described in the manuscript. Running this script will open up the SPM PEB interface to review the results with the classic SPM graphic. 

Output of this analysis will be saved in:

```
ASD_DCM_subcortex_sensory/
└── Interaction_Group_Age_analysis
```

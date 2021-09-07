# ASD_DCM_subcortex_sensory

Companion code and data to: Lorenzini L., van Wingen G., Cerliani L., "Atypically high influence of subcortical activity on primary sensory regions in Autism".

This distribution provides the data and the codes to reproduce the analyses of differences in functional effective connectivity described in the manuscript. 

[MATLAB](https://mathworks.com) and [SPM](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) must be installed. 


DISCLAIMER The software is provided 'AS IS'. The public distribution of this script is UNIQUELY intended to provide an accurate documentation of the analyses performed in the published manuscript. The author declines any responsibility regarding machine malfunctioning or data loss due to the use of this script in the version provided here or in any modification of it.

## Downloading codes and data

The repository can be downloaded by running the following code on your on machine

```
git clone https://github.com/luislorenzini/ASD_DCM_subcortex_sensory.git
```

The fMRI data are stored in a separate folder and must be downloaded separately to be able to reproduce the analysis. 
To download the fMRI NIfTI files go to [https://zenodo.org/record/5463495#.YTdw2J0zZPY](https://zenodo.org/record/5463495#.YTdw2J0zZPY) and click on the Download button. 
Once the zip folder has been downloaded, you can move it to the cloned github directory and unzip. You can do that by running: 
```
mv ./SUB_359.zip /path/to/github/repo/
unzip /path/to/github/repo/SUB_359.zip 

```

Once unzipped, you should be able to list specific subject folders and NIfTI files





## FOLDER CONTENTS

- Sub_359: This folder contains the fMRI raw files and derivatives for each subject used in the analysis. 

- CSVs: Output CSVs and auxilliary CSV files

- GCMs: output group DCMs 

- pheno: This folder contains the csv and mat files with phenotypical and clinical information about the ABIDE participants used in the analysis 

- JOBS: Scripts to replicate the analysis presented in the manuscript step-by-step. A guide to run the scripts can be found in the folder description


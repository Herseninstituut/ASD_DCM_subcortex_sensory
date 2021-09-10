# ASD_DCM_subcortex_sensory

Companion code and data to: Lorenzini L., van Wingen G., Cerliani L., "Atypically high influence of subcortical activity on primary sensory regions in Autism".

_A link to the open access manuscript will be placed here as soon as it is available online_

This repository provides the code to reproduce the analyses of differences in functional effective connectivity described in the manuscript.

**To reproduce the analyses in the paper, clone the repo and add the data as described below and then follow the instructions in the `JOBS` directory**

[MATLAB](https://mathworks.com) and [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) must be installed. The code has been run on Linux and Windows. We safely assume it should also run on a Mac.


## Folder Contents

- **CSVs**: Output CSVs and auxilliary CSV files

- **GCMs**: output group DCMs

- **pheno**: This folder contains the csv and mat files with phenotypical and clinical information about the ABIDE participants used in the analysis

- **JOBS**: Scripts to replicate the analysis presented in the manuscript step-by-step. A guide to run the scripts can be found in the folder description.

**NB:** files with `.mat` extension are Matlab binary files.



## Cloning the repo and adding the data from Zenodo

The repository can be downloaded by running the following code on your on machine

```
git clone https://github.com/luislorenzini/ASD_DCM_subcortex_sensory.git
```
Alternatively, you can download a zip file containing the whole repo and then unzip it in a location on your machine.

The preprocessed fMRI data must be downloaded separately to be able to reproduce the analysis.
To download the fMRI NIfTI files go to [this Zenodo repository](https://zenodo.org/record/5463495#.YTdw2J0zZPY) and click on the Download button.
Once the zip folder has been downloaded, you can move it to the cloned github directory and unzip. You can do that by running (in Linux/Mac):

```bash
# [DATA_PATH] is the directory where the Zenodo repo was downloaded
# [GITHUB_PATH] is the location where the github repo was
# downloaded (and if necessary unzipped)

mv [DATA_PATH]/SUB_359.zip [GITHUB_PATH]
unzip [GITHUB_PATH]/SUB_359.zip

```

Once unzipped, the directory tree should look as follows:

```
[GITHUB_PATH]
└──SUB_359/
    └── 50004
    	└── 50004_RS_bptf_clean.nii.gz
    └── 50005
    	└── 50005_RS_bptf_clean.nii.gz
    └── 50008
    	└── 50004_RS_bptf_clean.nii.gz
    └── 50009
    	└── 50005_RS_bptf_clean.nii.gz
...
[and so on for another 355 participants]
[plus the other folders in this repo]
```

This folder contains the preprocessed 4D fMRI data in MNI 4x4x4mm space. This dataset is a subsample from the original [Autism Brain Imaging Data Exchange - ABIDE](http://fcon_1000.projects.nitrc.org/indi/abide/abide_I.html) dataset.

The participants selection procedure and the preprocessing steps are detailed in the main text and (especially) in the supplementary materials of the manuscript, and correspond to the data prepared and used in the previous paper:

[Cerliani, L., Mennes, M., Thomas, R. M., Di Martino, A., Thioux, M., & Keysers, C. (2015). Increased Functional Connectivity Between Subcortical and Cortical Resting-State Networks in Autism Spectrum Disorder. JAMA Psychiatry.](https://jamanetwork.com/journals/jamapsychiatry/fullarticle/2301161)

___

DISCLAIMER: The software is provided 'AS IS'. The public distribution of this script is UNIQUELY intended to provide an accurate documentation of the analyses performed in the published manuscript. The author declines any responsibility regarding machine malfunctioning or data loss due to the use of this script in the version provided here or in any modification of it.

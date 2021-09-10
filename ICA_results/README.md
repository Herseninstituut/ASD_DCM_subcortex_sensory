
The file `melodic_IC52_JAMA2015_bin.nii` is used by the Matlab scripts
to extract the eigenvariate time course from following meta-ICA components:

- 17 	: BG/Th
- 5	: dSI
- 29	: vSI
-  8	: V1
- 16	: A1

If you wish to visualize this file using fslview/fsleyes, please bear in mind
that the volume numbering in these softwares starts from zero, therefore
e.g. component 17 is displayed with volume number 16.

The file `MNI152_T1_2mm_brain.nii.gz` is the one present in the
[FSL distribution](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki).

The file `MNI152_T1_4mm_brain.nii.gz` is the same file as above, after identy transformation into the space of `melodic_IC52_JAMA2015_bin.nii`. It can be used to view the overlay on viewers which do not support images in different resolution (unlike e.g. fsleyes)

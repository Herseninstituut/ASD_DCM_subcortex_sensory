
% Change the following lines to math your own repositories
addpath('/PATH/TO/SPM') % ADD the path to your SPM repository
basedir = '/path/to/your/repository/' % Change this line with the pat to the downloaded github repository

%%% SETTINGS %%%
rootDir = fullfile(basedir,'Sub_359/');
spmDir = '/RESULTS/';


% Create the subjects list
D = dir(rootDir);
isub = [D(:).isdir]; %# returns logical vector
subjects = {D(isub).name}';
subjects(ismember(subjects,{'.','..'})) = [];
subjects = str2double(subjects);
subjects(isnan(subjects)) = [];


for i = 1:length(subjects)
for subject = subjects(i,1)
    
    
    subjDir = [rootDir num2str(subject)];
    spmmat = {[subjDir spmDir 'SPM.mat']};
    outputDir = [subjDir spmDir];
    
    %%Create Basal Ganglia ROI from HO_subcortical
    jobs{1}.util{1}.voi.spmmat = spmmat;
    jobs{1}.util{1}.voi.adjust = 0;    
    jobs{1}.util{1}.voi.session = 1;
    jobs{1}.util{1}.voi.name = 'basal_ganglia';
    jobs{1}.util{1}.voi.roi{1}.mask.image = {'/data_local/deeplearning/ABIDE_LC/analyses/DCM/atlases/HO_BG_4mm.nii,1'};
    jobs{1}.util{1}.voi.roi{1}.mask.threshold = 0;
    jobs{1}.util{1}.voi.expression = 'i1';
    
    %%Create S1 ROI from melodic_ICA n. 29
    jobs{2}.util{1}.voi.spmmat = spmmat;
    jobs{2}.util{1}.voi.adjust = 0;
    jobs{2}.util{1}.voi.session = 1;
    jobs{2}.util{1}.voi.name = 'vS1M1';
    jobs{2}.util{1}.voi.roi{1}.mask.image = {'/data_local/deeplearning/ABIDE_LC/analyses/DCM/atlases/melodic_IC52_JAMA2015_bin.nii,29'};
    jobs{2}.util{1}.voi.roi{1}.mask.threshold = 0;
    jobs{2}.util{1}.voi.expression = 'i1';


    %%Create M1 ROI from melodic_ICA n. 5
    jobs{3}.util{1}.voi.spmmat = spmmat;
    jobs{3}.util{1}.voi.adjust = 0;
    jobs{3}.util{1}.voi.session = 1;
    jobs{3}.util{1}.voi.name = 'dS1M1';
    jobs{3}.util{1}.voi.roi{1}.mask.image = {'/data_local/deeplearning/ABIDE_LC/analyses/DCM/atlases/melodic_IC52_JAMA2015_bin.nii,5'};
    jobs{3}.util{1}.voi.roi{1}.mask.threshold = 0;
    jobs{3}.util{1}.voi.expression = 'i1';
    
    %%Create V1 ROI from melodic_ICA n. 8
    jobs{4}.util{1}.voi.spmmat = spmmat;
    jobs{4}.util{1}.voi.adjust = 0;
    jobs{4}.util{1}.voi.session = 1;
    jobs{4}.util{1}.voi.name = 'V1';
    jobs{4}.util{1}.voi.roi{1}.mask.image = {'/data_local/deeplearning/ABIDE_LC/analyses/DCM/atlases/melodic_IC52_JAMA2015_bin.nii,8'};
    jobs{4}.util{1}.voi.roi{1}.mask.threshold = 0;
    jobs{4}.util{1}.voi.expression = 'i1';
    
    %%Create U1 ROI from melodic_ICA n.16
    jobs{5}.util{1}.voi.spmmat = spmmat;
    jobs{5}.util{1}.voi.adjust = 0;
    jobs{5}.util{1}.voi.session = 1;
    jobs{5}.util{1}.voi.name = 'U1';
    jobs{5}.util{1}.voi.roi{1}.mask.image = {'/data_local/deeplearning/ABIDE_LC/analyses/DCM/atlases/melodic_IC52_JAMA2015_bin.nii,16'};
    jobs{5}.util{1}.voi.roi{1}.mask.threshold = 0;
    jobs{5}.util{1}.voi.expression = 'i1';

    %%Create Thalamus ROI from HO_subcortical
    jobs{6}.util{1}.voi.spmmat = spmmat;
    jobs{6}.util{1}.voi.adjust = 0;    
    jobs{6}.util{1}.voi.session = 1;
    jobs{6}.util{1}.voi.name = 'Thalamus';
    jobs{6}.util{1}.voi.roi{1}.mask.image = {'/data_local/deeplearning/ABIDE_LC/analyses/DCM/atlases/HO_th_4mm.nii,1'};
    jobs{6}.util{1}.voi.roi{1}.mask.threshold = 0;
    jobs{6}.util{1}.voi.expression = 'i1';
    
    
    cd(outputDir)
    spm_jobman('run', jobs)
    
    
    
    
    
end 
end



%%%SUBCORTICAL
for i = 1:length(subjects)
for subject = subjects(i,1)
    
     subjDir = [rootDir num2str(subject)];
    spmmat = {[subjDir spmDir 'SPM.mat']};
    outputDir = [subjDir spmDir];
    
    %%Create Basal Ganglia ROI from HO_subcortical
    jobs{1}.util{1}.voi.spmmat = spmmat;
    jobs{1}.util{1}.voi.adjust = 0;    
    jobs{1}.util{1}.voi.session = 1;
    jobs{1}.util{1}.voi.name = 'SUBCORTICAL';
    jobs{1}.util{1}.voi.roi{1}.mask.image = {'/data_local/deeplearning/ABIDE_LC/analyses/DCM/atlases/melodic_IC52_JAMA2015_bin.nii,17'};
    jobs{1}.util{1}.voi.roi{1}.mask.threshold = 0;
    jobs{1}.util{1}.voi.expression = 'i1';
    
    
    cd(outputDir)
    spm_jobman('run', jobs)
end 
end

clear all;
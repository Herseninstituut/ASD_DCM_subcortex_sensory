


%%% Set directories for data and phenofiles
DCMdir = '/data_local/deeplearning/ABIDE_LC/analyses/DCM/';
basedir = fullfile(DCMdir, 'DCM_359');
subjdir =  fullfile(basedir,'Sub_359');
phenoDir = fullfile(DCMdir, 'pheno');
phenofile = fullfile(phenoDir, 'pheno_359.mat');
load(phenofile)
groupdir = fullfile(basedir,'GCMs');

% Pick the directory (analysis) you want to create the DM for
%interactionfold = fullfile(basedir, 'Interaction_5reg_group_analysis')
interactionfold = fullfile(basedir, 'Interaction_16reg_group_analysis');

%decide the number of covarites
nvariables = 16;  %5

%%% get group and SRS index and extract the two columns of interest
[~,group_idx] = ismember('DX_GROUP',phenolabels);
[~,SRS_idx] = ismember('SRS_RAW_TOTAL',phenolabels);
[~,AGE_idx] = ismember('AGE_AT_SCAN',phenolabels);
%[~,SEX_idx] = ismember('SEX',phenolabels);  There are just males
[~,FD_idx] = ismember('FD_mean',phenolabels);  
[~,EYE_idx] = ismember('EYE_STATUS_AT_SCAN',phenolabels);  
[~,SITE_idx] = ismember('SITE_ID',phenolabels);  



Group = phenomat(:,group_idx);
SRS_scores = phenomat(:,SRS_idx);
AGE = phenomat(:,AGE_idx);
FD = phenomat(:,FD_idx);
EYE = phenomat(:,EYE_idx);
Site = phenomat(:,SITE_idx);


%call getsubjectlist function and check that the order is the same in the
%GCM
[subjlist, nsub] = getsubjectlist(subjdir);
CheckSubjectOrder(groupdir,subjlist)

%Get SRS scores and replace NaN with median from each group 
%SRS_scores = adjustSRSscores(Group,SRS_scores,group_idx,phenomat)



%% INTERACTION DESIGN MATRIX  (5 REGRESSORS)
DM = zeros(nsub,nvariables);
DM(:,1) = 1;

for i=1:length(subjlist)
    for subject = subjlist(i,1)
        [~, index] = ismember(subject,phenomat(:,2));
        DM(i,2) = Group(index);
        DM(i,3) = AGE(index);
        DM(i,5) = FD(index);
    end 
end

for i=1:length(DM)
    if DM(i,2)== 2
        DM(i,2) = 0; 
    end 
end

subj = dir(subjdir);
    isub = [subj(:).isdir];
    subj = {subj(isub).name};
    subj = str2double(subj);
    subj(isnan(subj)) = [];
    subjlist = subj';
    nsub = length(subjlist);


DM(:,2:end) = normalize(DM(:,2:end));
DM(:,4) = DM(:,2).*DM(:,3);

Labels = {'Mean', 'Group', 'AGE', 'group*age' ,'FD'};

%%% Save Design Matrix
filename = [interactionfold '/Interaction_Design_Matrix.mat'];
save(filename,'DM', 'Labels')






%% INTERACTION DESIGN MATRIX  (16 REGRESSORS)

DM = zeros(nsub,nvariables);
DM(:,1) = 1;

for i=1:length(subjlist)
    for subject = subjlist(i,1)
        [~, index] = ismember(subject,phenomat(:,2));
        DM(i,2) = Group(index);
        DM(i,3) = AGE(index);
        DM(i,5) = FD(index);
        DM(i,6) = EYE(index);
        subsite = Site(index);
        DM(i,6+subsite) = 1;
    end 
end

for i=1:length(DM)
    if DM(i,2)== 2
        DM(i,2) = 0; 
    end 
end

DM(:,2:end) = normalize(DM(:,2:end));
DM(:,4) = DM(:,2).*DM(:,3);

% This is temporary, it deletes columns of Site where no subject are. 
DM(:,11) = []
DM(:,13) = []

% Delete the mean ...
DM(:,1) = []


Labels = { 'Group', 'AGE', 'group*age' ,'FD'};

for i = 1:8
    ind = 4 +i;
   Labels{ind} = ['Site' num2str(i)];
    
end

%%% Save Design Matrix
filename = [interactionfold '/Interaction_16reg_Design_Matrix.mat'];
save(filename,'DM', 'Labels')






%% Functions

function CheckSubjectOrder(groupdir,subjlist)
GCMfile = fullfile (groupdir, 'GCM_pre_estimated')
load(GCMfile)

for i=  1:length(subjlist)
   subject = subjlist(i,1); 
   if ~contains(GCM{i,1},string(subject))
       error('Error In Subject Order!!!!')       
   end
end
end







%get list of subjects
function [subjlist, nsub] = getsubjectlist(subjdir)
    subj = dir(subjdir);
    isub = [subj(:).isdir];
    subj = {subj(isub).name};
    subj = str2double(subj);
    subj(isnan(subj)) = [];
    subjlist = subj';
    nsub = length(subjlist);
end
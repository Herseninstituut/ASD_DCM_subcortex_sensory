%%% Extract parameter estimates for each subject and the between subject
%%% regressor to perform the PLS 

%% Settings

DCMdir = 'C:\Users\luigi\Home\Work\EC\ABIDE_EC\DCM_359_van.tar\';
basedir = fullfile(DCMdir, 'DCM_359');
subjdir =  fullfile(basedir,'Sub_359');
phenoDir = fullfile(basedir, 'pheno');
phenofile = fullfile(phenoDir, 'pheno_359.mat');
load(phenofile)
groupdir = fullfile(basedir,'GCMs');

outputdir = fullfile(basedir, 'CSVs');

%% Extract parameter strength from GCM estimated (Estimated Posterior)

GCM_est = fullfile (groupdir, 'GCM_estimated.mat');
load (GCM_est)

%create an empty table (nsubXnconnections) with headers indicating the names of the connections
Headers = {'BGtoBG' 'BGtoVM1S1' 'BGtoDM1S1' 'BGtoV1' 'BGtoU1' 'VM1S1toBG' 'VM1S1toVM1S1' 'DM1S1toBG' 'DM1S1toDM1S1' 'V1toBG' 'V1toV1' 'U1toBG' 'U1toU1'};
EPs = cell(359, 13);
EPs = cell2table(EPs);
EPs.Properties.VariableNames = Headers;

%rEPs, other values after the PEB
rEPs = cell(359, 13);
rEPs = cell2table(rEPs);
rEPs.Properties.VariableNames = Headers;


%extract EPs from GCM & RCM
for i = 1:length(GCM);
   % GCM to extract EPS
   subj_eps = nonzeros(GCM{i}.Ep.A)';
   subj_eps = num2cell(subj_eps);
   EPs{i,1:13} = subj_eps;
   
   % RCM to extract rEPS
   subj_reps = nonzeros(RCM_A{i}.Ep.A)';
   subj_reps = num2cell(subj_reps);
   rEPs{i,1:13} = subj_reps;
   
end

% save
epfilename = fullfile(outputdir, 'EPs.csv');
writetable (EPs, epfilename)

repfilename = fullfile(outputdir, 'rEPs.csv');
writetable (rEPs, repfilename)

%% Extract interesting regressors (Age, Group)

% extract list of subject
subj = dir(subjdir);
isub = [subj(:).isdir];
subj = {subj(isub).name};
subj = str2double(subj);
subj(isnan(subj)) = [];
subjlist = subj';
nsub = length(subjlist);

% regressors of interest from phenofile 
[~,AGE_idx] = ismember('AGE_AT_SCAN',phenolabels);  %indices of columns of interest
[~,group_idx] = ismember('DX_GROUP',phenolabels);
[~,ID_idx] = ismember('SUB_ID', phenolabels);
[~,FD_idx] = ismember('FD_mean', phenolabels);
[~,Site_idx] = ismember('SITE_ID', phenolabels);

AGE = phenomat(:,AGE_idx);
Group = phenomat(:,group_idx);
IDs = phenomat(:,ID_idx);
FD = phenomat(:,FD_idx);
Site = phenomat(:,Site_idx);

% load GCM pre estimated to check for subject order 
GCM_pre_estimated = fullfile(groupdir, 'GCM_pre_estimated.mat');
load (GCM_pre_estimated)


for i = 1:nsub
   subject  = subjlist(i);
   if contains (GCM{i}, string(subject))
       [~,index] = ismember(subject,IDs);
       
       regressors (i,1) = IDs(index);
       regressors(i,2) = AGE(index);
       regressors(i,3) = Group(index);
       regressors(i,4) = FD(index);
       regressors(i,5) = Site(index);
   else 
       error('There is an error in the order of the subjects')
   end
end

Headers = {'ID' 'Age' 'Group' 'FD' 'Site'} 
T = table(regressors(:,1),regressors(:,2),regressors(:,3), regressors(:,4), regressors(:,5));
T.Properties.VariableNames = Headers


regfilename = fullfile(outputdir, 'Regressors_359.csv');
writetable(T, regfilename)

%% Merge with EPs and rEPS
EPtable = [T EPs];
rEPtable = [T rEPs];

writetable(EPtable, fullfile(outputdir, 'EPtable.csv'));
writetable(rEPtable, fullfile(outputdir, 'rEPtable.csv'));


%% Extract Explained variance

EV = zeros(length(GCM), 1);
for i = 1:length(GCM)
    DCM = GCM{i};
    PSS   = sum(sum(sum(abs(DCM.Hc).^2)));
    RSS   = sum(sum(sum(abs(DCM.Rc).^2)));
    
    EV(i,1) = 100*PSS/(PSS + RSS);
end

TEV = table(EV);
TEV.Properties.VariableNames = "EV";


EPtable = [EPtable  TEV];
rEPtable = [rEPtable  TEV];

writetable(EPtable, fullfile(outputdir, 'EPtable.csv'));
writetable(rEPtable, fullfile(outputdir, 'rEPtable.csv'));

%% Extract Posterior Probability (PP)

GCM_est = fullfile (groupdir, 'GCM_estimated.mat');
load (GCM_est)

%create an empty table (nsubXnconnections) with headers indicating the names of the connections
Headers = {'BGtoBG_PP' 'BGtoVM1S1_PP' 'BGtoDM1S1_PP' 'BGtoV1_PP' 'BGtoU1_PP' 'VM1S1toBG_PP' 'VM1S1toVM1S1_PP' 'DM1S1toBG_PP' 'DM1S1toDM1S1_PP' 'V1toBG_PP' 'V1toV1_PP' 'U1toBG_PP' 'U1toU1_PP'};
PPs = cell(359, 13);
PPs = cell2table(PPs);
PPs.Properties.VariableNames = Headers;



%extract PPs from GCM 
for i = 1:length(GCM);
   % GCM to extract EPS
   subj_eps = GCM{i}.Pp.A(~isnan(GCM{i}.Pp.A))';
   subj_eps = num2cell(subj_eps);
   PPs{i,1:13} = subj_eps;
end

% save
ppfilename = fullfile(outputdir, 'PPs.csv');
writetable (PPs, ppfilename)



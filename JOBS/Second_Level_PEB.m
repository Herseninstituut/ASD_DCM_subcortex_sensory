%%% SETTINGS AND LOADINGS %%%
basedir = '/data_local/deeplearning/ABIDE_LC/analyses/DCM/DCM_219';
subjdir = fullfile(basedir, 'Sub_219');
groupdir = fullfile(basedir,'GCMs') ;
GCMfile = fullfile(groupdir, 'GCM_estimated');
DesMat = fullfile(basedir, '/Interaction_Results', 'Interaction_Design_Matrix.mat');
templates60 = fullfile(groupdir,'GCM_templates_60models.mat');



% Load design matrix
DM = load(DesMat);
X        = DM.DM;
X_labels = DM.Labels;


% Load GCM
GCM=load(GCMfile);
GCM=GCM.GCM;


% PEB settings
M = struct();
M.Q      = 'all';
M.X      = X;
M.Xnames = X_labels;
M.maxit  = 256;   


%%% BUILD PEB on A Parameters (intrinsic connectivity)
[PEB_A,RCM_A] = spm_dcm_peb(GCM,M,{'A'});

PEBfilename = fullfile(basedir, 'Interaction_Results/PEB_219.mat')
save(PEBfilename,'PEB_A','RCM_A','-v7.3');

%%% 60 MODELS
templates60 = load(templates60)

% Run model comparison
[BMA,BMR] = spm_dcm_peb_bmc(PEB_A, templates60.GCM_templates);

BMAfilename = fullfile(basedir,'Interaction_results','BMA_219_60templates.mat');
save(BMAfilename, 'BMA', 'BMR')


%%%% Reorder the Design Matrix to study other main effects

% %Always start from the original DM 
% 
% % Effect of AGE 
% X = X(:,[1 3 2 4 5]);
% X_labels = X_labels(:,[1 3 2 4 5]);
% 
% 
% % Effect of Interaction
% X = X(:,[1 4 2 3 5]);
% X_labels = X_labels(:,[1 4 2 3 5]);


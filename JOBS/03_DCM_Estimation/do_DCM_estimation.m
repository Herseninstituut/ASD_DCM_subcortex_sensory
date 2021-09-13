

% Change the following lines to math your own repositories
addpath('/PATH/TO/SPM') % ADD the path to your SPM repository
basedir = '/path/to/your/repository/' % Change this line with the pat to the downloaded github repository


%%% SETTINGS %%%%
subjdir = fullfile(basedir, 'Sub_359');
jobdir = fullfile(basedir, 'JOBS');
addpath(jobdir)
spmfold = 'RESULTS';
groupdir = fullfile(basedir,'GCMs') ;

% Experimental Settings
[subjlist, nsub] = getsubjectlist(subjdir);
nregions = 5;
nconditions = 0;


%%%% SPECIFICATION %%%%

% Iteratively Specify the full-model for each subject and create GCM file
for i=1:length(subjlist)
    subject = subjlist(i,1);
    spmpath = fullfile(subjdir,string(subject), spmfold);
    spmfile = fullfile(spmpath, 'SPM.mat');
    SPM = load (spmfile);
    [TR,TE] = getTR(SPM);
    createFullModel(nregions,TR,TE,SPM,spmpath);
    GCM{i,1} = (fullfile(spmpath,'DCM_full.mat'));
    
end

% Save the GCM with the filepaths of each DCM (pre_estimated) in the Group
% Directory
GCMfile = fullfile(groupdir, 'GCM_pre_estimated.mat');
save(GCMfile, 'GCM');


%%%% ESTIMATION %%%%

% Load the GCM
% load(GCMfile)
GCM = spm_dcm_load(GCMfile)

% Estimate DCMs (this won't effect original DCM files)
%Useparfor
use_parfor = true
GCM = spm_dcm_fit(GCM, use_parfor);

% Save the Estimated GCM
GCMestfile = fullfile(groupdir,'GCM_estimated.mat');
save(GCMestfile,'GCM','-v7.3');


%%% DIAGNOSTIC %%%
spm_dcm_fmri_check(GCM);













%%%FULLMODEL%%%
function createFullModel(nregions,TR,TE,SPM,spmpath)
    TH =1; S1 =2; M1 =3; V1 =4; U1 = 5;

    % A- matrix (on / off)
    a = eye ( nregions , nregions );
    a(TH,:) = 1;
    a(:,TH) = 1;

    % B- matrix
    b = zeros (5,5,0);
    % C- matrix
    c = zeros (nregions,1 );
    % Load SPM
    SPM = SPM.SPM;
    % D- matrix ( disabled but must be specified )
    d = zeros ( nregions , nregions ,0);

    % Load ROIs
    f = { (fullfile ( spmpath,'VOI_SUBCORTICAL_1.mat'));
    (fullfile ( spmpath, 'VOI_vS1M1_1.mat '));
    (fullfile ( spmpath,'VOI_dS1M1_1.mat '));
    (fullfile ( spmpath,'VOI_V1_1.mat '));
    (fullfile ( spmpath,'VOI_U1_1.mat '))};

    for r = 1: length (f)
    XY = load (f{r});
    xY(r) = XY.xY;
    end


    % Specify the DCM's components
    s = struct ();
    s. name = 'full';
    s. delays = repmat ((TR/2) ,1, nregions );
    s.TE = TE;
    s. nonlinear = false ;
    s. two_state = false ;
    s. stochastic = false ;
    s. centre = true ;
    s. induced = 1;
    s.a = a;
    s.b = b;
    s.c = c;
    s.d = d;
    
    
    %Save it (specify)
    savemodel(SPM, xY, s, spmpath)
end





%Save the model by specifying it in the subject's result folder
function savemodel(SPM, xY, s, spmpath)
    cd( spmpath );
    spm_dcm_specify(SPM ,xY ,s);

end



% Get the TR from the SPM.mat and set the TE
function [TR,TE] = getTR(SPM)
    TR = SPM.SPM.xY.RT;
    TE = 0.04;
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
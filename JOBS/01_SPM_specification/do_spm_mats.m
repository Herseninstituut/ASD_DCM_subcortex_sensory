
% Change the following lines to math your own repositories
addpath('/PATH/TO/SPM') % ADD the path to your SPM repository
basedir = '/path/to/your/repository/' % Change this line with the pat to the downloaded github repository

%%%----SETTINGS----%%%
rootDir = fullfile(basedir,'Sub_359/');
spmDir = '/RESULTS/';
phenofold = fullfile(basedir,'pheno')
phenofile = fullfile (phenofold, 'pheno_359.mat')


% Define the list of subjects, taken in the rootDir
D = dir(rootDir);
isub = [D(:).isdir]; %# returns logical vector
subjects = {D(isub).name}';
subjects(ismember(subjects,{'.','..'})) = [];
subjects = str2double(subjects);
subjects(isnan(subjects)) = [];

numScans = 175; %This if the number of scans that you acquire per run

% Define TR 
load (phenofile)

% If you want to estimate the GLM '1' else '0'
ESTIMATE_GLM = 1;


%%%-----------------------------------------------------%%%



%For each subject, create timing files and jobs structure
for i = 1:length(subjects)
for subject = subjects(i,1)
    
    %Get TR from phenomat
    [tf, index]=ismember(subject,phenomat(:,2),'rows');
    TR = phenomat(index,17); %Repetition time, in seconds


    funcs = [num2str(subject) '_RS_bptf_clean.nii'];
    %See whether output directory exists; if it doesn't, create it
    outputDir = [rootDir num2str(subject) spmDir];
    
    if ~exist(outputDir)
        mkdir(outputDir)
    end
     
   
    runs = 1;

    %Begin creating jobs structure
    jobs{1}.stats{1}.fmri_spec.dir = cellstr(outputDir);
    jobs{1}.stats{1}.fmri_spec.timing.units = 'secs';
    jobs{1}.stats{1}.fmri_spec.timing.RT = TR;
    jobs{1}.stats{1}.fmri_spec.timing.fmri_t = 16;
    jobs{1}.stats{1}.fmri_spec.timing.fmri_t0 = 8;

    %Grab frames for each run using spm_select, and fill in session
    %information within jobs structure
    files = spm_select('ExtFPList', [rootDir num2str(subject)], ['^' funcs], 1:numScans);

    jobs{1}.stats{1}.fmri_spec.sess.scans = cellstr(files);

    jobs{1}.stats{1}.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    jobs{1}.stats{1}.fmri_spec.sess.multi = {''};
    jobs{1}.stats{1}.fmri_spec.sess.regress = struct('name', {}, 'val', {});
    jobs{1}.stats{1}.fmri_spec.sess.multi_reg = {''};
    jobs{1}.stats{1}.fmri_spec.sess.hpf = 128;
    jobs{1}.stats{1}.fmri_spec.fact = struct('name', {}, 'levels', {});
    jobs{1}.stats{1}.fmri_spec.bases.hrf.derivs = [0 0];
    jobs{1}.stats{1}.fmri_spec.volt = 1;
    jobs{1}.stats{1}.fmri_spec.global = 'None';
    jobs{1}.stats{1}.fmri_spec.mthresh = -Inf;
    jobs{1}.stats{1}.fmri_spec.mask = {''};
    jobs{1}.stats{1}.fmri_spec.cvi = 'none';
   
    
     %Navigate to output directory, specify and estimate GLM
    cd(outputDir);
    spm_jobman('run', jobs)
    %load SPM.mat
    %SPM.xM.TH = -Inf(size(SPM.xM.TH)); 
    %save SPM.mat SPM
    
    if ESTIMATE_GLM == 1
        load SPM;
        spm_spm(SPM);
    end
   
end
end


clear all;


   
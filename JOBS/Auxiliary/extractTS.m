% General Settings
basedir = 'C:\Users\luigi\Home\Work\EC\ABIDE_EC\DCM_359_van.tar\DCM_359\';
subjdir = fullfile(basedir, 'Sub_359/');
jobdir = fullfile(basedir, 'JOBS');
spmfold = 'RESULTS';
outputdir = fullfile(basedir, 'CSVs/timeseries');


% Experimental Settings
[subjlist, nsub] = getsubjectlist(subjdir);
nregions = 5;
nconditions = 0;

% initialize empty dataframes
sub_ts = zeros(nsub, 176); 
vone_ts = zeros(nsub, 176); 
aone_ts = zeros(nsub, 176); 
ventral_ts = zeros(nsub, 176); 
dorsal_ts = zeros(nsub, 176); 



for iSub=1:length(subjlist) 
    subj = subjlist(iSub);
    spmdir=fullfile(subjdir, string(subj), spmfold); 
    
    % Subcortical timeseries
    subcort = load(fullfile(spmdir, 'VOI_SUBCORTICAL_1.mat')); 
    sub_ts(iSub, :) = [subj subcort.Y'];
    
    %V1 timeseries
    vone = load(fullfile(spmdir, 'VOI_V1_1.mat')); 
    vone_ts(iSub, :) = [subj vone.Y'];
    
    %A1 timeseries
    aone = load(fullfile(spmdir, 'VOI_U1_1.mat'));
    aone_ts(iSub, :) = [subj aone.Y'];
    
    %vS1 timeseries
    ventralone = load(fullfile(spmdir, 'VOI_vS1M1_1.mat'));
    ventral_ts(iSub, :) = [subj ventralone.Y'];
    
    %vS1 timeseries
    dorsalone = load(fullfile(spmdir, 'VOI_dS1M1_1.mat'));
    dorsal_ts(iSub, :) = [subj dorsalone.Y'];

end


csvwrite(fullfile(outputdir, 'subcortical_ts.csv') , sub_ts)
csvwrite(fullfile(outputdir, 'v1_ts.csv') , vone_ts)
csvwrite(fullfile(outputdir, 'a1_ts.csv') , aone_ts)
csvwrite(fullfile(outputdir, 'vS1_ts.csv') , ventral_ts)
csvwrite(fullfile(outputdir, 'dS1.csv') , dorsal_ts)


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
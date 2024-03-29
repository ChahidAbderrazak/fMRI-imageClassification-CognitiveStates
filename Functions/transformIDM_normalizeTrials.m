% transformIDM_normalizeTrials(info,data,meta) 
%
% transformIDM_normalizeTrials(info,data,meta) 
% Returns a copy of info,data,meta in which each trial is normalized.
% Normalization is done separtely for each trial, and for each voxel within
% each trial.  Normalization consists for each voxel of calculating its mean
% activity over the trial, then subtracting its mean from its activity at
% each time point within the trial.  The net effect is to reset the mean to
% zero, while preserving the signal variation of the voxel over time.
% May be useful for comparing trials, by removing the effect of long-term
% drift in signal magnitude.
%
% Example: 
% [info2,data2,meta2] = transformIDM_normalizeTrials(info,data,meta) 
%
% History
% - 9/1/02 TMM Created file.

function [rinfo,norm_data,rmeta] = transformIDM_normalizeTrials(info,data,meta)
  
  
norm_data = cell(meta.ntrials,1);

 for i=1:size(data,1)
%      norm_data{i}= zeros(size(data{1,1},1),size(data{1,1},2) );
    for j=1:size(data{i,1},1)
        norm_data{i}(j,:) = (data{i,:}(j,:) - min(data{i,:}(j,:))) / ( max(data{i,:}(j,:)) - min(data{i,:}(j,:)) );
    end
 end
 
%  norm_data = cell(meta.ntrials,1);

%   for j=1:1:length(info)
%     rdata{j}=normalizeTrial(data{j});
%   end;

  rinfo=info;
  rmeta=meta;
  

  

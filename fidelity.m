function [pos_all,length_all] = fidelity(dat,filter)

% Takes raw sequencing read data and obtains mismatch, insertion, deletion,
% and overall error-rate of polymerases. Individual error rates are the
% arithmetic mean of each relevant criteria (position or sequence length),
% and error rate is the summation of mismatch, insertion, and deletion
% rates. Data was normalized as the fraction of sequencing reads with 
% errors per total sequencing reads.

dat1={};
for i = 1:length(filter)
    temp = dat(dat.Length == filter(i),:);
    dat1 = vertcat(dat1,temp);
end
lengths = unique(dat1.Length);
pos = unique(dat1.Position);


dat2 = dat1(:,{'Length', 'Position', 'Total', 'Matches', 'Deletions', ...
    'Insertions'});

dat2.Mismatches = dat2.Total - dat2.Matches -dat2.Insertions - dat2.Deletions;
dat3 = dat2;
dat3.Mismatches = dat2.Mismatches./dat2.Total;
dat3.Deletions = dat2.Deletions./dat2.Total;
dat3.Insertions = dat2.Insertions./dat2.Total;
dat3.ErrorRate = dat3.Insertions + dat3.Deletions + dat3.Mismatches;

% Get data for position-based errors

posdat = zeros(length(pos),5);
for  i = 1:length(pos)
    g = pos(i);
    subset = dat3(dat3.Position == g,:);
    posmean = mean(subset{:,5:8},1);
    posdat(i,:) = [pos(i) posmean];
end
pos_all = array2table(posdat,'VariableNames',{'Position', 'Deletions', ...
    'Insertions','Mismatches','ErrorRate'});

% Get data for length-based errors

lendat = zeros(length(lengths),5);
for  i = 1:length(lengths)
    len = lengths(i);
    subset = dat3(dat3.Length == len,:);
    lenmean = mean(subset{:,5:8},1);
    lendat(i,:) = [lengths(i) lenmean];
end
length_all = array2table(lendat,'VariableNames',{'Length', 'Deletions', ...
    'Insertions','Mismatches','ErrorRate'});
end
function [f,lengths] = processivity(dat)

% Takes raw sequencing read data and obtains read lengths and expected
% sequences. Sequencing read counts are normalized to the total number of
% reads obtained in each sequencing run.

lengths = unique(dat.Length);

% Get read lengths and read sequences
proc = zeros(length(lengths),1);
seqs = {};

for  i = 1:length(lengths)
    len = lengths(i);
    subset = dat(dat.Length == len,:);
    proc(i) = subset{1,"Total"};
    seqs(i) = {cell2mat(subset.Expected')};
end

proc = proc/sum(proc);
f = table(proc,seqs','VariableNames',{'Length','Sequence'});
end

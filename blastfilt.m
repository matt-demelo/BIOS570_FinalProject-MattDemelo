function f = blastfilt(bdat)
% Takes blast output data from getblast() and filters for hits with lengths
% greater than 500 (non-synthetic), saving the accession ID and definition
% of the subject and alignment length of the hit to a table. 

ht = size(bdat.Hits,2);
alen =[];
hsps ={};
def={};
j=1;

for i = 1:ht
    if bdat.Hits(i).Length > 500
        alen(j) =  bdat.Hits(i).Hsps.AlignmentLength;
        hsps(j) = {bdat.Hits(i).Accession};
        def(j) = {bdat.Hits(i).Definition};
        j =j+1;
    end
end

f = table(hsps',alen',def','VariableNames',{'AccessionID', ...
    'AlignmentLength','Definition'});
end
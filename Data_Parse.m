%% rnaseq data import
rnaseq= readtable('refseq.xlsx');
%% Data identifier creation
%geneid has 2 columns corresponding to gene name and refseq ID
geneid = table2cell(rnaseq(:,{'gene', 'refseq'}));
%%
cellid = rnaseq.Properties.VariableNames(3:end);

for c = ['W', 'D'] 
    for s = ['A', 'B', 'C', 'D']
        cs = strcat(c,s)
        match = strncmp(cs,cellid(1,:),2);
        for n = find(match == 1)
            cellid(2,n) = {cs} 
        end           
    end
end
%%
% rpkm (Reads Per Kilobase per Million) table has transcriptomic expression 
% data and variables are cellid containing identification of:
% 1. W/D: wildtype/deleted
% 2. A/B/C/D: stage of erythropoiesis based on relative presence of
% erythropoietic maturation marker Ter119 
% 3. n: replicate number
% 4. a/d: alive/dead
rpkm = table2array(rnaseq(:,3:end));
%%
clearvars -except rpkm geneid cellid
save('parsed_data')
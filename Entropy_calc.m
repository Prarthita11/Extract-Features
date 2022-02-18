function [features_ent] = Entropy_calc(channel,segsize,fs)

if ~exist('fs','var');fs = 250;end

channel = normalize(channel);

if ~exist('segsize','var');segsize = 2;end

%get the segments
getsegments(channel,segsize)
segments = ans.segments;
[seg_no,~]=size(segments);

entropy_norm=[]; entropy_app= [];   corDim=[];   lyapExp=[];

for i = 1:seg_no

    h1=histogram(segments(i,:),'Normalization', 'Probability');
    p= h1.Values;
    ent= -sum(p.*log2(p));

    ent_app= approximateEntropy(segments(i,:));

    entropy_norm = [entropy_norm;ent];
    entropy_app = [entropy_app;ent_app];
    corDim = [corDim;correlationDimension(segments(i,:))];
    lyapExp = [lyapExp;lyapunovExponent(segments(i,:),fs)];
end

features_ent.entropy_norm = entropy_norm;
features_ent.entropy_app = entropy_app;
features_ent.corDim = corDim;
features_ent.lyapExp =   lyapExp;

end
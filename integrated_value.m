function [features_I] = integrated_value(channel,segsize)

if ~exist('segsize','var');segsize = 2;end

channel = normalize(channel);

%get the segments
getsegments(channel,segsize)
segments = ans.segments;
[seg_no,~]=size(segments);

approx = [];
detail3 = [];
detail4 = [];
detail5 = [];

for i=1:seg_no

    [c,l] = wavedec(segments(i,:),5,'db2');

    ac = appcoef(c,l,'db2');
    approx = [approx;ac];

    [cd3,cd4,cd5] = detcoef(c,l,[3 4 5]);
    detail3 = [detail3;cd3];
    detail4 = [detail4;cd4];
    detail5 = [detail5;cd5];

end

for i= 1:seg_no
 I_Approx(i) = sum(abs(approx(i)),2);
 I_detail3(i) = sum(abs(detail3(i)),2);
 I_detail4(i) = sum(abs(detail4(i)),2);
 I_detail5(i) = sum(abs(detail5(i)),2);
end
features_I.approx = I_Approx
features_I.detail3 = I_detail3
features_I.detail4 = I_detail4
features_I.detail5 = I_detail5
end
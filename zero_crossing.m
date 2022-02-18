function [features_zc] = zero_crossing(channel,segsize)

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

s=size(approx);
zc_approx= [];

for j=1:s(1,1)
sum= 0;
 for i=1:length(approx)-1
    zc = sign(-approx(j,i)*approx(j,i+1));
    sum = sum + zc ;
 end
 zc_approx(j,:)= sum;
end

s=size(detail3);
zc_detail3= [];

for j=1:s(1,1)
sum= 0;
 for i=1:length(detail3)-1
    zc = sign(-detail3(j,i)*detail3(j,i+1));
    sum = sum + zc ;
 end
 zc_detail3(j,:)= sum;
end

s=size(detail4);
zc_detail4= [];

for j=1:s(1,1)
sum= 0;
 for i=1:length(detail4)-1
    zc = sign(-detail4(j,i)*detail4(j,i+1));
    sum = sum + zc ;
 end
 zc_detail4(j,:)= sum;
end

s=size(detail5);
zc_detail5= [];

for j=1:s(1,1)
sum= 0;
 for i=1:length(detail5)-1
    zc = sign(-detail5(j,i)*detail5(j,i+1));
    sum = sum + zc ;
 end
 zc_detail5(j,:)= sum;
end
features_zc.approx = zc_approx
features_zc.detail3 = zc_detail3
features_zc.detail4 = zc_detail4
features_zc.detail5 = zc_detail5

end


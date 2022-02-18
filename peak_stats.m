function [features_p] = peak_stats(channel,segsize,fs)

if ~exist('fs','var');fs = 250;end
if ~exist('segsize','var');segsize = 2;end

channel = normalize(channel)

%get the segments
getsegments(channel,segsize)
segments = ans.segments;
[seg_no,~]=size(segments);

%data = data;


pwr_avg = []; locsdiff=[];

for i = 1:seg_no

    [peak1,locs1,w1,p1] = findpeaks(segments(i,:),'MinPeakHeight',(2*std(segments(i,:))),...
        'MinPeakDistance',fs/2);

    % Also search the flipped signal for R-peaks:
    [peak2,locs2,w2,p2] = findpeaks(-segments(i,:),'MinPeakHeight',(2*std(-segments(i))),...
        'MinPeakDistance',fs/2);

    % Determine which way the peaks are highest, corresponding to R-peaks:
    if isempty(peak1)
        peak1 = 0;
        locs1= 0;
    end
    if isempty(peak2)
        peak2 = 0;
        locs2= 0;
    end

    if mean(peak2) > mean(peak1)
        locs1 = locs2;
        peak1 = peak2;
        w1 = w2;
        p1 = p2;
    end

    pwr = w1./p1;
    pwr_a = mean(pwr);


    pwr_avg= [pwr_avg;pwr_a];
    locsdiff = [locsdiff; mean(diff(locs1)./250)];

end

features_p.pwr = pwr_avg
features_p.locsdiff = locsdiff

end
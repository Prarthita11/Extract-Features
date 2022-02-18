function [segments] = getsegments (data,segsize,fs,fig)

% returns non-overlapping segments of a signal
%data= input data to be segmented
%segsize = desired length of the segments in second (default = 2s)
% fs = sampling frequency (default = 250)
%fig = 3 if segments to be visualized

%setting the defaults
if ~exist('segsize','var');segsize = 2;end
if ~exist('fs','var');fs = 250;end
if ~exist('fig','var');fig = 1;end

ns = length(data);
%creating segments
t1=1;
t2= fs*segsize;
k=1;
move = fs*segsize;
seg =[];
while t2<ns*fs
    new_seg = data(t1:min(t2,floor(ns/fs)*fs));
    %discarding the last segment if it doesnt have the same size
    if length(new_seg)==move 
    seg= [seg;new_seg];
    end
    t1 = t1 + move;
    t2 = t2 + move;
    k  = k + 1;
end

%Visualizing the segments
if fig==3
figure()
timevector = (1:1:ns)./250;
plot(timevector,data)
xlabel("Time(s)")
ylabel('Amplitude')
title("Original unsegmented data")
figure()
l=size(seg,1);
for i=1:l
    subplot(floor(l/2),2,i)
    timevector= (1:1:length(seg))./250;
    plot(timevector,seg(i,:))
    xlabel("Time(s)")
ylabel('Amplitude')
    title("segment",num2str(i))
end
sgtitle("2 second segments")
end

%saving the segments
segments.segments = seg;
end

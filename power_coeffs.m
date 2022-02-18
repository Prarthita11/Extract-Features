function [coefficients] = power_coeffs(channel,segsize,fs)

if ~exist('fs','var');fs = 250;end
if ~exist('segsize','var');segsize = 2;end

% Normalize each channel
channel = normalize(channel);

%get the segments
getsegments(channel,segsize)
segments = ans.segments;
[seg_no,~]=size(segments);

coeff1=[];coeff2=[];coeff3=[]; coeff4=[];coeff_norm=[];fet_2_4=[];fet_4_8=[];fet_8_20=[];fet_20_40=[];

for i= 1:seg_no

 [pow,f]=perceive_fft(segments(i,:),250);

 ind_norm = find(f>=60 & f<=90);

  coeff_n =pow(:,ind_norm(1):ind_norm(end));
  coeff_norm= mean(coeff_n);
 
 ind1= find(f>=2&f<=4);
 if isempty(ind1);coeff1=0;
 else

     coeff1 = pow(:,ind1(1):ind1(end));
     coeff1_avg = mean(coeff1);

  coeff_2_4 = [coeff1_avg/coeff_norm];
 end
fetr1= coeff_2_4;
%fetr1= abs(mean(coeff_2_4.^2))
 fet_2_4= [fet_2_4,fetr1];


 ind2= find(f>4&f<=8);
 if isempty(ind2);coeff2=0;
 else
coeff2 = pow(:,ind2(1):ind2(end));
     coeff2_avg = mean(coeff2);

    coeff_4_8 = [coeff2_avg/coeff_norm];
 end
fetr2= coeff_4_8;
%fetr2= abs(mean(coeff_4_8.^2))
 fet_4_8= [fet_4_8,fetr2];
 

 ind3= find(f>8&f<=20)
 if isempty(ind3);coeff3=0;
 else
 coeff3 = pow(:,ind3(1):ind3(end));
     coeff3_avg = mean(coeff3)


    coeff_8_20 = [coeff3_avg/coeff_norm];
     
 end
 fetr3= coeff_8_20;
 %fetr3= abs(mean(coeff_8_20.^2))

 fet_8_20= [fet_8_20,fetr3];

 ind4= find(f>20&f<=40)
 if isempty(ind4);coeff4=0;
 else
 coeff4 = pow(:,ind4(1):ind4(end));
     coeff4_avg = mean(coeff4);

   coeff_20_40 = [coeff4_avg/coeff_norm];
 end
 fetr4= coeff_20_40;
 %fetr4= abs(mean(coeff_20_40.^2))

 fet_20_40= [fet_20_40,fetr4];
end

coefficients.fet_2_4=fet_2_4

coefficients.fet_4_8=fet_4_8

coefficients.fet_8_20=fet_8_20

coefficients.fet_20_40=fet_20_40
end



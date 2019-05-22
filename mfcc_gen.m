function [ E_dct ] = mfcc_gen( filterbank, frame )
%{
Copyright: Zixi Liu, Email: zixiliu@usc.edu
Disctiption: function mfcc_gen( filterbank, frame ) is used to generate
MFCC of a specific frame. This function is specialized for homework 4. For
further use, you should change the length of DFT to fit your application.
**This function will generate DCT-MFCC and save for the first 13 points of
the coefficients. 
**Q of filterbank is 24. 
%}
fram = frame;
H2 = filterbank;
F_ = fft(fram,1024);
F = F_(1:513);
E = zeros(size(H2,2),1);
for i = 1:size(H2,2)
    E(i) = log(sum(abs(F).^2.*abs(H2(:,i)).^2)/513);%using unit area Mel filter bank
end
E_ = dct(E);
E_dct = E_(1:13);
end


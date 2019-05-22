function [A] = Packing_data(printing)
%{
Copyright: Zixi Liu, USCID: 2219403275, Email: zixiliu@usc.edu
Disctiption: function Packing_data(printing) is used to obtain the framing signal
from free-spoken-digit-dataset-master\recordings fold. 
**printing is a sign to decide if printing the outcome on the console or not 
choosing 1 to print.
**output A will also be saved in Framing_number.mat. 
**the size of the output s_fram is [4,50,10]<==>{person, order, digit}, person =
4, means 'jackson','nicolas','theo','yweweler'; order = 50, meaning the
order 0th - 49th; digit  = 10, meaning the number '0' - '10'. 
%}

s = [];s_fram = cell(4,50,10);num = zeros(1,10);
name = {'jackson','nicolas','theo','yweweler'};
for i = 0:9
    for j = 1:4
        for m = 0:49
            str = strcat('free-spoken-digit-dataset-master\recordings\',int2str(i),'_',name{j},'_',int2str(m),'.wav');
            s1 = audioread(str);%read the audio file
            s = filter([1,-0.97],1,s1);%go through pre-emphasis filter H = 1-0.97z^(-1)
            s_fram{j,m+1,i+1} = framing_and_windowing(s, 8000, 25, 10/25,0,'hamming');
            num(i+1) = num(i+1)+size(s_fram{j,m+1,i+1},2);
            %fprintf(strcat('The frame number of file\t',int2str(i),'_',name{j},'_',int2str(m),'.wav is\t',int2str(num{j,m+1,i+1}),'\n'))
        end
    end
    if printing == 1
        fprintf(strcat('The frame number of digit\t',int2str(i),' is\t',int2str(num(i+1)),'\n'))
    end
end
save('Framing_number.mat', 's_fram')
A = s_fram;

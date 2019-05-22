function [filter_bank1,filter_bank2,Fc] = Mel_Fil_bank (f0, f_qp, fs, Q, N, plotting)
%{
header: hw4@EE519, answer for Part I (c) iii
Copyright: Zixi Liu, USCID: 2219403275, Email: zixiliu@usc.edu
Disctiption: function Mel_Fil_bank (f0, f_qp, fs, Q, N, plotting) is used to
create Mel Filterbank which generate unit height Mel Filterbank, with
regard to output filter_bank1 and unit area Mel Filterbank with regard to
filter_bank2. 
**filter_bank1 and filter_bank2 is a Ndft/2 x Q matrix, that is the row
number of this two matrix is equal to half of the number of DFT points. 
**f0 and f_qp is the low and high cutoff frequencies of the first and the last
filter. Usually f0 = 0 and f_qp = F_Nyquist = fs/2. 
**fs is the sampling rate. 
**Q is the number of triangle filters. 
**N is the number of DFT samples. Usually choose N  = 1024. 
**plotting is a sign to plot the figure or not. Choose 1 to plot the
figure. 
%}
m = zeros(1,Q);
fc = zeros(1,Q);
m0 = 2595*log10(1+f0/700);
m_qp = 2595*log10(1+f_qp/700);
for i = 1:Q
   m(i) = i*(m_qp-m0)/(Q+1)+m0; 
   fc(i) = (10^(m(i)/2595)-1)*700;
end
Fc = fc;
f = 0:fs/(N):fs;
H1 = zeros(ceil(size(f,2)/2),Q);
H2 = zeros(ceil(size(f,2)/2),Q);
fc = [f0 fc f_qp];
for j = 1:Q
    for i = 1:ceil(size(f,2)/2)
        if f(i)<fc(j+1) && f(i)>=fc(j)
            H1(i,j) = (f(i)-fc(j))/(fc(j+1) - fc(j));
            H2(i,j) = 2*(f(i)-fc(j))/((fc(j+2)-fc(j))*(fc(j+1)-fc(j)));
        elseif f(i)<=fc(j+2) && f(i)>=fc(j+1)
            H1(i,j) = (f(i)-fc(j+2))/(fc(j+1) - fc(j+2));
            H2(i,j) = 2*(f(i)-fc(j+2))/((fc(j+2)-fc(j))*(fc(j+1)-fc(j+2)));
        end
    end
end
filter_bank1 = H1;
filter_bank2 = H2;

if plotting == 1
    figure('Name','filter bank','color','w')
    set(gcf,'outerposition',get(0,'screensize'));%maximize the figure window
    subplot(2,1,1)
    for i = 1:Q
        plot(f(1:ceil(size(f,2)/2)),H1(:,i));hold on
    end
    hold off
    title({'unit height Mel Filterbank'},'interpreter','latex')
    xlabel('normal frequency($$Hz$$)','interpreter','latex')
    ylabel('magnitude','interpreter','latex')
    subplot(2,1,2)
    for i = 1:Q
        plot(f(1:ceil(size(f,2)/2)),H2(:,i));hold on
    end
    hold off
    title({'unit area Mel Filterbank'},'interpreter','latex')
    xlabel('normal frequency($$Hz$$)','interpreter','latex')
    ylabel('magnitude','interpreter','latex')
end

end




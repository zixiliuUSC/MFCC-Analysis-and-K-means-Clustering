close all;
load('Framing_number.mat', 's_fram')
digit8 = s_fram{1,18,8};
fram = digit8(:,15);%15th frame of 8_jackson_18.wav
[H1,H2,fc] = Mel_Fil_bank(0, 4000, 8000, 24, 1024, 0);%generate Mel filterbank, 
%H1 is unit hight filterbank and H2 is unit area filterbank and fc is
%central frequency. 
F_ = fft(fram,1024);
F = F_(1:513);
E = zeros(size(H2,2),1);
for i = 1:size(H2,2)
    E(i) = log(sum(abs(F).^2.*abs(H2(:,i)).^2)/513);%using unit area Mel filter bank
end
Ef = log(abs(F).^2);
f = 0:8000/(1024):8000;
figure('name','Mel Spectrum','color','white')
set(gcf,'outerposition',get(0,'screensize'));
plot(fc,E+15);%move up the figure of Ei(j) to show that Mel Spectrum roughly follows the spectral envelope of si[n]
hold on
scatter(fc,E+15,'b*')
hold on 
plot(f(1:ceil(size(f,2)/2)),Ef)
hold off
title({'Mel-Spectrum'},'interpreter','latex')%Mel-Spectrum of 15th frame of 8_jackson_18.wav using unit area Mel filter bank
xlabel('normal frequency($$Hz$$)','interpreter','latex')
ylabel('magnitude($$dB$$)','interpreter','latex')
legend({'Mel spectrum $$E_i(j)$$','','original spectrum'},'interpreter','latex')
set(gca,'TickLabelInterpreter','latex')
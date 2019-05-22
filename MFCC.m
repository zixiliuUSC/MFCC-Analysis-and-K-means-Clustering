close all;
load('Framing_number.mat', 's_fram')
digit8 = s_fram{1,18,8};
fram = digit8(:,15);%15th frame of 8_jackson_18.wav
[H1,H2,fc] = Mel_Fil_bank(0, 4000, 8000, 24, 1024, 0);
F_ = fft(fram,1024);
F = F_(1:513);
E = zeros(size(H2,2),1);
for i = 1:size(H2,2)
    E(i) = log(sum(abs(F).^2.*abs(H2(:,i)).^2)/513);%using unit area Mel filter bank
end
Ef = log(abs(F).^2);
f = 0:8000/(1024):8000;
E_dct = dct(E);
E_comp = E_dct(1:13);
E_rec= idct(E_comp,24);
figure('name','Mel Spectrum','color','white')
set(gcf,'outerposition',get(0,'screensize'));
subplot(2,1,1)
plot(fc,E_rec+15);%move up the figure of Ei(j) to show that Mel Spectrum roughly follows the spectral envelope of si[n]
hold on 
scatter(fc,E_rec+15,'b*')
plot(fc,E+15,'color',[0.9290 0.6940 0.1250]);scatter(fc,E+15,'*','MarkerEdgeColor',[0.9290 0.6940 0.1250])
plot(f(1:ceil(size(f,2)/2)),Ef,'r')
hold off
title({'Mel-Spectrum'},'interpreter','latex')%Mel-Spectrum of 15th frame of 8_jackson_18.wav using unit area Mel filter bank
xlabel('normal frequency($$Hz$$)','interpreter','latex')
ylabel('magnitude($$dB$$)','interpreter','latex')
legend({'Mel spectrum $$\hat{E}_i(j)$$','','Mel spectrum $$E_i(j)$$','','original spectrum'},'interpreter','latex')
set(gca,'TickLabelInterpreter','latex')
subplot(2,1,2)
plot(fc,abs(E_rec-E));hold on
scatter(fc,abs(E_rec-E),'b*')
hold off
title({'Error between $$\hat{E}_i(j)$$ and $$E_i(j)$$'},'interpreter','latex')%Mel-Spectrum of 15th frame of 8_jackson_18.wav using unit area Mel filter bank
xlabel('normal frequency($$Hz$$)','interpreter','latex')
ylabel('magnitude($$dB$$)','interpreter','latex')
legend({'$$|\hat{E}_i(j) - E_i(j)|$$',''},'interpreter','latex')
set(gca,'TickLabelInterpreter','latex')
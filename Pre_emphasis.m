close all;
[Hp,w] = freqz([1, -0.97],1,1024);
figure('name','pre-emphasis','color','white')%name the figure and set the background to white
set(gcf,'outerposition',get(0,'screensize'));%maximize the figure window
subplot(2,1,1)
plot(w,20*log(abs(Hp)))%plot the spectrum of the filter in dB
title({'spectrum of pre-emphasis filter'},'interpreter','latex')
xlabel('normal frequency($$rad$$)','interpreter','latex')
ylabel('magnitude($$dB$$)','interpreter','latex')

N = 1024;
s1 = audioread('free-spoken-digit-dataset-master\recordings\0_nicolas_26.wav');
S1 = fft(s1,N);%original spectrum 
s1_fil = filter([1,-0.97],1,s1);%filter original waveform with pre-emphasis filter. 
S1_fil = fft(s1_fil,N);
ws = linspace(0,pi,ceil(N/2));
subplot(2,1,2)
plot(ws,20*log(abs(S1(1:ceil(N/2)))));
hold on
plot(ws,20*log(abs(S1_fil(1:ceil(N/2)))));
xlabel('normal frequency($$rad$$)','interpreter','latex')
ylabel('magnitude($$dB$$)','interpreter','latex')
legend({'original spectrum','filtered spectrum'},'interpreter','latex')
set(gca,'TickLabelInterpreter','latex')%use latex to generate label

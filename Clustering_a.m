load('Framing_number.mat', 's_fram')
[H1,H2,fc] = Mel_Fil_bank(0, 4000, 8000, 24, 1024, 0);
[p, q, m] = size(s_fram);
mfcc1 = cell([p, q]);
mfcc8 = cell([p, q]);
c1_1 = [];
c1_4 = [];
c8_1 = [];
c8_4 = [];
M1 = 0;
M2 = 0;
for i = 1:p
    for j = 1:q
        digit1 = s_fram{i,j,2};
        digit8 = s_fram{i,j,9};
        m1 = size(digit1,2);
        m2 = size(digit8,2);
        E_dct1 = zeros(13,m1);
        E_dct2 = zeros(13,m2);
        for k1 = 1:m1
            E_dct1(:,k1) = mfcc_gen(H2,digit1(:,k1));
        end
        %mfcc1{i,j} = E_dct1;
        c1_1 = [c1_1 E_dct1(2,:)];
        c1_4 = [c1_4 E_dct1(5,:)];
        for k2 = 1:m2
            E_dct2(:,k2) = mfcc_gen(H2,digit8(:,k2));
        end
        %mfcc8{i,j} = E_dct2;
        c8_1 = [c8_1 E_dct2(2,:)];
        c8_4 = [c8_4 E_dct2(5,:)];
        %M1 = M1+m1;
        %M2 = M2+m2;
    end
end

r = -14:0.5:19;
count1_1 = hist(c1_1,r);
count1_4 = hist(c1_4,r);
count8_1 = hist(c8_1,r);
count8_4 = hist(c8_4,r);
figure('name','histograms','color','white')
set(gcf,'outerposition',get(0,'screensize'));
subplot(2,2,1)
hist(c1_1,r)
title({'histograms of $$C_1(1)$$'},'interpreter','latex')
xlabel('magnitude($$dB$$)','interpreter','latex')
ylabel('number of samples','interpreter','latex')
subplot(2,2,2)
hist(c1_4,r)
title({'histograms of $$C_1(4)$$'},'interpreter','latex')
xlabel('magnitude($$dB$$)','interpreter','latex')
ylabel('number of samples','interpreter','latex')
subplot(2,2,3)
hist(c8_1,r)
title({'histograms of $$C_8(1)$$'},'interpreter','latex')
xlabel('magnitude($$dB$$)','interpreter','latex')
ylabel('number of samples','interpreter','latex')
subplot(2,2,4)
hist(c8_4,r)
title({'histograms of $$C_8(4)$$'},'interpreter','latex')
xlabel('magnitude($$dB$$)','interpreter','latex')
ylabel('number of samples','interpreter','latex')

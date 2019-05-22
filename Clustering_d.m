close all
M = load('mfcc_all.mat', 'mfcc1');
digit1 = [];
digit8 = [];
order = zeros(1,4*50+1);
order(1) = 1;
order2 = zeros(1,4*50+1);
order2(1) = 1;
n = 0;
for i = 1:4
    for j = 1:50
        n = n + 1;
        m = size(M.mfcc1{i,j,2},2);
        m2 = size(M.mfcc1{i,j,9},2);
        order(n+1) = order(n) + m;
        order2(n+1) = order2(n) + m2;
        for k = 1:m
           digit1 = [digit1;(M.mfcc1{i,j,2}(:,k))'];
        end
        for k1 = 1:m2
           digit8 = [digit8;(M.mfcc1{i,j,9}(:,k1))'];
        end
    end
end
[idx,C1] = kmeans(digit1,6);
[idx2,C2] = kmeans(digit8,6);

figure('name','Part 2 (d)','color','white')
set(gcf,'outerposition',get(0,'screensize'));
title({'K-means clustering of digit1'},'interpreter','latex')
hold on
x1 = 1:(order(23)-order(22));
id1 = idx(order(22):(order(23)-1))';
plot(x1,id1,'-.')

x2 = 1:(order(18)-order(17));
id2 = idx(order(17):(order(18)-1))';
plot(x2,id2,'--')

x3 = 1:(order(10)-order(9));
id3 = idx(order(9):(order(10)-1))';
plot(x3,id3,'-*')

x4 = 1:(order(49)-order(48));
id4 = idx(order(48):(order(49)-1))';
plot(x4,id4,'-o')
xlabel('frame index','interpreter','latex')
ylabel('cluster label$$(1,2,...,6)$$','interpreter','latex')
legend({'$$22^{th}$$ recording','$$17^{th}$$ recording','$$9^{th}$$ recording','$$48^{th}$$ recording'},'interpreter','latex')

figure('name','Part 2 (d)','color','white')
set(gcf,'outerposition',get(0,'screensize'));
title({'K-means clustering of digit8'},'interpreter','latex')
hold on
x1 = 1:(order2(23)-order2(22));
id1 = idx2(order2(22):(order2(23)-1))';
plot(x1,id1,'-.')

x2 = 1:(order2(18)-order2(17));
id2 = idx2(order2(17):(order2(18)-1))';
plot(x2,id2,'--')

x3 = 1:(order2(10)-order2(9));
id3 = idx2(order2(9):(order2(10)-1))';
plot(x3,id3,'-*')

x4 = 1:(order2(49)-order2(48));
id4 = idx2(order2(48):(order2(49)-1))';
plot(x4,id4,'-o')
xlabel('frame index','interpreter','latex')
ylabel('cluster label$$(1,2,...,6)$$','interpreter','latex')
legend({'$$22^{th}$$ recording','$$17^{th}$$ recording','$$9^{th}$$ recording','$$48^{th}$$ recording'},'interpreter','latex')

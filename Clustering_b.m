M = load('mfcc_all.mat', 'mfcc1');
%[H1,H2,fc] = part_c_iii(0, 4000, 8000, 24, 1024, 0);
%mfcc1 = cell(size(s_fram));
C = zeros(4,50,10,2);
C_tuda = zeros(10,2);
%num = zeros(1,10);
for k = 1:10
    for i = 1:4
        for j = 1:50
            E_dct1 = M.mfcc1{i,j,k};
            C(i,j,k,1) = mean(E_dct1(2,:));
            C(i,j,k,2) = mean(E_dct1(5,:));
        end
    end
end
for  i1 = 1:10
    C_tuda(i1,1) = mean(mean(C(:,:,i1,1)));
    C_tuda(i1,2) = mean(mean(C(:,:,i1,2)));
end
close all
figure('name','Feature Distribution','color','white')
set(gcf,'outerposition',get(0,'screensize'));
hold on
for k = 1:10
    C1 = reshape(C(:,:,k,1),200,1);
    C2 = reshape(C(:,:,k,2),200,1);
    scatter(C1,C2,'.','LineWidth',0.75)
    scatter(C_tuda(k,1),C_tuda(k,2),'*','LineWidth',1.5)
end
legend({'digit 0 $$\bar{C_0}$$','digit 0 $$\widetilde{C_0}$$',...
    'digit 1 $$\bar{C_1}$$','digit 1 $$\widetilde{C_1}$$',...
    'digit 2 $$\bar{C_2}$$','digit 2 $$\widetilde{C_2}$$',...
    'digit 3 $$\bar{C_3}$$','digit 3 $$\widetilde{C_3}$$',...
    'digit 4 $$\bar{C_4}$$','digit 4 $$\widetilde{C_4}$$',...
    'digit 5 $$\bar{C_5}$$','digit 5 $$\widetilde{C_5}$$',...
    'digit 6 $$\bar{C_6}$$','digit 6 $$\widetilde{C_6}$$',...
    'digit 7 $$\bar{C_7}$$','digit 7 $$\widetilde{C_7}$$',...
    'digit 8 $$\bar{C_8}$$','digit 8 $$\widetilde{C_8}$$',...
    'digit 9 $$\bar{C_9}$$','digit 9 $$\widetilde{C_9}$$',...
    },'interpreter','latex')
xlabel('$$\bar{C_i}(1)$$','interpreter','latex')
ylabel('$$\bar{C_i}(4)$$','interpreter','latex')
set(gca,'TickLabelInterpreter','latex')


M = load('mfcc_all.mat', 'mfcc1');
C = zeros(4,50,10,13);
C_mean = zeros(10,13);
for k = 1:10
    for i = 1:4
        for j = 1:50
            for v = 1:13
                E_dct1 = M.mfcc1{i,j,k};
                C(i,j,k,v) = mean(E_dct1(v,:));
            end
        end
    end
end
for  i1 = 1:10
    C_mean(i1,:) = mean(mean(C(:,:,i1,:)));
end
X = reshape(C,4*50*10,13);
%[idx,C1] = kmeans(X,[],'start',C_mean);
[idx,C1] = kmeans(X,10);

%use optimalMatch.m to finds an optimal matching between those 2 sets of labels
y_truth = [0*ones(1,200),1*ones(1,200),2*ones(1,200),3*ones(1,200),...
    4*ones(1,200),5*ones(1,200),6*ones(1,200),7*ones(1,200),8*ones(1,200),9*ones(1,200),]';
[y_pred_matched, acc] = optimalMatch(idx, y_truth);
acc




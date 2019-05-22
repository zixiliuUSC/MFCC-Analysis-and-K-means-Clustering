function [y_pred_matched, acc] = optimalMatch(y_pred, y_truth)
% Find optimal matching between two sets of labels, based on accuracy
%
% INPUTS:
% y_pred: vector of predicted labels (Nx1)
% y_truth: vector of true labels (Nx1)
% 
% OUTPUTS:
% y_pred_matched: vector of predicted labels, rearanged to match y_pred (Nx1)
% acc: accuracy of y_pred_matched given y_truth

N = length(y_truth);
assert(N == length(y_pred)); % make sure the 2 vectors are of the same length 

pred_names = unique(y_pred);
truth_names = unique(y_truth);

perm = perms(truth_names);

acc = 0;
y_pred_matched = y_pred;

for ii = 1:size(perm, 1)
    new_labels = zeros(N, 1);
    for jj = 1:size(perm, 2)
        new_labels(y_pred == pred_names(jj)) = perm(ii, jj);
    end

    new_acc = sum(new_labels == y_truth)/N;
    if new_acc > acc
        acc = new_acc;
        y_pred_matched = new_labels;
    end
end
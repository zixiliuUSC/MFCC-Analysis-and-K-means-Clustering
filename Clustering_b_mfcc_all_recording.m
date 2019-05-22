load('Framing_number.mat', 's_fram')
[H1,H2,fc] = part_c_iii(0, 4000, 8000, 24, 1024, 0);
mfcc1 = cell(size(s_fram));
num = zeros(1,10);
for k = 1:10
    for i = 1:4
        for j = 1:50
            digit1 = s_fram{i,j,k};
            m1 = size(digit1,2);
            E_dct1 = zeros(13,m1);
            for k1 = 1:m1
                E_dct1(:,k1) = mfcc_gen(H2,digit1(:,k1));
            end
            mfcc1{i,j,k} = E_dct1;
            num(k) = num(k)+size(s_fram{i,j,k},2);
        end
    end
end
save('mfcc_all.mat','mfcc1')







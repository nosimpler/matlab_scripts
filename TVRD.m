function U = TVRD(X)
U = [];
for i = 1:size(X,1)
    %1e-8 works for maintaining most features in MEG
    U(i,:) = TVRegDiff(X(i,:), 10, 1e-8, [], 'large', 1e-6, 1/600, 0, 0);
    i
    
    
end
%figure;
%plot(U')
end
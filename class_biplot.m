function class_biplot(X,y)
X0 = X(y==0,:);
X1 = X(y==1,:);
figure
hold on
scatter3(X0(:,1),X0(:,2), X0(:,3), 'r')
scatter3(X1(:,1),X1(:,2), X1(:,3), 'b')
end
function [X,Y] = compile_dataset(no, yes, n)
X = [no(1:n,:); yes(1:n,:)]
Y = [zeros(n,1); ones(n,1)]
end
function [c, cl] =xtree2code(xt)
% xtree2code(xt) converts a varialble length prefix-free code from extended
% tree notation to code notation (list of codewords and list of lengths).
%
% Copyright Jossy, 2016

[c,cl] = tree2code(xt(1,:));
leaves = setdiff(1:length(xt(1,:)), xt(1,:));

for k=1:length(cl) % for all codewords
    n = leaves(k); % set node to leaf
    d = cl(k);
    while (xt(1,n) ~= 0) % while not root
        parent = xt(1,n); %n's parent 
        % if the parent doesn't point to this child for the correct symbol
        if (xt(2+c(k,d),parent) ~= n)  
            c(k,d) = 1-c(k,d); % flip from 0 to 1 or vice versa
        end
        n = parent; % crawl up tree
        d = d-1;
    end
end
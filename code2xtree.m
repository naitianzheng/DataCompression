function xt = code2xtree(c, cl)
% code2xtree(c, cl) converts a variable length code described by the matrix
% c of codewords (one codeword per row) and codeword lengths cl to an
% extended tree representation of the prefix-free code where every node
% points to its parent and child(ren) node(s).
%
% Copyright Jossy, 2016

xt = zeros(3,1); % root

for k = 1:length(cl)
    n = 1; % start at root
    for j = 1:cl(k);
        child = xt(2+c(k,j),n);
        if (child == 0) % no such child yet
            % create child
            xt = [xt [n;zeros(2,1)]];
            child = size(xt,2);
            xt(2+c(k,j),n) = child;
        end
        n = child;
    end
end

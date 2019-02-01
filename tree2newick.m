function y = tree2newick(t,labels,n)
% binarytree2newick(t) takes a tree t in MATLAB's pointer format (list of
% pointers where each node points to its parent, pointer zero is the root
% node) to Newick format (see https://en.wikipedia.org/wiki/Newick_format)
% for use for example in tree representation software such as 
% http://phylo.io
%
% By default the nodes are simply numbered 1:length(t). The user can supply
% node labels as an optional argument 'labels'.
%
% The extra parameter n is used internally when calling itself recursively
% and should not be supplied by the user.
%
% Copyright Jossy, 2016

if (nargin == 1 || isempty(labels))
    labels = 1:length(t)-1;
else
    leaves = setdiff(1:length(t),t);
    if (length(labels) == length(leaves))
        newlabels = zeros(1,length(t));
        newlabels(leaves) = labels;
        labels = newlabels;
    end
end

if (nargin < 3)
    n = find(t == 0);
    if (length(n) ~= 1)
        error('Tree has no root or more than one root');
    end
end

ii = find(t == n);
if (isempty(ii))
    if (n > length(labels))
        y = '';
    else
        y = sprintf('%d',labels(n));
    end
    return;
end

y = tree2newick(t,labels,ii(1));
for k=2:length(ii)
    y = strcat(y,',',tree2newick(t,labels,ii(k)));
end
if (n > length(labels))
    y = sprintf('(%s)',y);
else
    y = sprintf('(%s)%d',y,labels(n));
end
return;

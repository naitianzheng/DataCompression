function xt = tree2xtree(t)
% tree2xtree(t) takes a tree described by a list of nodes and their
% parents and adds rows to contain pointers to a node's children as
% well. The indices in the children columns point to the child nodes of
% a node, or zero if there is no corresponding child. A leaf will have
% all zeros in rows 2:end.
%
% Copyright Jossy 2016

root = find(t == 0);
% the following should be 2 for binary trees.
maxchildren = max(hist(t,0:length(t)));

% prepare the structure for holding the tree with parents and children
xt = [t(:)'; zeros(maxchildren,length(t))];

% for every node except the root
for k = setdiff(1:length(t),root)
    j = 2; % look for a position to insert the child of t(k)
    while (xt(j,t(k)) ~= 0) % if occupied
        j = j+1; % go to next column
    end
    xt(j,t(k)) = k; % insert the child
end

return;

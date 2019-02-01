p = rand(1,10) ;
p = p/sum(p);
[c,cl] = shannon_fano(p);
t = code2tree(c,cl);
treeplot(t);
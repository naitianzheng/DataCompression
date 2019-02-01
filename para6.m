fid = fopen('hamlet.txt','r');
hamlet = fread(fid)';
fclose(fid);
p = hist(hamlet,0:255);
p = p/sum(p);
%nonzero = find(p);
n=5;lo=0.0;hi=1.0;for k=1:n;range=hi-lo;...
        hi=lo+range*sum(p(1:(hamlet(k)+1)));...
        lo=lo+range*sum(p(1:hamlet(k)));end
hi
lo
L = 64; dec2bin(lo*2^L,L)
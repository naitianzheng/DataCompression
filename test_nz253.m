fid = fopen('plrabn12.txt', 'r');
hamlet = fread(fid)';
fclose(fid);
p = hist(hamlet,0:255);
p = p/sum(p);
lowercase = find(hamlet>='a' & hamlet<='z');
hamlet_uppercase = hamlet;
hamlet_uppercase(lowercase) = hamlet_uppercase(lowercase)-'a'+'A';
P = hist(hamlet_uppercase,0:255);
P = P/sum(P);
H(p)
%y =arith_encode(hamlet_uppercase,P);
%y = bits2bytes(y);
%fprintf('Compression ratio: %g\n', 8*length(y)/length(hamlet_uppercase));
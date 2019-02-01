fid = fopen('hamlet.txt', 'r');
hamlet = fread(fid)';
fclose(fid);
char(hamlet(1:1000))
p = hist(hamlet,0:255);
p = p/sum(p);
nonzero = find(p);

fid = fopen('hamlet.txt.uz2', 'r');
hamlet = fread(fid)';
fclose(fid);
char(hamlet(1:1000))
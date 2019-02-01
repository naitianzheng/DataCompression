function camzip2(filename)
% camzip2(filename) compresses a file using the Huffman code
%
% Copyright Jossy 2016

f = fopen(filename,'r');
if (f == -1)
    error('Cannot open input file');
end
in = fread(f)';
fclose(f);

p = hist(in,0:255);
p = p/sum(p);

[c,cl] = huffman(p);
out = vl_encode(in,c,cl,0:255);
out(150)=1-out(150);
out = bits2bytes(out);

fprintf('Compression ratio: %g\n', 8*length(out)/length(in));

f = fopen(strcat(filename,'.cz2'),'w');
if (f == -1)
    error('Cannot open output file');
end
fwrite(f,out);
fclose(f);

save(strcat(filename,'.cz2c'),'c','cl');

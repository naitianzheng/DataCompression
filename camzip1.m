function camzip1(filename)
% camzip1(filename) compresses a file using the Shannon Fano code
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

[c,cl] = shannon_fano(p);
out = vl_encode(in,c,cl,0:255);
out = bits2bytes(out);

fprintf('Compression ratio: %g\n', 8*length(out)/length(in));

f = fopen(strcat(filename,'.cz1'),'w');
if (f == -1)
    error('Cannot open output file');
end
fwrite(f,out);
fclose(f);

save(strcat(filename,'.cz1c'),'c','cl');

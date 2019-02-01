function camunzip2(filename)
% camunzip2(filename) decompresses a file using the vl code provided
%
% Copyright Jossy 2016

% if the user enters the filename with .cz1 extension cut it out
if (strcmp(filename((end-3):end),'.cz2'))
    filename = filename(1:(end-4));
end

f = fopen(strcat(filename,'.cz2'),'r');
if (f == -1)
    error('Cannot open compressed file');
end
in = fread(f)';
fclose(f);

load(strcat(filename,'.cz2c'),'-mat','c','cl');
in = bytes2bits(in);

out = vl_decode(in,c,cl);

f = fopen(strcat(filename,'.uz2'),'w');
if (f == -1)
    error('Cannot open output file');
end
fwrite(f,out);
fclose(f);


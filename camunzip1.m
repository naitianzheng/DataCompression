function camunzip1(filename)
% camunzip1(filename) decompresses a file using the vl code provided
%
% Copyright Jossy 2016

% if the user enters the filename with .cz1 extension cut it out
if (strcmp(filename((end-3):end),'.cz1'))
    filename = filename(1:(end-4));
end

f = fopen(strcat(filename,'.cz1'),'r');
if (f == -1)
    error('Cannot open compressed file');
end
in = fread(f)';
fclose(f);

load(strcat(filename,'.cz1c'),'-mat','c','cl');
in = bytes2bits(in);

out = vl_decode(in,c,cl);

f = fopen(strcat(filename,'.uz1'),'w');
if (f == -1)
    error('Cannot open output file');
end
fwrite(f,out);
fclose(f);


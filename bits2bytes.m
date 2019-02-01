function y = bits2bytes(x)
% bits2bytes(x) converts a vector of binary symbols to a vector of bytes
% (values between 0 and 255.) If the input vector is not an integer number
% of bytes (length divisible by 8), then zero bits are added at the end of
% the vector. Beware of decompressing a file with added zeros in this
% manner as it may differ from the original if the added zeros append one
% or several codewords at the end of the compressed file. It is essential
% to store the length of the file and to stop decoding when the length is
% reached.
%
% Copyright Jossy 2016

n = length(x)+3;
r = mod(8-rem(n,8),8); % number of bits to be added to make up bytes

x = [(double(dec2bin(r,3))-'0')';x(:);zeros(r,1)];
nbytes = length(x)/8;
y = bin2dec(char(reshape(x,8,nbytes)'+'0'));

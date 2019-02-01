function y = bytes2bits(x)
% bytes2bits(x) converts a vector of bytes (values between 0 and 255) to a
% vector of bits. 
%
% Copyright Jossy 2016

y = (double(dec2bin(x,8))-'0')';
y = y(:)';

r = bin2dec(char(y(1:3)+'0'));

y = y(4:(end-r));

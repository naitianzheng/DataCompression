function y=vl_encode_fast(x, c, cl)
% vl_encode_fast(x, c, cl) encodes the input word x using the variable
% length code described in c (every row contains a codeword) and cl
% (lengths of the codewords.) This "fast" version only works with an input
% alphabet 0:255 (bytes).
%
% Copyright Jossy, 2016


% CHECK INPUT ARGUMENTS
if (nargin ~= 3)
    error('Syntax: vl_encode_fast(x,c,cl)');
end
if (length(cl) ~= 256 | size(c,1) ~= 256)
    error('vl_encode_fast only works with an input alphabet of 0:255');
end

% binary encode
ny = 0;
for k = 1:length(x)
    x(k) = x(k)+1;
    ny = ny + cl(x(k));
end
y = zeros(1,ny);
yp = 1;
for k = 1:length(x)
    y(yp:(yp+cl(x(k))-1)) = c(x(k),1:cl(x(k)));
    yp = yp + cl(x(k));
end

return;

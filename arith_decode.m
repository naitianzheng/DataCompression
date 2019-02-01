function y = arith_decode(x, p, ny, alphabet)
% arith_decode(x,p) implements the binary arithmetic encoder for the source
% sequence x using the memoryless probability model p. It attempts to
% decode ny symbols from the code string x where binary code symbols are
% drawn from the pointer position xp. The default for xp is 1.
%
% Note that the flexibility to decode any number of source symbols means
% that this can be used to decode the whole source sequence using the model
% p (e.g. call arith_decode(x,p,file_length,1,1)) or to decode one symbol
% at a time, say using a different model p for every symbol (as you would
% in conditional or context-based decoders.)
%
% Copyright Jossy 2016, heavily inspired by Witten, Neal & Cleary 1987

precision = 32;
one = 2^precision-1;
quarter = ceil(one/4);
half = 2*quarter;
threequarters = 3*quarter;

if (nargin < 3)
    error('Syntax: arith_decode(x,p,ny[,alphabet])');
end
if (nargin < 4)
    alphabet = (1:length(p))-1;
else
    if (length(alphabet) ~= length(p))
        error('Alphabet size does not match probability distribution');
    end
end
if (~isempty(find(p<0)) || abs(sum(p)-1) > 1e-5)
    error('Illegal probability distribution');
end

f = cumsum(p(:));
f = [0 ; f((2:end)-1)];
y = zeros(1,ny);

hi = one;
lo = 0;
x = [x(:)' zeros(1,precision+1)]; % make row vector and add dummy zeros
value = bin2dec(char(x(1:precision)+'0')); % target value for interval
xp = precision+1; % pointer to next symbol in the input pipeline


for k = 1:ny
    range = hi - lo + 1;
    ind = max(find(lo+ceil(f*range)<=value));
    y(k) = alphabet(ind);
    
    lo = lo + ceil(f(ind)*range);
    hi = lo + floor(p(ind)*range);

    if (hi == lo)
        error('Interval has become zero: check that you have no zero probs and increase precision');
    end
    
    while (1)
        if (hi < half)
             % DO NOTHING
        elseif (lo >= half) 
            lo = lo-half;
            hi = hi-half;
            value = value-half;
        elseif (lo >= quarter && hi < threequarters) % interval within [1/4,3/4]
            lo = lo-quarter;
            hi = hi-quarter;
            value = value-quarter;
        else
            break;
        end 
        lo = 2*lo;
        hi = 2*hi+1;
        value = 2*value+x(xp);
        xp = xp+1;
        if (xp == length(x))
            error('Unable to decompress');
        end
    end
end


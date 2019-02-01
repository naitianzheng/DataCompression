function [c,cl] = shannon_fano(p)
% shannon_fano(p) computes the Shannon-Fano code based
% on the probabilities p. 
%
% Copyright Jossy 2016

% THIS IS A "SHELL" FUNCTION ONLY WHOSE ROLE IS TO CHECK THE INPUTS, SORT
% THE PROBABILITIES AND GET RID OF ZERO PROBABILITIES BEFORE CALLING THE
% "REAL" SHANNON-FANO FUNCTION SF FURTHER DOWN. SCROLL DOWN TO THE SF
% FUNCTION AND COMPLETE IT.

% check format and validity of input
if (nargin ~= 1 | abs(sum(p)-1.0) > 1e-5 | ~isempty(find(p<0)))
    error('Argument of shannon_fano must be a probability ditribution');
end

% there may be zero probabilities. These will just be ignored and no
% codeword provided for them.
p = p(:); % turns p into a column vector if not already
np = length(p);
[ps, index] = sort(p, 'descend');
nz = find(ps); % first nz indexed probabilities are non-zero

    % call the true Shannon Fano function
[cnz, clnz] = sf(ps(nz));

cl = zeros(np,1);
c = zeros(np, max(clnz));

% assign the codewords found for symbols of non-zero probability

cl(index(nz)) = clnz;
c(index(nz),:) = cnz;

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%   SHANNON-FANO CODE: PLEASE COMPLETE THIS FUNCTION                   %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c, cl] = sf(p)
% This internal Shannon-Fano function assumes that its input probability
% vector is sorted in decreasing order and doesn't contain any zero
% probabilities.
%
% Copyright Jossy 2016

% compute the codeword lengths for the Shannon-Fano code
% PLEASE COMPLETE
cl = ceil(-log(p)/log(2));

% You now have two options: either construct the extended tree with the
% given codeword lengths from the root, or use Shannon's method
% PLEASE DELETE THE OPTION YOU ARE NOT PURSUING.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPTION 1: SHANNON'S METHOD %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 1) COMPUTE THE CUMULATIVE DISTRIBUTION f FROM p
%    Use the cumsum() function to sum the probability vector, but this
%    function will yield the sum of probabilities up to and **including**
%    the current value, whereas Shannon wants the probability up to and
%    **excluding** the current value. For example, the 3rd entry given by
%    cumsum() will be p(1)+p(2)+p(3) whereas Shannon wants it to be
%    p(1)+p(2). Hence, you can get the desired cumulative probability by
%    taking the result of cumsum(), appending a zero at the beginning (the
%    first entry in Shannon's cumulative is always 0 because it is the sum
%    of all entries up to and exclusing the first probability, or in other
%    words the sum of no entries at all, hence zero), then ommitting the
%    last entry in cumsum() (which is alway 1 if p is a legal probability
%    vector that sums to 1).
%
% 2) CONVERT THE CUMULATIVE PROBABILITIES TO BINARY 
%    Use the command indicated in the lab handout
%     c = double(dec2bin(round(f*2^(max(cl)+2))))-'0';
%    where we've assumed that your cumulative probability computed above is
%    in a column vector f, and we've added 2 safety digits (see explanation
%    below).
%
% 3) TRUNCATE RESULTING CODE TABLE TO LENGTH OF LONGEST CODEWORD
%    You've computed the binary expressions for the codewords to a longer
%    precision than is necessary to avoid rounding errors in your code. Now
%    you need to truncate the code table to the correct length max(cl).

% Note that steps 2 and 3 could in principle be done as one, but there is a
% danger that the "round" operation may yield the wrong last digit. It is
% recommended to round at a higher precision than the maximum codeword
% length and then truncate the table to the maximum codeword length in a
% separate step.

% COMPLETE STEPS 1 to 3 HERE
%STEP 1
f = cumsum(p);
f = [0;f(1:length(f)-1)]; 
%STEP 2
c = double(dec2bin(round(f*2^(max(cl)+2))))-'0';

%STEP 3
c = c(:,1:max(cl));


return;

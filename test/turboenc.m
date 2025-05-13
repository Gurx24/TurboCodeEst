%%%%%%%%%%%%%%%%%%%%%% turboenc.m %%%%%%%%%%%%%%%%%%%%%
%
% This program realized turrbo encoding.
% 
% date:2025.5.13  Gurx
%
% y = turboenc(g, ib, termin)
%
% ***********************************************************
% ib     : input information bits
% g      : generator matrix of convolutional code
% termin : terminate the trellis, set all zeros of register
% y      : output Turbo codewords
% ***********************************************************

function y = turboenc(g, ib, termin)

[n,K] = size(g);
m     = K - 1;

if termin > 0
    Linf = length(ib);
    L    = Linf + m;
else
    L    = length(ib);
    Linf = L - m;
end
state = zeros(1,m);      % initialize register state

% generate the codeword
for i = 1:L
    if termin<0 || (termin>0 && i<=Linf )
        xk = ib(1,i);
    elseif termin>0 && i>Linf
        xk = rem(g(1,2:K)*state', 2);   % terminate the trellis
    end
    xak = rem(g(1,:)*[xk state]', 2);   % feedback
    [outputbits, state] = convencode(g, xak, state);
    outputbits(1, 1)    = xk;
    y(n*(i-1)+1:n*i)    = outputbits;
end

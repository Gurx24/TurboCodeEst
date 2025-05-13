%%%%%%%%%%%%%%%%%%%% convencode.m %%%%%%%%%%%%%%%%%%%
%
% This function realized 1/n convolutional encoding.
%
% date:2025.5.12  Gurx
%
% [out, state] = convencode(in, g, state)
%
% ******************************************************
% in    : input information bits
% g     : generator matrix of convolutional code
% state : state of register
% out   : output codewords
% ******************************************************

function [out, state] = convencode(g, in, state)

[n,k] = size(g);        % convolutional code parameters
m     = k-1;            % number of register
out   = zeros(1, n);
for i = 1:n
    out(i) = g(i,1) * in;
    for j = 2:k
        out(i) = xor(out(i),g(i,j)*state(j-1));
    end
end
state = [in, state(1:m-1)];
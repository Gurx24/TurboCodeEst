%%%%%%%%%%%%%%%%% convencode.m %%%%%%%%%%%%%%%%
%
% This function realized convolutional encoding.
%
% date:2025.5.12  Gurx
%
% [out] = convencode(in, G, state)
%
% ******************************************************
% in    : input information bits
% G     : octal generator matrix of convolutional code
% state : state of register
% out   : output codewords
% ******************************************************

function [out, state] = convencode(in, G, state)

[k, n] = size(G);
G      = dec2bin(base2dec(num2str(G), 8)) - '0';


end
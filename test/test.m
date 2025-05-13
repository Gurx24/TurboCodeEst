%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% test.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% This program realized Turbo encoding,
% the register ended in all zeros state.
%
% date:2025.5.13   Gurx
%

clc; clear; close all;

%************************* Parameters part **************************%

g     = [1 1 1 1 1; 1 0 0 0 1];  % generator matrix
ip    = [1 0 0 1 1 0];           % info. input bits
[n,K] = size(g);                 % parameters of convolutional code
m     = K - 1;                   % number of register
term1 = input(['enter 1 terminated trellises, ' ...
               '-1 for unterminated trellises:']);
term2 = -1;
if term1==1
    L = length(ip) + m;
else
    L = length(ip);
end

%************************* Turbo eencoding **************************%

op1    = turboenc(g, ip, term1);
y(1,:) = op1(1:2:2*L);              % information bits
y(2,:) = op1(2:2:2*L);              % encoded bits
interl = [3 7 6 2 5 10 1 8 9 4];    % rand interleaving
ip1    = zeros(1, L);
for i = 1:L
    ip1(1,i) = y(1,interl(i));      % interleaved input
end
op2    = turboenc(g, ip1,term2);
y(3,:) = op2(2:2:2*L);

%*************************** Puncturing *****************************%

punc   = input('enter 0 for unpuctured code, 1 for punctured code:');
if punc==0
    x  = y(1,:); 
    p1 = y(2,:);
    p2 = y(3,:);
    y  = [x; p1; p2];
    y  = 2 * y - ones(size(y));
end
if punc==1
    x    = y(1,:);
    p1   = y(2,1:2:end);
    p2   = y(3,2:2:end);
    y11  = x;
    y12  = [p1; p2];
    y1p  = 2*y11-ones(size(y11));
    y23p = 2*y12-ones(size(y12));
end

%**************************** end of file ***************************%
% P is the CRC polynomial value (prefix with 0x to denote a hex value)
% m is the degree of the CRC polynomial (max = 32)
% w is the width of the data to be processed (max = 32)
function FM = getFM(P,m,w)

% Convert P to a binary value
P = str2num(dec2bin(P)');

if (m>32 || w>32)
	error('Polynomial degree and data width must not exceed 32');
end

P=[zeros(m-length(P),1); P];

F = [[P; zeros(32-m,1)], [eye(31); zeros(1,31)]];
res = F;
for i=1:1:w-1
	res = mod(res*F,2);
end
res(1:32,max(m,w)+1:32)=0; % adjustment for w<32 && m<32
nbit = 2.^(size(res,2)-1:-1:0);

FM = dec2hex(nbit*res.');

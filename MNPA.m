clear all;
R1 = 1; R2 = 2; R3 = 10; R4 = 0.1; R0 = 1000;
Cc = 0.25; L = 0.2; alpha = 100; Vin = 1;
n = 5;
global G C b
C = sparse(n,n); G = sparse(n,n); b = sparse(n,1);

% Comment out for AC histogram 
% res(1,2,R1); res(2,0,R2); res(3,0,R3);  
% res(4,5,R4); res(5,0,R0); cap(1,2,Cc);
% vol(1,0,Vin);
% ind(2,3,L);
% vcvs(4,0,3,0,alpha/R3);

% Uncomment for DC part
% Vin_range = linspace(-10, 10, 100);
% for k = 1:length(Vin_range)   
%     b(6) = Vin_range(k);
%     V = G\b;    % DC case
%     Vo(k) = real(V(5));
%     V3(k) = real(V(3));
% end
% subplot(1,2,1), plot(Vin_range,Vo)
% title('Vo')
% subplot(1,2,2), plot(Vin_range,V3)
% title('V3')

% Uncomment for AC part, Q2c
% f = linspace(0,100,100);
% for k = 1:length(f)   
%     A = G + 1j*2*pi*f(k)*C;    %Frequency domain: (G+jwC)V=F -> AV = F
%     V = A\b;
%     Vo(k) = real(V(5));
%     V3(k) = real(V(3));
%     V1(k) = real(V(1));
% end
% subplot(1,2,1) , plot(2*pi*f,mag2db(Vo))
% title('Gain in dB')
% subplot(1,2,2), plot(2*pi*f,Vo)
% title('Vo vs w')

% Uncomment for AC histogram
std = 0.05; w = pi;
range = randn(100,1)*0.05 + Cc;
Vout = sparse(1,length(range));
for i = 1:length(range) 
    C = sparse(n,n); G = sparse(n,n); b = sparse(n,1);
    Ccc = range(i);
    res(1,2,R1); res(2,0,R2); res(3,0,R3);  
    res(4,5,R4); res(5,0,R0); cap(1,2,Ccc);
    vol(1,0,Vin);
    ind(2,3,L);
    vcvs(4,0,3,0,alpha/R3);  
        A = G + 1j*w*C;    %Frequency domain: (G+jwC)V=F -> AV = F
        V = A\b;
        Vout(1,i) = real(V(5));
end
histogram(Vout)
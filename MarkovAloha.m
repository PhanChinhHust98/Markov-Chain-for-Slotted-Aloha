clear;
clc;
n = 10;
lambda = 2;
M = 0:1:150;
throughput = zeros(1,length(M));
G = zeros(1,length(M));
for i = 1:length(M)
    m = M(i);
    bg = 0;
    a = 0;
    %qa = 1-exp(-lambda/m); 
    qa = 0.03;
    qr = qa + 0.002; 
    g = zeros(1,(m+1));
    Psc = zeros(1,(m+1));
    P = Markov(m,lambda);
    P2 = P';
    A = P'-Idv(m);
    state = zeros(m+1,1);
    b = zeros(m+1,1);
    for j = 0:m % so luong backlog thay doi
        g(j+1) = (m-n)*qa + n*qr;
        Psc(j+1) = g(j+1)*exp(-g(j+1));
        bg = bg + g(j+1);
    end
    G(i) = bg/(m+1);
    
     b(m+2,1) = 1; % them gia tri 1 vao vi tri cuoi cung vector b
         for j = 1:(m+1) %the 1 hang = 1
            A(m+2,j) = 1; % them 1 hang 1 vào ma tran A
            A(j,m+2) = 0; % them 1 cot 0
         end
         A2 = inv(A);
            state = A2*b;
            y = sum(state);
         if (1-y) > 10^(-2) % gioi han gia tri lam tron
            state = zeros(m+1,1);
         end
         for j = 1:(m+1)
            a = a + state(j)*Psc(j);
         end
         throughput(i) = a;
end
plot(G,throughput);



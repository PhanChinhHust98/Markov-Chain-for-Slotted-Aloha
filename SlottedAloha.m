clear;
clc;
nCase = 100;
L = 200; % number of timeslots
lambda = 5;
mL=0:0.25:5;% so luong node trong 1 timeslot
throughput = zeros(1, length(mL));
%G = zeros(1, length(mL));
for k = 1: length(mL)
    m = L*mL(k);
    count_tb = 0;
    %mc_tb = 0;
    qa = 1-exp(-lambda/m); % prob of new
    qr = qa + 0.002; % prob of backlog
    for t = 1: nCase %khao sat n truong hop
        count = 0;
        position = zeros(1,m);
        choose = zeros(1,L);  % count number of nodes choose slot x
        for i = 1: m  % m nodes choose random slot
            %if rand() < qa
                x = randi([1,L]); % node i choose timeslot x
                choose(x)= choose(x)+1;
                position(i) = x; 
            %end
        end
         for i = 1:L 
            if choose(i) > 1
                %mc = mc + choose(i);
                for j = 1:m
                    if position(j) == i
                        if i < L
                            if rand()  < qr
                                position(j) = randi([i+1,L]);
                                choose(position(j)) = choose(position(j))+1;
                            end
                        end
                    end
                end
            else
                if choose(i) == 1
                   count = count + 1;
                end
            end
         end
         count = count/L;
         count_tb = count_tb + count;
%          mc = mc/L;
%          mc_tb = mc_tb + mc;
    end
        throughput(k) = count_tb/nCase;
       % G(k) = mc_tb/nCase; 
end
plot(mL, throughput);
xlabel('Transmisstion rate');
ylabel('Thoughput');
legend('Slotted Aloha');



    
    
    
    
   
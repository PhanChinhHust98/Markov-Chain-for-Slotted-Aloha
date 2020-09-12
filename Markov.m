function P = Markov (m,lambda)
P = zeros(m+1,m+1); 
    if m ~= 0
        qa = 1-exp(-lambda/m); 
        qr = qa + 0.002; 
    else
        qa = 0;
        qr = 0;
    end
    for i = 0:m 
        n = i; % so luong backlog node o thoi diem hien tai
        if n >= 1 % so luong backlog ph?i > 0
            if m-n >= 1 % so luong backlog < tong so node
                Qa_0 = (FACTORIAL(m-n)/(FACTORIAL(0)*FACTORIAL(m-n-0)))*((1-qa)^(m-n-0))*(qa^0);
                Qa_1 = (FACTORIAL(m-n)/(FACTORIAL(1)*FACTORIAL(m-n-1)))*((1-qa)^(m-n-1))*(qa^1);
                Qr_0 = (FACTORIAL(n)/(FACTORIAL(0)*FACTORIAL(n-0)))*((1-qr)^(n-0))*(qr^0);
                Qr_1 = (FACTORIAL(n)/(FACTORIAL(1)*FACTORIAL(n-1)))*((1-qr)^(n-1))*(qr^1);
            else % so luong backlog = tong so node
                Qa_0 = 1;
                Qa_1 = 0;
                Qr_0 = (FACTORIAL(n)/(FACTORIAL(0)*FACTORIAL(n-0)))*((1-qr)^(n-0))*(qr^0);
                Qr_1 = (FACTORIAL(n)/(FACTORIAL(1)*FACTORIAL(n-1)))*((1-qr)^(n-1))*(qr^1);
            end
        else
            if n == 0
                Qa_0 = (FACTORIAL(m-n)/(FACTORIAL(0)*FACTORIAL(m-n-0)))*((1-qa)^(m-n-0))*(qa^0);
                Qa_1 = (FACTORIAL(m-n)/(FACTORIAL(1)*FACTORIAL(m-n-1)))*((1-qa)^(m-n-1))*(qa^1);
                %Qr_0 = (1-qr)^(n-0)*qr;
                Qr_0 = 1;
                Qr_1 = 0;
            end
        end
        for j = 0:m % so backlog node o thoi diem tiep theo
             if i == 0 && j == 1
                 P(i+1,j+1) = 0;
             else
                ss = j - i; 
                if (2 <= ss)  && (ss <= (m-n))
                    P(i+1,j+1) = (FACTORIAL(m-n)/(FACTORIAL(ss)*FACTORIAL(m-n-ss)))*((1-qa)^(m-n-ss))*(qa^ss);
                else
                    if ss == 1
                        P(i+1,j+1) = Qa_1*(1 - Qr_0);
                    else
                        if ss == 0
                            P(i+1,j+1) = Qa_1*Qr_0 + Qa_0*(1 - Qr_1);
                        else
                            if ss == -1
                                P(i+1,j+1) = Qa_0*Qr_1;
                            else
                                if ss <= -1 % so luong backlogged node giam nhieu hon 1
                                   P(i+1,j+1) = 0;
                                end
                            end
                        end
                    end
                end
             end
        end       
    end
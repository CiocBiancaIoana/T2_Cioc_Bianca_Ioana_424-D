P = 40; 
D = 8; %nr din lista
N = 50; %nr de coeficienti
w0 = 2*pi/P; %pulsatia semnalului


t_or = 0:0.02:D; %esantionare original
x_or = sawtooth((pi/2)*t_or,0.5)+1; %se cresssaza semnalul triunghiular original

t = 0:0.02:P; %esantionare modificat, pana la perioada P
x = zeros(1,length(t)); 
x(t<=D) = x_or; %aici se testeaza daca t<=D daca da, salveaza val din original, daca nu lasa 0




for k = -N:N 
    x_SFE = x_or; %semnalul dupa formula seriei fourier exponentiale
    x_SFE = x_SFE .* exp(-1i*k*w0*t_or); 
    Coef(k+N+1) = 0;  %vector pentru coeficienti
    for i = 1:length(t_or)-1
        Coef(k+N+1) = Coef(k+N+1) + (t_or(i+1)-t_or(i)) * (x_SFE(i)+x_SFE(i+1))/2; 
    end
end

for i = 1:length(t)
    x_rec(i) = 0; %semnalul reconstruit
    for k=-N:N
        x_rec(i) = x_rec(i) + (1/P) * Coef(k+51) * exp(1i*k*w0*t(i)); 
    end
end


figure(1);
plot(t,x),title('(linie continua) x(t) si reconstruit  folosind N coeficienti (linie punctata)');
hold on;
plot(t,x_rec,'--'); %semnalul reconstruit

figure(2);
w=-50*w0:w0:50*w0;
stem(w/(2*pi),abs(Coef)),title('Spectru  x(t)');


%In primul for am calculat in x_Seria Fourier exponentiala cu formula de la
%curs, Dupa am calculat coeficientii folsind proprietatile Sfe(linia 24) ,dupa pe
%baza acestor coeficienti am reconstruit semnalul;
%

% Laboratório 1 Pratica N Rainhas Computação Evoluciuonária
% João Pedro Samarino
% Pedro Henrique Leão Braga


N = 18 ; % numero de rainhas 
P = 20; % População
R = 5; % Quantidade de Numeros Aleatorios Requerida
Stop = 80000 % Quantidade Maxima de gerações
M = 0.4 % Taxa de Mutação

%inicio aleatorio para as rainhas 
rainhas = zeros(P,N); b_rainhas = zeros(P,N); melhores = zeros(P,N); score=zeros(1,P); score_2=zeros(1,R);cruzamento=zeros(1,P+1); numero = [1 , 1]; z = 0;
for i = 1:P
rainhas(i,:) = randperm(N);
end

%inicializa vetores de impressao com 0
for i = 1:Stop
imprimir_medio(i) = 0;
imprimir_melhor(i) = 0;
end

%modo professor
while numero(1) ~=0 && z <= Stop 
    z= z+1;
    aleatorio=randperm(P);
    
    for j = 1:R %pegar Quantidade de Numeros Aleatorios Requerida
        score_2(j) = fitness_nq(rainhas(aleatorio(j),:)); %verifica a quantidade de xeques nos aleatorios
    end
    
    [~,indice] = sort(score_2); %obtem os indices dos melhores
    
    buffer  = CutAndCrossfill_Crossover([rainhas(aleatorio(indice(1)),:);rainhas(aleatorio(indice(2)),:)]); % cruza os dois melhores
    
    for j = 1:length(rainhas)
        score(j) = fitness_nq(rainhas(j,:)); %verifica a quantidade de xeques no dominio
    end
    
    [numero,indice] = sort(score); %obtem os indices dos melhores
   
    imprimir_medio(z) = mean(numero); %calcula a media dos cheques da População e adiciona ao vetor para imprimir posterioemente
    imprimir_melhor(z) = numero(1); %Seleciona o menor numero de Xeques da População e adiciona ao vetor para imprimir posterioemente
    
    % coloca os 2 novos no lugar dos dois piores
    rainhas(indice(length(rainhas)),:) = buffer(1,:);
    rainhas(indice(length(rainhas)-1),:) = buffer(2,:);
        
    aleatorio=randperm(P);
    
    %Realiza a mutação na taxa especificada da população(M) 
    for j = 1:floor(M*P)
    mutacao = randperm(N);
    b = rainhas(aleatorio(j),mutacao(1));
    rainhas(aleatorio(j),mutacao(1)) = rainhas(aleatorio(j),mutacao(2));
    rainhas(aleatorio(j),mutacao(2)) = b;
    end      
end

plot((1:z),imprimir_medio(1:z),'*r',(1:z),imprimir_melhor(1:z),'*b');
title(strcat(int2str(N),' Rainhas',{'  '},'Taxa de Mutação',{' '}, int2str(100*M),'%',{'  '},'População',{' '}, int2str(P)));
xlabel('Gerações');
ylabel('Numero de Xeques');
legend('População Média','Melhor Individuo');

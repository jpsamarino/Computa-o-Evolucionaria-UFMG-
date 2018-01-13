function [makespan, sequence, avg_fit, best_fit] = JSSP1 (input) %'entrada_25.txt'

entrada = load(input); % se espera uma matriz [10,6,1,5,9,7,2,8,3,4;]

N =  size(entrada,1); %tamanho do problema
P = 20; % população por geração
F = 2*P; % população total
melhor = ones(3000,1);
media = ones(3000,1);
solucoes = zeros(F,N);
score = ones(length(solucoes),1);
score_2 = ones(5,1);

for i = 1:F
solucoes(i,:) = randperm(N);
end


for z = 1:3000
    
    aleatorio=randperm(P);
    
    %separa os pais por logica de torneio
    for j = 1:5 %pegar 5 aleatorios
        score_2(j) = fitness(entrada(solucoes(aleatorio(j),:),:)); 
    end
    
    [~,indice] = sort(score_2); %obtem os indices dos melhores
    
    [filho_1 , filho_2]  = cruza(solucoes(aleatorio(indice(1)),:),solucoes(aleatorio(indice(2)),:)); % cruza os dois melhores
    
    for j = 1:length(solucoes)
        score(j) = fitness(entrada(solucoes(j,:),:)); 
    end
    
    [numero,indice] = sort(score); %obtem os indices dos melhores
    
    % coloca os 2 novos no lugar dos dois piores
    solucoes(indice(length(solucoes)),:) = filho_1;
    solucoes(indice(length(solucoes)-1),:) = filho_2;
    m = solucoes(indice(1),:);
    melhor(z) = numero(1);
    media(z) = mean(numero);
    
    %faz multaçao bit-flip
    aleatorio=randperm(P);
    
    for j = 1:floor(0.4*P)
    multacao = randperm(N);
    b = solucoes(aleatorio(j),multacao(1));
    solucoes(aleatorio(j),multacao(1)) = solucoes(aleatorio(j),multacao(2));
    solucoes(aleatorio(j),multacao(2)) = b;
    end
   solucoes(1,:) = m;
end

makespan = numero(1);
sequence = m;
avg_fit = media(2:z);
best_fit = melhor(2:z);

end
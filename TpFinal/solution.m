clear all
entrada = load('entrada_10.txt'); % se espera  [10,6,1,5,9,7,2,8,3,4;]

N =  size(entrada,1); %tamanho do problema
P = 10; % população por geração
F = 2*P; % Quantidade total vetor filhos+ pop

solucoes = zeros(F,N); 

for i = 1:F
solucoes(i,:) = randperm(N);
end
solucoes(i,:) = [10,6,4,5,7,1,3,8,2,9;];
m = solucoes(1,:);
for z = 1:300
    
    aleatorio=randperm(P);
    
    
    
    for i = 1:2:P %gera P filhos
        
        %separa os pais por logica de torneio
        for j = 1:5 %pegar 5 aleatorios
            score_2(j) = fitness(entrada(solucoes(aleatorio(j),:),:)); 
        end

        [~,indice] = sort(score_2); %obtem os indices dos melhores

        [filho_1 , filho_2]  = cruza(solucoes(aleatorio(indice(1)),:),solucoes(aleatorio(indice(2)),:)); % cruza os dois melhores
        
        solucoes(P+i,:) = filho_1; %guarda os filhos
        solucoes(P+i+1,:) = filho_2;
        
    end
    
    
    %faz multaçao bit-flip nos filhos
    for w = 1:20
    aleatorio=randperm(F);
    for j = 1:floor(0.08*F)
    multacao = randperm(N);
    b = solucoes(aleatorio(j),multacao(1));
    solucoes(aleatorio(j),multacao(1)) = solucoes(aleatorio(j),multacao(2));
    solucoes(aleatorio(j),multacao(2)) = b;
    end
    end
    
    
    %seleção dos sobreviventes
    solucoes(i,:) = m;
    
    for j = 1:F %avalia tds
        score(j) = fitness(entrada(solucoes(j,:),:)); 
    end
    
    [numero,indice] = sort(score); %obtem os indices dos melhores
    m = solucoes(indice(1),:); %eletismo
   
    for i = 1:P
        if(score(i)>score(i+P))
            solucoes(i,:) = solucoes(i+P,:);
        end
    end
    
    melhor(z) = numero(1);
    media(z) = mean(numero);
    vari(z) = std(numero);
    
    
   
end
figure;
plot(media)
figure;
plot(melhor)
figure;
plot(vari)

%mostra a respota certa
% for i = 1:3628800
% m(i) =  fitness(entrada(teste(i,:),:));
% end
% min(m)
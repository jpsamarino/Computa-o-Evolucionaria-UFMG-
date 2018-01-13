function [makespan, sequence, avg_fit, best_fit] = JSSP (input) %'entrada_25.txt'

entrada = load(input); % se espera  [10,6,1,5,9,7,2,8,3,4;] para 10

N =  size(entrada,1); %tamanho do problema
P = 50; % população por geração
F = 2*P; % Quantidade total vetor filhos+ pop
solucoes = zeros(F,N); 
score = zeros(F,1);
melhor = ones(2000,1);
media = ones(2000,1);
z = 1;cont =0;

for i = 1:F
solucoes(i,:) = randperm(N);
end
m = solucoes(1,:);

while cont<1000
    
    aleatorio1=randperm(P);
    aleatorio2=randperm(P);
       
    for i = 1:2:P %gera P filhos de pais aleatorios
        
        [filho_1 , filho_2]  = cruza(solucoes(aleatorio1(i),:),solucoes(aleatorio2(i),:)); % cruza os dois melhores
        
        solucoes(P+i,:) = filho_1; %guarda os filhos
        solucoes(P+i+1,:) = filho_2;
        
    end
    
    
    %faz multaçao bit-flip nos filhos
    for w = 1:(12)
    aleatorio=randperm(F);
    for j = 1:floor((0.085)*F)
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
    
    [numero,indice] = min(score); %obtem os indices dos melhores
    
    m = solucoes(indice,:); %eletismo
   
    for i = 1:P
        if(score(i)>score(i+P))
            solucoes(i,:) = solucoes(i+P,:);
        end
    end
    
    z=z+1;
    melhor(z) = numero(1);
    media(z) = mean(score);
    if(melhor(z)== melhor(z-1))
        cont = cont+1;
    else
        cont = 0;
    end
    
end

makespan = numero(1);
sequence = m;
avg_fit = media(2:z);
best_fit = melhor(2:z);

end


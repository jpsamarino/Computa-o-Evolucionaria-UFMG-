% Laboratório 2 Pratica Problema da Mochila Computação Evoluciuonária
% João Pedro Samarino
% Pedro Henrique Leão Braga

pc = 0.6; %probabilidade de cross over;
pm = 0.2; %probabilidade mutação
pop = 20 ; % população
C = 35 ; % capacidade mochila 
N = 8; % numero de objetos
P = [10 18 12 14 13 11 8 6]; %vetor de pesos
V = [5 8 7 6 9 5 4 3];% Vetor de Valores;

solutiom  = zeros(pop,N);
solution_b = solutiom;

a = 0 ; b = 0; numero = 0; indice=0; %buffers
z = 0; %numero de geraçoes 

%inicializa vetores de impressao com 0
for i = 1:10000
imprimir_medio(i) = 0;
imprimir_melhor(i) = 0;
end

%inicio aleatorio 

for i = 1:pop
    a = (N/3)./randperm(N);
    a(a>1) = 1;
    a(a<1) = 0; 
    solutiom(i,:) = a;
end


while z < 1000
    
    z=z+1;
    
    %avalia as soluçoes----------------------------------------------------
    for j = 1:length(solutiom)
        score(j) = fitness_ksp(solutiom(j,:),V,P,C); %ve o quao boa é a solução
    end
    
    %cruzamento------------------------------------------------------------
    
    j = 1;
    while j < pop
        
        pai_1 = solutiom(roleta(score),:); % utiliza o metodo da roleta seleção dos pais
        pai_2 = solutiom(roleta(score),:);
        
        if (rand())<pc %probabilidade de realizar cross over
            corte = ceil(N*rand()); % ponto de corte randomico
            solution_b(j,:) = [ pai_1(1:corte) pai_2(corte+1:end)];
            j=j+1;
            solution_b(j,:) = [ pai_2(1:corte) pai_1(corte+1:end)];
            j=j+1;
            
        else
            solution_b(j,:) = pai_1;
            j=j+1;
            solution_b(j,:) = pai_2;
            j=j+1;
              
        end
    end
    
    %mutação--------------------------------------------------------------
    for i =  1:size(solution_b,1) %percorre linha
        for j = 1:size(solution_b,2)% percorre coluna
             if (rand())<pm %probabilidade de realizar bit flip
                 solution_b(i,j) = not(solution_b(i,j)); %realiza o bit flip
             end
        end
    end
    
   %selecao_soreviventes---------------------------------------------------
   
   solutiom = solution_b; % todos os pais são substituidos
   
   %para_fazer_graficos----------------------------------------------------
   
    [numero,indice] = sort(score,'descend'); %obtem os indices dos melhores
   
    imprimir_medio(z) = mean(numero); 
    imprimir_melhor(z) = numero(1); 
   
   
end

%para testar solução sum(solutiom(2,:).*P)
plot((1:z),imprimir_medio(1:z),'*r',(1:z),imprimir_melhor(1:z),'*b');


title(strcat('Problema da Mochila',{'  '},'Probabilidade Mutação',{' '}, int2str(100*pm),'%',{'  '},'Probabilidade de Cross Over',{' '}, int2str(100*pc),'%'));
xlabel('Gerações');
ylabel('Soma dos Valores'); 
legend('População Média','Melhor Individuo','Location','southeast','Orientation','vertical');
grid on; 

%scrip teste
% for i = 1 :10000
% teste_1(i) =  roleta(score);
% end
% hist(teste_1);


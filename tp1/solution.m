N = 4 ; % nomero de rainhas 
P = 10; % população por geração
F = 20; % Quantidade de filhos

%inicio aleatorio para as rainhas 
rainhas = zeros(F,N); b_rainhas = zeros(F,N); melhores = zeros(P,N); score=zeros(1,F); score_2=zeros(1,5);cruzamento=zeros(1,F+1); numero = [1 , 1]; z = 0;
for i = 1:F
rainhas(i,:) = randperm(N);
end
%modo professor
while numero(1) ~=0
    
    aleatorio=randperm(P);
    
    for j = 1:5 %pegar 5 aleatorios
        score_2(j) = fitness_nq(rainhas(aleatorio(j),:)); %verifica a quantidade de xeques nos aleatorios
    end
    
    [~,indice] = sort(score_2); %obtem os indices dos melhores
    
    buffer  = CutAndCrossfill_Crossover([rainhas(aleatorio(indice(1)),:);rainhas(aleatorio(indice(2)),:)]); % cruza os dois melhores
    
    for j = 1:length(rainhas)
        score(j) = fitness_nq(rainhas(j,:)); %verifica a quantidade de xeques no dominio
    end
    
    [numero,indice] = sort(score); %obtem os indices dos melhores
    
    % coloca os 2 novos no lugar dos dois piores
    rainhas(indice(length(rainhas)),:) = buffer(1,:);
    rainhas(indice(length(rainhas)-1),:) = buffer(2,:);
    
    %faz multaçao em 0.8 do sistema
    
    aleatorio=randperm(P);
    
    for j = 1:floor(0.4*P)
    multacao = randperm(N);
    b = rainhas(aleatorio(j),multacao(1));
    rainhas(aleatorio(j),multacao(1)) = rainhas(aleatorio(j),multacao(2));
    rainhas(aleatorio(j),multacao(2)) = b;
    end
   
end

%meu modo 
% while numero(1) ~=0
% z = z+1;
% rainha = b_rainhas;
% for j = 1:length(rainhas)
% score(j) = fitness_nq(rainhas(j,:)); %verifica a quantidade de xeques
% end
% 
% [numero,indice] = sort(score); %obtem os indices dos melhores
% 
% %cruzamento aleatorio entre os P melhores e sem perder filhos, os demais sao inrelevantes
% for j = 1:(P):F
% cruzamento(j:(P+j-1)) = randperm(P);   
% end
% cruzamento(F+1) = indice(1);
% 
% %chama a função para o cruzamento
% for j=1:F
%    b_rainhas((j:(j+1)),:) = CutAndCrossfill_Crossover([rainhas((indice(cruzamento(j))),:);rainhas((indice(cruzamento(j+1))),:)]);
% end
% 
% disp( sprintf( 'teste %d ',z ) );
% end


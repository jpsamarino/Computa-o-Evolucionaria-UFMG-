function [filho_1 filho_2] = cruza(pai_1,pai_2)

%inicializa as variaveis
corte = floor(1+length(pai_1)*rand());
filho_1 = pai_2; filho_2 = pai_1; 
buffer_1 = pai_1(1:corte); buffer_2 = pai_2(1:corte);


%retira os itens repitidos
for i= 1:corte
filho_1 = filho_1(filho_1~=buffer_1(i));
filho_2 = filho_2(filho_2~=buffer_2(i));
end

%faz o cruzamento final

 filho_1 = [buffer_1 filho_1];
 filho_2 = [buffer_2 filho_2];

end
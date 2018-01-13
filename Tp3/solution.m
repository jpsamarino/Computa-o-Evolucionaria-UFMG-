%feito por :João Pedro Samarino; Pedro Henrique Leão Braga
% Problema 1 ----- peak
x = normrnd(0,3,30,2);
x_proximo = x;
F = 0.3;
c = 0.2;
precisao = 1e-12;
i = 0;
while (var(x(:,1))>precisao) && (var(x(:,2))>precisao) 
    
    i=i+1;
    for j = 1:size(x,1)
        indice = randperm(size(x,1));
        x_proximo(j,:)=x(indice(1),:)+F*(x(indice(2),:)-x(indice(3),:));
        
        for k = 1:size(x,2)
          if  rand()<c
            x_proximo(j,k) =  x(j,k);  
          end
        end
        
        if peaks (x(j,:), 0) < peaks (x_proximo(j,:), 0)  %avalia na função e fica com os melhoress  
        x_proximo(j,:) = x(j,:);
        end   
    end
    x = x_proximo;

end
disp('numero de interações');
disp(i);
disp('--Valores de X--para rastrigin')
disp(x(1,:));

% Problema 2 ----- rastrigin

x = normrnd(0,3,30,2);
x_proximo = x;
F = 0.3;
c = 0.2;
precisao = 1e-14;
i = 0;
while (var(x(:,1))>precisao) && (var(x(:,2))>precisao) 
    
    i=i+1;
    for j = 1:size(x,1)
        indice = randperm(size(x,1));
        x_proximo(j,:)=x(indice(1),:)+F*(x(indice(2),:)-x(indice(3),:));%gera v
        
        for k = 1:size(x,2)
          if  rand()<c
            x_proximo(j,k) =  x(j,k);  %faz a multação
          end
        end
        
        if rastrigin (x(j,:), 0) < rastrigin (x_proximo(j,:), 0)  %avalia na função e fica com os melhoress  
        x_proximo(j,:) = x(j,:);
        end   
    end
    x = x_proximo;

end
disp('numero de interações');
disp(i);
disp('--Valores de X--para rastrigin')
disp(x(1,:));

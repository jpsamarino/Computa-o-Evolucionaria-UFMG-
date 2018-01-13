function [F] = fitness(entrada)
    
buffer = zeros(1,size(entrada,2));
for i = 1:size(entrada,2)
    buffer(i) = sum(entrada(1,1:i));
end

for j = 2:size(entrada,1) %começa da segunda linha
    
    buffer(1) = buffer(1)+entrada(j,1);
    
    for i = 2:size(entrada,2)
        if(buffer(i)>buffer(i-1))
            buffer(i) = (entrada(j,i)+buffer(i));
        else
            buffer(i) = (entrada(j,i)+buffer(i-1));
        end
        
    end
    
end

F = buffer(end);
end
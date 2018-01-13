
function [indice_pai]=roleta(score)

   %metodo da roleta matematico
    
    aleatorio = rand; 
   
    b_score = score.^8; % aumenta a presão seletiva o correto seria:  b_score = score; 
    
    
    if(min(score)<0)
        b_score = score-min(score)*1.01; % permite não zerar a probabilidade do pior 
    end
    
        b_score = b_score./sum(b_score);
       
    for j = 1:length(score)
        
        if(aleatorio<b_score(j))
        indice_pai = j;
        break;
        end
        
        b_score(j+1) = b_score(j)+ b_score(j+1);
        
    end

end



% function [indice_pai]=roleta(score)
% 
%    %metodo da roleta matematico
%     aleatorio = rand; 
%     b_score = score;
%     
%     if(min(score)<0)
%         b_score = score-min(score)*1.01; % permite não zerar a probabilidade do pior 
%     end
%     
%         b_score = b_score./sum(b_score);
%         
%         
%     for j = 1:length(score)
%         
%         if(aleatorio<b_score(j))
%         indice_pai = j;
%         break;
%         end
%         
%         b_score(j+1) = b_score(j)+ b_score(j+1);
%         
%     end
% 
% end

function [max_v, b] = WeWinMagic(board, depth, color, alpha, beta, anfangstiefe)

maxDepth = anfangstiefe;
max_value = alpha;
moves_list = [];
b = board;
firstFlag = 0;

for i = 1:8
    for k = 1:8
        b_neu = apply_move(board, color, [i, k]);

        if ~isempty(b_neu)
            if firstFlag == 0
                moves_list = [i, k];
                b = apply_move(board, color, moves_list);
                firstFlag = 1;
            else 
                moves_list = [moves_list; [i, k]];
            end
        end
    end
end

num_moves = size(moves_list, 1);

if (depth == 0 || num_moves == 0)                     
        max_v = evaluation(board, color, moves_list);             
else                                                  

   while (num_moves)
    
    new_board = apply_move(board, color, moves_list(num_moves,:));                                        % muss noch geschrieben werden
    
    value = min (-color, depth-1, new_board, max_value, beta, maxDepth);

        if (value > max_value)
            max_value = value;    
            if (max_value >= beta)
               break; 
            end
            
            if (depth == maxDepth)
                b = apply_move(board, color, moves_list(num_moves,:));
            end
        end
    
   num_moves = num_moves - 1;
   
   end
   max_v = max_value;
end
        
end

function [min_v]  = min(color, depth, board, alpha, beta, anfangstiefe)

maxDepth = anfangstiefe;
min_value = beta;
moves_list = [];
firstFlag = 0;

for i = 1:8
    for k = 1:8
        b_neu = apply_move(board, color, [i, k]);
        
        if ~isempty(b_neu)
            if firstFlag == 0
                moves_list = [i, k];
                b = apply_move(board, color, moves_list);
                firstFlag = 1;
            else 
                moves_list = [moves_list; [i, k]];
            end
        end
    end
end

num_moves = size(moves_list, 1);

if (depth == 0 || num_moves == 0)                     
        min_v = evaluation(board, color, moves_list); 
else
    while (num_moves)
    
        new_board = apply_move(board, color, moves_list(num_moves,:));
        
        [value, someBoard] = WeWinMagic(new_board, depth-1, -color, alpha, min_value, maxDepth);
             
        if (value < min_value)
            min_value = value;
            if (min_value <= alpha)
                break;
            end
        end
        
        num_moves = num_moves - 1;
    end
    
    min_v = min_value;
end
    
     
end




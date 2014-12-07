
function [max_v, b] = WeWinMagic(board, depth, color, alpha, beta, anfangstiefe)

maxDepth = anfangstiefe;
max_value = alpha;


[ moves_list, boards ] = get_valid_moves(board, color);

num_moves = size(moves_list, 1);

if (depth == 0 || num_moves == 0)      
    b = board;
    max_v = evaluation(board, color, moves_list);             
else                                                  

   for k = 1:num_moves
    
    new_board = boards{k};
    value = min (-color, depth-1, new_board, max_value, beta, maxDepth);

        if (value > max_value)
            max_value = value;   
            if (max_value >= beta)
               break; 
            end
            
            if (depth == maxDepth)
                b = new_board;
            end
        end
   end
   max_v = max_value;
end
        
end

function [min_v]  = min(color, depth, board, alpha, beta, anfangstiefe)

maxDepth = anfangstiefe;
min_value = beta;

[ moves_list, boards ] = get_valid_moves(board, color);

num_moves = size(moves_list, 1);

if (depth == 0 || num_moves == 0)                     
        min_v = evaluation(board, color, moves_list); 
else
    
    for k = 1:num_moves
        new_board = boards{k};
        
        value = WeWinMagic(new_board, depth-1, -color, alpha, min_value, maxDepth);
             
        if (value < min_value)
            min_value = value;
            if (min_value <= alpha)
                break;
            end
        end
    end
    
    min_v = min_value;
end
    
     
end




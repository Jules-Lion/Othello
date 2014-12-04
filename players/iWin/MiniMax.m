
function [max_v, b] = MiniMax(board, depth, color)

max_value = 0;
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
    
    value = min (-color, depth-1, new_board);

        if (value > max_value)
            max_value = value;                             
            best_move_max = moves_list(num_moves,:);           
        end
    
   num_moves = num_moves - 1;
   
   end
   max_v = max_value;
end
        
end

function [min_v]  = min(color, depth, board)

min_value = 1000000;
moves_list = [];
firstFlag = 0;

for i = 1:8
    for k = 1:8
        b_neu = apply_move(board, color, [i, k]);
        
        if ~isempty(b_neu)
            if firstFlag == 0
                moves_list = [i, k];
                best_move_max = [i,k];
                b = apply_move(board, color, best_move_max);
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
    while (num_moves)
    
        new_board = apply_move(board, color, moves_list(num_moves,:));
        
        [value, best_move_max] = MiniMax(new_board, depth-1, -color);
             
        if (value < min_value)
            min_value = value;                          
            best_move_max = moves_list(num_moves,:);        
        end
        
        num_moves = num_moves - 1;
    end
    
    min_v = min_value;
end
    
     
end




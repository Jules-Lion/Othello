
function [max_v, b] = WeWinMagic(board, depth, color, alpha, beta, anfangstiefe)

if depth <= 0
    b = board;
    max_v = evaluation(board, color);
    return
end

maxDepth = anfangstiefe;
max_value = alpha;


% % hier die Nuller pruefen number of non zero elements in matrix
% if (nnz(board)<10)
%     
%     b = get_first_boards(board);
%     max_v=0;
% 
% else

[ moves_list, boards ] = get_valid_moves(board, color);

num_moves = size(moves_list, 1);
% TESTING
% if (depth == maxDepth)
%    if (num_moves <= 1)
%        depth = depth + 1;
%        maxDepth = maxDepth + 2;
%    elseif (num_moves <= 5)
%        depth = depth + 1;
%        maxDepth = maxDepth + 1;
%    elseif (num_moves <= 10)
%         maxDepth = maxDepth - 1;
%    else 
%        depth = depth - 3;
%        maxDepth = maxDepth - 3;
%    end
% end
% TESTING


if num_moves == 0
    % kein gueltiger Zug, suche mit unveraenderten board weiter
    b = board;
    max_v = min(-color, depth-1, board, max_value, beta, maxDepth);
else
    for k = 1:num_moves
        
        new_board = boards{k};
        value = min(-color, depth-1, new_board, max_value, beta, maxDepth);
        
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

if depth <= 0
    min_v = evaluation(board, color);
    return
end
    
maxDepth = anfangstiefe;
min_value = beta;

[ moves_list, boards ] = get_valid_moves(board, color);

num_moves = size(moves_list, 1);

if num_moves == 0
    min_v = WeWinMagic(board, depth-1, -color, alpha, min_value, maxDepth);
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




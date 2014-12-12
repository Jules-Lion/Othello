
function b = iWin(board, color, time)
    addpath(['players' filesep 'iWin']);

    tokensPlayed = nnz(board);
    
 if (tokensPlayed<8)
    b = get_first_boards(board);
    
 elseif (tokensPlayed<20)
     if (time <= 15) 
        depth = 2;
    elseif (time <= 30)
        depth = 5;
    elseif (time <= 60)
        depth = 5;
    elseif (time <= 168) 
        depth = 5;
    elseif (time <= 180)
        depth = 5;
    end
    
    disp([depth]);
    [val, b] = WeWinMagic(board, depth, color, -inf, inf, depth);
 else
    
    if (time <= 15) 
        depth = 2;
    elseif (time <= 30)
        depth = 4;
    elseif (time <= 60)
        depth = 5;
    elseif (time <= 130) 
        depth = 4;
    elseif (time <= 180)
        depth = 5;
%         if (mod(tokensPlayed,2) == 0)
%         depth = depth - 1;
%         end
    end
 
    disp([depth]);
    [val, b] = WeWinMagic(board, depth, color, -inf, inf, depth);

end
    
end
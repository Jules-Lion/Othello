
function b = iWin(board, color, time)
    addpath(['players' filesep 'iWin']);

 if (nnz(board)<10)
    disp('11111111111111')
    b = get_first_boards(board);
    
 else

    disp([time]);
    
    if (time <= 15) 
        depth = 2;
    elseif (time <= 30)
        depth = 3;
    elseif (time <= 60)
        depth = 4;
    elseif (time <= 120) 
        depth = 5;
    elseif (time <= 180)
        depth = 6;
    end
            
    [val, b] = WeWinMagic(board, depth, color, -inf, inf, depth);

end
    
end
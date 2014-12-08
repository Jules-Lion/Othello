
function b = iWin(board, color, time)
    addpath(['players' filesep 'iWin']);

    disp([time]);
    
    if (time <= 15) 
        depth = 4;
    elseif (time <= 30)
        depth = 4;
    elseif (time <= 60)
        depth = 5;
    elseif (time <= 150) 
        depth = 5;
    elseif (time <= 180)
        depth = 5;
    end
            
    [val, b] = WeWinMagic(board, depth, color, -inf, inf, depth);

end
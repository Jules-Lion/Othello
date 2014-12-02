function b = MiniMaxPlayer(b,color,t)
    addpath(['players' filesep 'iWin']);
    [val, b] = MiniMax(b, 4, color);
end
function score = evaluation(board, color, moves_list)

%% Initialize valueTable
    valueTable = [  99,  -8,  8,  6,  6,  8,  -8, 99;
                    -8, -24, -4, -3, -3, -4, -24, -8;
                     8,  -4,  7,  4,  4,  7,  -4,  8;
                     6,  -3,  4,  0,  0,  4,  -3,  6;
                     6,  -3,  4,  0,  0,  4,  -3,  6;
                     8,  -4,  7,  4,  4,  7,  -4,  8;
                    -8, -24, -4, -3, -3, -4, -24, -8;
                    99,  -8,  8,  6,  6,  8,  -8, 99];
    
    %Richtungen definieren
    Rx = [-1, -1, 0, 1, 1, 1, 0, -1];
    Ry = [0, 1, 1, 1, 0, -1, -1, -1];
    value = 0;
    eigSteine = 0;
    gegSteine = 0;
    eigRandSteine = 0;
    gegRandSteine = 0;

%% Final evaluation

	for i=1:8
        for j=1:8
            if (board(i,j) == color)
                value = value + valueTable(i,j);
                eigSteine = eigSteine + 1;
            elseif (board(i,j) == -color)
                value = value - valueTable(i,j);
                gegSteine = gegSteine +1;
            end 
            
            if (board(i,j) ~= 0)  % stabilitätskriterium sind die randsteine.
                for k=1:8
                    x = i + Rx(k);
                    y = j + Ry(k);
                    if ((x >= 1) && (x <= 8) && (y >= 1) && (y <= 8) && (board(x,y)==0))
                        if (board(i,j) == color)
                            eigRandSteine = eigRandSteine +1;
                        else
                            gegRandSteine = gegRandSteine +1;
                        
                        end % if (board(i,j) == color)
                        break;
                    end % if
                end % for k=1:8
            end % if (board(i,j) ~= 0)
        end % for j=1:8
    end %for i=1:8
 
    % Steindifferenz berechnen
    if(eigSteine > gegSteine)
		piece_diff = (100.0 * eigSteine)/(eigSteine + gegSteine);
    elseif(eigSteine < gegSteine)
		piece_diff = -(100.0 * gegSteine)/(eigSteine + gegSteine);
	else piece_diff = 0;
    end % if (eigSteine > gegSteine)

    % Randsteine berechnen
	if(eigRandSteine > gegRandSteine)
		rand_Steine = -(100.0 * eigRandSteine)/(eigRandSteine + gegRandSteine);
    elseif(eigRandSteine < gegRandSteine)
		rand_Steine = (100.0 * gegRandSteine)/(eigRandSteine + gegRandSteine);
    else
        rand_Steine = 0;
    end % if (eigRandSteine > gegRandSteine)
    
    % Eckfelder berechnen
    eigSteine = 0;
    gegSteine = 0;
	if(board(1,1) == color) 
        eigSteine = eigSteine +1;
    elseif(board(1,1) == -color) 
        gegSteine = gegSteine+1;
    end
	if(board(1,8) == color) 
        eigSteine = eigSteine+1;
    elseif(board(1,8) == -color) 
        gegSteine = gegSteine+1;
    end
	if(board(8,1) == color) 
        eigSteine = eigSteine+1;
    elseif(board(8,1) == +color) 
        gegSteine = gegSteine+1;
    end
	if(board(8,8) == color) 
        eigSteine = eigSteine+1;
    elseif(board(8,8) == -color) 
        gegSteine = gegSteine+1;
    end
    
	corners = 25 * (eigSteine - gegSteine);

    % corner closeness
	eigSteine = 0;
    gegSteine = 0;
    
	if(board(1,1) == 0)
		if(board(1,2) == color) 
            eigSteine = eigSteine+1;
        elseif(board(1,2) == -color) 
            gegSteine = gegSteine+1;
        end % if(board(1,2) == color) 
		if(board(2,2) == color) 
            eigSteine = eigSteine+1;
        elseif(board(2,2) == -color) 
            gegSteine = gegSteine+1;
        end % if(board(2,2) == color) 
		if(board(2,1) == color) 
            eigSteine = eigSteine+1;
        elseif(board(2,1) == -color) 
            gegSteine = gegSteine+1;
        end %if(board(2,1) == color)
    end % if (board(1,1) == 0)
    
    if(board(1,8) == 0)
		if(board(1,7) == color) 
            eigSteine = eigSteine+1;
        elseif(board(1,7) == -color) 
            gegSteine = gegSteine+1;
        end % if(board(1,7) == color) 
		if(board(2,7) == color) 
            eigSteine = eigSteine+1;
        elseif(board(2,7) == -color) 
            gegSteine = gegSteine+1;
        end % if(board(2,7) == color) 
		if(board(2,8) == color) 
            eigSteine = eigSteine+1;
        elseif(board(2,8) == -color) 
            gegSteine = gegSteine+1;
        end %if(board(2,8) == color)
    end % if (board(1,8) == 0)
    
    if(board(8,1) == 0)
		if(board(8,2) == color) 
            eigSteine = eigSteine+1;
        elseif(board(8,2) == -color) 
            gegSteine = gegSteine+1;
        end % if(board(8,2) == color) 
		if(board(7,2) == color) 
            eigSteine = eigSteine+1;
        elseif(board(7,2) == -color) 
            gegSteine = gegSteine+1;
        end % if(board(7,2) == color) 
		if(board(7,1) == color) 
            eigSteine = eigSteine+1;
        elseif(board(7,1) == -color) 
            gegSteine = gegSteine+1;
        end %if(board(7,1) == color)
    end % if (board(8,1) == 0)

    if(board(8,8) == 0)
		if(board(7,8) == color) 
            eigSteine = eigSteine+1;
        elseif(board(7,8) == -color) 
            gegSteine = gegSteine+1;
        end % if(board(8,8) == color) 
		if(board(7,7) == color) 
            eigSteine = eigSteine+1;
        elseif(board(7,7) == -color) 
            gegSteine = gegSteine+1;
        end % if(board(7,7) == color) 
		if(board(8,7) == color) 
            eigSteine = eigSteine+1;
        elseif(board(8,7) == -color) 
            gegSteine = gegSteine+1;
        end %if(board(8,7) == color)
    end % if (board(8,8) == 0)    
    
	closeness = -12.5 * (eigSteine - gegSteine);

%     % Mobilitaet berechnen
% 	eigSteine = num_valid_moves(my_color, opp_color, board);
% 	gegSteine = num_valid_moves(opp_color, my_color, board);
% 	if(eigSteine > gegSteine)
% 		mobility = (100.0 * eigSteine)/(eigSteine + gegSteine);
%     elseif(eigSteine < gegSteine)
% 		mobility = -(100.0 * gegSteine)/(eigSteine + gegSteine);
%     else
%         moblity = 0;
%     end % if(eigSteine > gegSteine)
mobility = 0;
    
    score = (10 * piece_diff) + (801.724 * corners) + (382.026 * closeness) + (78.922 * mobility)  + (74.396 * rand_Steine) + (10 * value);
end

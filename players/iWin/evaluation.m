function score = evaluation(board, color)

%% Initialize valueTable
    valueTable =       [   20, -3, 11,  8,  8, 11, -3, 20;
                           -3, -7, -4,  1,  1, -4, -7, -3;
                           11, -4,  2,  2,  2,  2, -4, 11;
                            8,  1,  2, -3, -3,  2,  1,  8;
                            8,  1,  2, -3, -3,  2,  1,  8;
                           11, -4,  2,  2,  2,  2, -4, 11;
                           -3, -7, -4,  1,  1, -4, -7, -3;
                           20, -3, 11,  8,  8, 11, -3, 20];



                
                
    %Richtungen definieren
    Rx = [-1, -1, 0, 1, 1, 1, 0, -1];
    Ry = [0, 1, 1, 1, 0, -1, -1, -1];
    value = 0;
    eigSteine = 0;
    gegSteine = 0;
    eigFrontSteine = 0;
    gegFrontSteine = 0;
    eigFreieFrontFelder = 0;
    gegFreieFrontFelder = 0;


    % Statische Bewertung des Boards: einzelne felder werden statisch
    % gewichtet. Zb sind eckfelder wertvoll, felder die an eckfelder
    % angrenzen sind schlecht. Weiterhin wird hier die anzahl der
    % eingenommenen steine bewertet. Viele steine sind gut, greedy ansatz.
    % Beide evaluationsmethoden werden nur schwach bewertet.
	for i=1:8
        for j=1:8
            if (board(i,j) == color)
                value = value + valueTable(i,j);
                eigSteine = eigSteine + 1;
            elseif (board(i,j) == -color)
                value = value - valueTable(i,j);
                gegSteine = gegSteine +1;
            end 
            
    % Mobilität: berechnung der anzahl an frontier stones vom spieler und
    % gegenspieler, sowie aufsummierung der anzahl an freien feldern neben 
    % ebendiesen frontier stones.
            if (board(i,j) ~= 0)
                eigFreiesFeldFlag = 1; % die flags werden genutzt damit wir
                gegFreiesFeldFlag = 1; % nur einmal einen Frontstone zählen
                for k=1:8
                    x = i + Rx(k);
                    y = j + Ry(k);
                    
                    if ((x >= 1) && (x <= 8) && (y >= 1) && (y <= 8) && (board(x,y)==0))
                        
                        % folgende zwei if statements zählen nur die anzahl
                        % der frontsteine und müssen daher nicht in alle
                        % Richtungen aufaddiert werden
                        if (eigFreiesFeldFlag == 1 && board(i,j) == color)
                            eigFrontSteine = eigFrontSteine + 1;
                            eigFreiesFeldFlag = 0;
                        end % if (eigFreiesFeldFlag == 1)
                        
                        if (gegFreiesFeldFlag == 1 && board(i,j) ~= color)
                            gegFrontSteine = gegFrontSteine + 1;
                            gegFreiesFeldFlag = 0;
                        end % if (gegFreiesFeldFlag == 1)
                        
                        % folgende statements zählen die anzahl an freien
                        % felder um einen frontstein in allen 8 richtungen
                        if (board(i,j) == color)
                            eigFreieFrontFelder = eigFreieFrontFelder + 1;
                            
                        else
                            gegFreieFrontFelder = gegFreieFrontFelder + 1;
                            
                        
                        end % if (board(i,j) == color)
                        % break;
                    end % if
                end % for k=1:8
            end % if (board(i,j) ~= 0)
        end % for j=1:8
    end %for i=1:8
 
   %% Steindifferenz berechnen
    if(eigSteine > gegSteine)
		piece_diff = (100.0 * eigSteine)/(eigSteine + gegSteine);
    elseif(eigSteine < gegSteine)
		piece_diff = -(100.0 * gegSteine)/(eigSteine + gegSteine);
	else piece_diff = 0;
    end % if (eigSteine > gegSteine)
    
    %% Mobilitaet berechnen: wie viele züge habe ich in relation zu den
    % möglichen zügen des gegners. Viele zugmöglichkeiten werden positiv
    % bewertet.

    % Current Mobility
    % berechne anzahl der möglichen züge für spieler und gegner
	eigMoves = get_num_moves(board, color);
	gegMoves = get_num_moves(board, -color);
    
    % Potential Mobility
    % berechne potentiell mögliche mobilität in zukünftigen zügen.
    % Kombination aus drei verschiedenen massen: anzahl der randsteine,
    % anzahl der freien felder, die an gegnerische steine grenzen 
    

    % Mobility Evaluation
	if(eigMoves > gegMoves)
		mobility = (100.0 * eigMoves)/(eigMoves + gegMoves);
    elseif(eigMoves < gegMoves)
		mobility = -(100.0 * gegMoves)/(eigMoves + gegMoves);
    else
        mobility = 0;
    end 

    
    % Frontsteine berechnen: Frontsteine sind steine, an die leere felder
    % angrenzen, das bedeutet, dass sie einnehmbar sind. Viele eigene
    % Frontsteine werden negativ bewertet. Frontsteine vertritt das
    % Mobilitätskriterium. Wenige Frontsteine machen den spieler nur
    % schwierig angreifbar.
    
	if(eigFrontSteine > gegFrontSteine)
		rand_Steine = -(100.0 * eigFrontSteine)/(eigFrontSteine + gegFrontSteine);
    elseif(eigFrontSteine < gegFrontSteine)
		rand_Steine = (100.0 * gegFrontSteine)/(eigFrontSteine + gegFrontSteine);
    else
        rand_Steine = 0;
    end % if (eigFrontSteine > gegFrontSteine)
    
    %% Eckfelder berechnen: die einnahme von ecksteinen wird stark positiv
    % bewertet. 
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

    %% corner closeness: die felder, die an ecksteine grenzen werden negativ
    % bewertet. Wenn der spieler sie einnimmt wird dies negativ bewertet,
    % wenn der gegner sie einnimmt wird dies positiv bewertet.
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

    
    
    
    
%% Final evaluation    
    
    score = (10 * piece_diff) + (801.724 * corners) + (382.026 * closeness) + (78.922 * mobility)  + (74.396 * rand_Steine) + (10 * value);
end

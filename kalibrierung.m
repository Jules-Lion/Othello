function kalibrierung()
    color = 1;
    board = [];
    board(:,:,1) = [0, 0, 0, 0, 0, 0, 0, 0; 
                    0, 0, 0, 0, 0, 0, 0, 0; 
                    0, 0, 0, 0, 0, 0, 0, 0;
                    0, 0, 0, 1,-1, 0, 0, 0; 
                    0, 0, 0,-1, 1, 0, 0, 0;
                    0, 0, 0, 0, 0, 0, 0, 0; 
                    0, 0, 0, 0, 0, 0, 0, 0; 
                    0, 0, 0, 0, 0, 0, 0, 0];

    board(:,:,2) = [0, 0, 0, 0, 0, 0, 0, 0;
                    0, 0, 0, 0, 1,-1, 0, 0;
                    0, 0, 0, 0,-1,-1, 0, 0;
                    0, 0,-1,-1, 1,-1, 0, 0;
                    0, 0,-1, 1,-1,-1, 0, 0;
                    0,-1, 1, 0,-1,-1,-1, 0;
                    0, 0, 0, 0, 0, 0, 0, 0;
                    0, 0, 0, 0, 0, 0, 0, 0];
    
    board(:,:,3) = [0, 1, 1, 1, 1, 1,-1, 0;
                    0, 0,-1, 1,-1,-1,-1, 0;
                    0, 0,-1, 1,-1, 1,-1,-1;
                    0, 0,-1, 1,-1, 1,-1,-1;
                    0, 0,-1, 1,-1, 1,-1,-1;
                    0, 0,-1, 1, 1, 1,-1, 1;
                    0, 0,-1,-1, 1, 1, 0, 0;
                    0, 0,-1,-1,-1, 1, 0, 0];
    
    board(:,:,4) = [0, 1, 1, 1, 1, 1, 1, 1;
                    0, 0,-1, 1,-1,-1, 1, 1;
                    0, 0,-1, 1,-1, 1, 1, 1;
                    0, 0,-1, 1,-1, 1,-1, 1;
                    0, 0,-1,-1,-1, 1,-1, 1;
                    0, 0,-1, 1,-1, 1,-1, 1;
                    0, 0,-1,-1, 1,-1, 0, 0;
                    0, 0,-1,-1,-1,-1,-1, 0];
    
    board(:,:,5) = [0, 1, 1, 1, 1, 1, 0, 0;
                    0, 0,-1,-1,-1,-1,-1, 0;
                    0, 0,-1,-1,-1,-1,-1,-1;
                    0, 0,-1,-1,-1,-1,-1,-1;
                    0, 0,-1,-1,-1,-1,-1,-1;
                    0, 0,-1,-1,-1, 0, 0, 0;
                    0, 0,-1,-1, 0, 0, 0, 0;
                    0, 0, 0, 0, 0, 0, 0, 0];
    
    board(:,:,6) = [0, 1, 1, 1, 0, 0, 0, 0;
                    0, 0,-1, 0, 1,-1, 0, 0;
                    0, 0,-1,-1, 1,-1,-1,-1;
                    0, 0,-1,-1, 1, 1,-1,-1;
                    0, 0,-1,-1, 1,-1, 0,-1;
                    0, 0,-1,-1,-1, 0, 0, 0;
                    0, 0,-1,-1, 0, 0, 0, 0;
                    0, 0, 0, 0, 0, 0, 0, 0];
    
    board(:,:,7) = [0, 1, 0, 0, 0, 0, 0, 0;
                    0, 0, 1, 0, 0,-1, 0, 0;
                    0, 0,-1, 1, 1, 1, 1, 0;
                    0, 0,-1,-1,-1, 1,-1, 0;
                    0, 0,-1,-1,-1,-1, 0, 0;
                    0, 0,-1, 0,-1, 0, 0, 0;
                    0, 0,-1, 0, 0, 0, 0, 0;
                    0, 0, 0, 0, 0, 0, 0, 0];
    
    board(:,:,8) = [0, 0, 0, 0, 0, 0, 0, 0;
                    0, 0,-1, 0, 0,-1, 0, 0;
                    0, 0,-1, 1, 1, 1, 1, 0;
                    0, 0,-1,-1,-1, 1,-1, 0;
                    0, 0,-1,-1,-1,-1, 0, 0;
                    0, 0,-1, 0,-1, 0, 0, 0;
                    0, 0,-1, 0, 0, 0, 0, 0;
                    0, 0, 0, 0, 0, 0, 0, 0];

    
    id = fopen('time.txt', 'w');
    fprintf(id, '%s\n', version);
    depth = 6;
    for k = 1:size(board, 3)
        tic;
        WeWinMagic(board(:,:,k), depth, color, -inf, inf, depth); 
        time = toc;
    
        fprintf(id, 'Board %d: %fs.\n', k, time);
    end    

end

function score = evaluation(board, color, moves_list)

% Initialize valueTable
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
eigRandSteine = 0;
gegRandSteine = 0;


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

% Randsteine berechnen: randsteine sind steine, an die leere felder
% angrenzen, das bedeutet, dass sie einnehmbar sind. Viele eigene
% randsteine werden negativ bewertet. Randsteine vertritt das
% Stabilitätskriterium. Wenige Randsteine machen den spieler nur
% schwierig angreifbar.

if(eigRandSteine > gegRandSteine)
    rand_Steine = -(100.0 * eigRandSteine)/(eigRandSteine + gegRandSteine);
elseif(eigRandSteine < gegRandSteine)
    rand_Steine = (100.0 * gegRandSteine)/(eigRandSteine + gegRandSteine);
else
    rand_Steine = 0;
end % if (eigRandSteine > gegRandSteine)

% Eckfelder berechnen: die einnahme von ecksteinen wird stark positiv
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

% corner closeness: die felder, die an ecksteine grenzen werden negativ
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


% Mobilitaet berechnen: wie viele züge habe ich in relation zu den
% möglichen zügen des gegners. Viele zugmöglichkeiten werden positiv
% bewertet.
mobility = 0;

%berechne anzahl der möglichen züge für spieler und gegner
eigSteine = size(moves_list, 1);
gegSteine = size(get_valid_moves(board, -color), 1);
if(eigSteine > gegSteine)
    mobility = (100.0 * eigSteine)/(eigSteine + gegSteine);
elseif(eigSteine < gegSteine)
    mobility = -(100.0 * gegSteine)/(eigSteine + gegSteine);
else
    mobility = 0;
end

% Final evaluation

score = (10 * piece_diff) + (801.724 * corners) + (382.026 * closeness) + (78.922 * mobility)  + (74.396 * rand_Steine) + (10 * value);
end


function [ valid_moves, boards ] = get_valid_moves( board, color )
    % alle moeglichen Richtungen
    v  = [-1, 0; -1, 1; 0, 1; 1, 1; 1, 0; 1, -1; 0, -1; -1, -1];
    
    valid_moves = [];
    boards = {};

    for i = 1:8
        for j = 1:8
            b = board;
            pos = [i, j];
            
            % Diese Funktion gibt die neue Spielsituation für alle moeglichen Zuege
            % zurueck.

            move_valid = 0;

            % falls Feld frei
            if b(pos(1), pos(2)) == 0
                % schaue in alle 8 Richtungen nach der Farbe des Gegners
                for l = 1:8
                    pos2 = pos + v(l,:);

                    % Gehe nicht über das Spielfeld hinaus
                    if (pos2(1) < 1) || (pos2(2) < 1) || (pos2(1) > 8) || (pos2(2) > 8)
                    %if any(pos2(1) == [0, 9] | pos2(2) == [0, 9])
                    %if min(pos2) == 0 || max(pos2) == 9
                        continue;

                    % falls Farbe des Gegeners
                    elseif b(pos2(1), pos2(2)) == -color

                        % gehe in aktuelle Richtung weiter
                        for s = 2:7
                            pos2 = pos2 + v(l,:);
                            if pos2(1) < 1 || pos2(2) < 1 || pos2(1) > 8 || pos2(2) > 8
                            %if any(pos2(1) == [0, 9] | pos2(2) == [0, 9])
                            %if min(pos2) == 0 || max(pos2) == 9
                                break;

                            % sobald Feld = eigene Farbe ist Zug gueltig
                            elseif b(pos2(1), pos2(2)) == color

                                % Drehe alle Steine fuer aktuelle Richtung um
                                for t = 0:s - 1
                                    pos4 = pos + t*v(l,:);
                                    b(pos4(1), pos4(2)) = color;
                                end
                                move_valid = 1;
                                break;

                            elseif b(pos2(1), pos2(2)) == 0
                                break;
                            end
                        end
                    end
                end
            end

            % merke gueltigen Zug
            if move_valid == 1
                valid_moves(end + 1, :) = pos;
                boards{end + 1} = b;
            end
        end
    end
end

function [max_v, b] = WeWinMagic(board, depth, color, alpha, beta, anfangstiefe)

maxDepth = anfangstiefe;
max_value = alpha;


[ moves_list, boards ] = get_valid_moves(board, color);

num_moves = size(moves_list, 1);
% TESTING
if (depth == maxDepth)
   if (num_moves <= 2)
       depth = depth + 2;
       maxDepth = maxDepth + 2;
   elseif (num_moves <= 5)
       depth = depth + 1;
       maxDepth = maxDepth + 1;
   elseif (num_moves <= 10)
       % do nothing
   else 
       depth = depth - 1;
       maxDepth = maxDepth - 1;
   end
end
% TESTING

if depth <= 0
    b = board;
    max_v = evaluation(board, color, moves_list);
elseif num_moves == 0
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

maxDepth = anfangstiefe;
min_value = beta;

[ moves_list, boards ] = get_valid_moves(board, color);

num_moves = size(moves_list, 1);

if depth == 0
    min_v = evaluation(board, color, moves_list);
elseif num_moves == 0
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

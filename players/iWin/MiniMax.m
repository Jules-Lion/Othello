% Minimax-Algorithmus
% liefert die ausgeäwhlte Punktzahl zu der der Spielzug fuehren koennte
% und den Ausgewahlten Spielzug zurueck.
% Als Argumente erwartet die Funktion minimax den Spieler und die Suchtiefe
function [max_v, b] = MiniMax(board, depth, color)

% definiere den ersten Wert
max_value = 0;
moves_list = [];
firstFlag = 0;
b = board;

for i = 1:8
    for k = 1:8
        b_neu = apply_move(board, color, [i, k]);
        
        if ~isempty(b_neu)
            if firstFlag == 0
                moves_list = [i, k];
                % allererster gueltiger Zug
                best_move_max = [i, k];
                % b = b_neu?!?!?!
                b = apply_move(board, color, best_move_max);
                firstFlag = 1;
            else 
                % alle gueltigen Zuege
                moves_list = [moves_list; [i, k]];
            end
        end
    end
end

% Gibt eine Matrix aus mit den möglichen Spielzuegen. 
% Z.B. moves = [4 3; 6 8] bedeutet naechst möglicher Zug im der Zeile 4 
% der Spalte 3 vom Spielfeld usw.. 
% Aufrufen der Funktion die die Spielzuege ausgibt det_valid_move
%moves_list = det_valid_moves(board, color);                                         % color ist in diesem Fall Player ueberall wo color steht

% Anzahl der moeglichen Spielzuege ausgeben
num_moves = size(moves_list, 1);

if (depth == 0 || num_moves == 0)                     % Wenn die Suchtiefe gleich 0 ist oder kein Spielzug fuer den Spieler vorhanden ist, dann Bewerte
        max_v = evaluation(board, color);             % ob Suchtiefe = 0 ist, sollte ganz am Anfang abgefragt werden, da sonst umsonst nach gueltigen Zuegen gesucht wird
else                                                  % wenn keine gueltigen Zuege vorhanden, dann sollte der Gegner dran sein!!!

   while (num_moves)
    % Funktion: einen Zug von allen (z.B. von 4 Zügen) ausfuehren. 
    % das aktuelle board und einen der Zuege von num_moves uebergeben erste
    % Zeile
    new_board = apply_move(board, color, moves_list(num_moves,:));                                        % muss noch geschrieben werden
    % depth-1 heisst nicht, dass wir bei depth (z.B.=3) anfangen sondern
    % dass wir die Anzahl von depths die wir untersuchen wollen erniedirgen um alle vorgegebenen depths zu überprüfen 
    value = min (-color, depth-1, new_board);
    % Zug wieder auf Ausgangsposition setzten um die anderen drei Zuege in
    % der selben Ebene zu prüfen. Zurueck zum alten Board
    %board = back_move(new_board, moves_list(num_moves,:));                                        % muss noch geschrieben werden
    % hier wird der Knoten mit dem groessten Nutzwert bestimmt
        if (value > max_value)
            max_value = value;                              % weise max_value den groesseren Wert zu
            best_move_max = moves_list(num_moves,:);            % speicher den besten Spielzug
            b = apply_move(board, color, best_move_max);
        end
    
    % Anzahl der Spielzuege um eins reduzieren
    num_moves = num_moves - 1;
   
   end
   % Rueckgabe des groessten Wertes
   max_v = max_value;
end
    
    
end

function [min_v]  = min(color, depth, board)

% definiere den ersten Wert
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

% Zuweisung der Matrix der Funktion an moves. Hier bekommen wir wieder
% einen neuen Knoten mit einer eventuell unterschiedlichen Anzahl an childs
%moves_list = det_valid_moves(board, color);

% Anzahl der moeglichen Spielzuege ausgeben
num_moves = size(moves_list, 1);

if (depth == 0 || num_moves == 0)                     % Wenn die Suchtiefe gleich 0 ist und kein Spielzug fuer den Spieler vorhanden ist, dann Bewerte
        min_v = evaluation(board, color);                         % Funktion muss noch geschrieben werden
else
    while (num_moves)
    
        % 
        new_board = apply_move(board, color, moves_list(num_moves,:));
        %
        [value, best_move_max] = MiniMax(new_board, depth-1, -color);
        % 
        %board = back_move(board, moves_list(num_moves,:));
    
        if (value < min_value)
            min_value = value;                              % weise max_value den groesseren Wert zu
            best_move_max = moves_list(num_moves,:);        % best_move_max entweder gloabl definieren in der Hauptfunktion oder in der Funktion selbst als rueckgabewert
            b = apply_move(board, color, best_move_max);

        end
        % Anzahl der Spielzuege um eins reduzieren
        num_moves = num_moves - 1;
    end
    % Rueckgabe des kleinsten Wertes
    min_v = min_value;
end
    
     
end




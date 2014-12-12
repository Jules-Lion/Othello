function [ num_moves ] = get_num_moves( board, color )
    % alle moeglichen Richtungen
    v = [-1, -1,  0,  1,  1,  1,  0, -1;
          0,  1,  1,  1,  0, -1, -1, -1];

    num_moves = 0;

    [row, col] = find(conv2(double(board == -color), ones(3), 'same') > 0 & board == 0);
    
    for pos = [row'; col']
        b = board;
        move_valid = 0;

        % falls Feld frei
        if b(pos(1), pos(2)) == 0
            % schaue in alle 8 Richtungen nach der Farbe des Gegners
            for l = 1:8
                pos2 = pos + v(:,l);

                % Gehe nicht über das Spielfeld hinaus
                if (pos2(1) < 1) || (pos2(2) < 1) || (pos2(1) > 8) || (pos2(2) > 8)
                    continue;

                % falls Farbe des Gegeners
                elseif b(pos2(1), pos2(2)) == -color

                    % gehe in aktuelle Richtung weiter
                    for s = 2:7
                        pos2 = pos2 + v(:,l);
                        if pos2(1) < 1 || pos2(2) < 1 || pos2(1) > 8 || pos2(2) > 8
                            break;

                        % sobald Feld = eigene Farbe ist der Zug gueltig
                        elseif b(pos2(1), pos2(2)) == color
                            move_valid = 1;
                            break;

                        % Richtung ungueltig
                        elseif b(pos2(1), pos2(2)) == 0
                            break;
                        end
                    end
                end
                        
                if move_valid == 1
                    break;
                end
            end
        end

        % merke gueltigen Zug
        if move_valid == 1
            num_moves = num_moves + 1;
            
        end
    end
end
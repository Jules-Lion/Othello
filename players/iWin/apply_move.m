function [ b ] = apply_move( b, color, pos )

    % Diese Funktion gibt die neue Spielsituation f�r alle moeglichen Zuege
    % zurueck.

    % alle moeglichen Richtungen
    v  = [-1, 0; -1, 1; 0, 1; 1, 1; 1, 0; 1, -1; 0, -1; -1, -1];

    r = 1;
    move_valid = 0;

    % falls Feld frei
    if b(pos(1), pos(2)) == 0
        % schaue in alle 8 Richtungen nach der Farbe des Gegners
        for l = 1:8
            pos2 = pos;
            pos2 = pos2 + v(l,:);

            % Gehe nicht �ber das Spielfeld hinaus
            if (pos2(1) < 1) || (pos2(2) < 1) || (pos2(1) > 8) || (pos2(2) > 8)
                continue;

            % falls Farbe des Gegeners
            elseif b(pos2(1), pos2(2)) == -color

                % gehe in aktuelle Richtung weiter
                for s = 2:7
                    pos3 = pos;

                    pos3 = pos3 + s*v(l,:);
                    if pos3(1) < 1 || pos3(2) < 1 || pos3(1) > 8 || pos3(2) > 8
                        continue;

                    % sobald Feld = eigene Farbe ist Zug gueltig
                    elseif b(pos3(1), pos3(2)) == color

                        % Drehe alle Steine fuer aktuelle Richtung um
                        for t = 0:s - 1
                            pos4 = pos + t*v(l,:);
                            b(pos4(1), pos4(2)) = color;
                            move_valid = 1;
                        end

                        r = r + 1;
                        break;

                    elseif b(pos3(1), pos3(2)) == 0
                        break;
                    end
                end
            end
        end
    end

    % ungueltiger Zug gibt leeres Feld zurueck
    if move_valid == 0
        b = [];
    end
end
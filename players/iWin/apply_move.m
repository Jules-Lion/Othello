function [ b ] = apply_move( b, color, pos )
 
    % Diese Funktion gibt die neue Spielsituation für alle moeglichen Zuege
    % zurueck.

    % alle moeglichen Richtungen
    v  = [-1, 0; -1, 1; 0, 1; 1, 1; 1, 0; 1, -1; 0, -1; -1, -1];
    %valid = [];
    %V = [];
    %flag = 0;
    r = 1;
    move_valid = 0;

    % falls Feld frei
    if b(pos(1), pos(2)) == 0
        pos
        % schaue in alle 8 Richtungen nach Farbe des Gegners
        for l = 1:8
            pos2 = pos;
            pos2 = pos2 + v(l,:);
            %v(l,:)
            %pos2
       
            % Gehe nicht über das Spielfeld hinaus
            if (pos2(1) < 1) || (pos2(2) < 1) || (pos2(1) > 8) || (pos2(2) > 8)
                continue;     
                
            % falls Farbe des Gegeners
            elseif b(pos2(1), pos2(2)) == -color
                pos2
                
                % gehe in aktuelle Richtung weiter
                for s = 2:7
                    pos3 = pos;
    
                        pos3 = pos3 + s*v(l,:);
                        pos3
                        %disp('weiter in suchrichtung')
                        %disp(pos3)
                        %disp(v(l,:))
                        %disp('hallo')
                        if pos3(1) < 1 || pos3(2) < 1 || pos3(1) > 8 || pos3(2) > 8
                            disp('oob')
                            continue;
                            
                        % sobald Feld = eigene Farbe ist Zug gueltig
                        elseif b(pos3(1), pos3(2)) == color
                            disp('eigen')
              
                            % merke Ausgangsfeld als gueltigen Zug
                            % statt r: end+1
                            %valid(r, :) = pos;
                            %V(r,:) = v(l,:);
                            
                            % Drehe alle Steine fuer aktuelle Richtung um
                            for t = 0:s - 1
                                pos4 = pos + t*v(l,:);
                                b(pos4(1), pos4(2)) = color;
                                move_valid = 1;
                            end
                            
                            r = r + 1;
                            break;
                            
                        elseif b(pos3(1), pos3(2)) == 0
                            disp('leer')
                            %disp('kein gueltiger zug')
                            %disp(pos3)
                            break;   
                        end
                        disp('fremd')
                end
            end
        end
    end

    % ungueltiger Zug gibt leeres Feld zurueck
    if move_valid == 0
        b = [];
    end
end
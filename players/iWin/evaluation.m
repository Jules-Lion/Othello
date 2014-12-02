function value = evaluation(board, color)
    valueTable = [  99,  -8,  8,  6,  6,  8,  -8, 99;
                    -8, -24, -4, -3, -3, -4, -24, -8;
                     8,  -4,  7,  4,  4,  7,  -4,  8;
                     6,  -3,  4,  0,  0,  4,  -3,  6;
                     6,  -3,  4,  0,  0,  4,  -3,  6;
                     8,  -4,  7,  4,  4,  7,  -4,  8;
                    -8, -24, -4, -3, -3, -4, -24, -8;
                    99,  -8,  8,  6,  6,  8,  -8, 99];
                
    value = 0;
                         
 % Soweit die Eckfelder besetzt sind, koennen die nicht mehr geaendert werden.
 % Das gleiche gilt auch fuer die benachbarten Felder und die zaehlen ab dem Zeitpunkt als "positiv".
    if(board(1,1)==color)
		valueTable(1,2)=8;
		valueTable(2,1)=8;
		valueTable(2,2)=7;
	end

	if(board(1,8)==color)
		valueTable(1,7)=8;
		valueTable(2,8)=8;
		valueTable(2,7)=7;
	end

	if(board(8,1)==color)
		valueTable(7,1)=8;
		valueTable(8,2)=8;
		valueTable(7,2)=7;
	end

	if(board(8,8)==color)
		valueTable(7,8)=8;
		valueTable(8,7)=8;
		valueTable(7,7)=7;
	end

	for i=1:8
        for j=1:8
            if (board(i,j) == color)
                value = value + valueTable(i,j);
            else
                %do nothing
            end    
        end
    end
end

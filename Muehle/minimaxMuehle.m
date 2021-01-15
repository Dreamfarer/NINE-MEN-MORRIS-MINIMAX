function [bestScore, bestMoveFrom, bestMoveTo] = minimaxMuehle(board, depth, phase1, phase2, playerType)

bestMoveFrom=0;
bestMoveTo=0;
isOver=evaluateMuehleBoard(board, depth, phase1, phase2, -playerType);
if (isOver || depth==6)
    bestScore=isOver*(playerType);
else
    bestScore =  -Inf * playerType;
    
    if phase1==1
        for i = 1:length(board(:))
            if board(i) == 0 %also Feld noch nicht belegt
                childboard = board;
                childboard(i) = playerType; %move eintragen
                score = minimaxMuehle(childboard, depth-1, phase1, phase2, -playerType); %rekursiver Aufruf
                
                %if current move is better than previous candidates -> update
                if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                    (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                    bestScore = score;
                    bestMoveTo = i ;
                end               
            end
        end
    end
    
end


end
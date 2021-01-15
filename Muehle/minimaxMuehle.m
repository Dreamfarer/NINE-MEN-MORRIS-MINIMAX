function [bestScore, bestMoveFrom, bestMoveTo] = minimaxMuehle(board, depth, phase1, phase2, playerType)

bestMoveFrom=0;
bestMoveTo=0;
isOver=evaluateMuehleBoard(board, depth, phase1, phase2, -playerType);
if (isOver || depth==6)
    bestScore=isOver*(playerType);
else
    bestScore =  -Inf * playerType;
    
    if phase1==1
       
    end
    
end


end
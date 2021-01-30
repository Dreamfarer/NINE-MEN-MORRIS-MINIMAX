function [bestScore, bestMoveFrom, bestMoveTo, bestStoneRemove] = minimaxMuehle(board, depth, phase1, phase2, playerType,stonesBeginningPhase)

if stonesBeginningPhase==0 && phase1==1
    phase1=2;
    phase2=2;
end
bestMoveFrom=0;
bestMoveTo=0;
bestStoneRemove=0;

isOver=evaluateMuehleBoard(board, depth, phase1, phase2, -playerType);
if (isOver || depth==3)
    bestScore=isOver*(playerType);
else
    bestScore =  -Inf * playerType;
    
    if phase1==1
%         childboard=board;
%         childboard(isnan(childboard))=2;
%         availableSpaces=find(~childboard(:));
%         a=availableSpaces(1);
%         childboard(a) = playerType;
%        
%         if checkMuehle(childboard,a) %take away opponent's stone if you have a muehle
%             possibleRemoves=[];
%             n=0;
%             for l=1:numel(childboard)
%                 if validRemove(childboard,playerType,l) %check if there are any possible stones to remove
%                     n=n+1;
%                     possibleRemoves=[possibleRemoves,l];
%                 end
%             end
%             if n~=0
%                 for i=1:numel(possibleRemoves)
%                     stoneToRemove=possibleRemoves(i);
%                     childboard(stoneToRemove)=0; %removes stone from board
%                     score=minimaxMuehle(childboard, depth+1, phase1,phase1,-playerType,stonesBeginningPhase-1);
%                     if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
%                         (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
%                         bestScore = score;
%                         bestMoveTo = i ;
%                         bestStoneRemove=stoneToRemove;
%                     end 
%                 end
%             end
%         end
%             
%         score=minimaxMuehle(childboard, depth+1, phase1,phase1,-playerType,stonesBeginningPhase-1);
%         
%         if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
%                 (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
%                 bestScore = score;
%                 bestMoveTo = i ;
%         end 
            
            
    else
        childboard=board;
        myStones=find(board==playerType);
        for i=1:length(myStones)
            for j=1:length(board(:))
                if isValidMove(childboard,myStones(i),j,playerType,phase1,phase2)
                    childboard([myStones(i) j])=childboard([j myStones(i)]);
                    
                    %hier braucht es einen Mühle check
                    
                    
                    if checkMuehle(childboard,j) %take away opponent's stone if you have a muehle
                        possibleRemoves=[];
                        for l=1:numel(childboard)
                            if validRemove(childboard,playerType,l) %check if there are any possible stones to remove
                                possibleRemoves=[possibleRemoves,l];
                            end
                        end
                        if ~isempty(possibleRemoves)
                            for r=1:numel(possibleRemoves)
                                stoneToRemove=possibleRemoves(r);
                                childboard(stoneToRemove)=0; %removes stone from board
                                score=minimaxMuehle(childboard, depth+1, phase1,phase1,-playerType,stonesBeginningPhase-1);
                                if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                                    (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                                    bestScore = score;
                                    bestMoveFrom=myStones(i);
                                    bestMoveTo = j ;
                                    bestStoneRemove=stoneToRemove;
                                end 
                            end
                        end
                    end
                    
                    score=minimaxMuehle(childboard, depth+1, phase1,phase1,-playerType,0);
                    
                    if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                    (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                        bestScore = score;
                        bestMoveFrom=i;
                        bestMoveTo = j;
                    end 
                end
            end
        end
        
        
        
    end
    
end


end
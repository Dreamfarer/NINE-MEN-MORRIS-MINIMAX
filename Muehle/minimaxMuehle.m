function [bestScore, bestMoveFrom, bestMoveTo, bestStoneRemove] = minimaxMuehle(board, depth, phase1, phase2, playerType,stonesBeginningPhase)


bestMoveFrom=0;
bestMoveTo=0;
bestStoneRemove=0;

if stonesBeginningPhase==0 && phase1==1
    phase1=2;
    phase2=2;
elseif (playerType==1 && phase1==2) || (playerType==-1 && phase2==2)
    if sum(board==playerType,'all')==3 %change phase to 3 if only 3 stones left
        if playerType==1
            phase1=3;
        else
            phase2=3;
        end
    end
end


isOver=evaluateMuehleBoard(board, depth, phase1, phase2, -playerType);
if (isOver || depth==3)
    bestScore=isOver *(playerType);
else
    
    bestScore =  -Inf * playerType;
    childboard=board;
    if phase1==1
        availableSpaces=find(childboard==0);
        for i=1:numel(availableSpaces(:))
            childboard(availableSpaces(i))=playerType;
            
            if checkMuehle(childboard,i) %take away opponent's stone if you have a muehle
                possibleRemoves=[];
                for j=1:numel(childboard)
                    if validRemove(childboard,playerType,j) %check if there are any possible stones to remove
                        possibleRemoves=[possibleRemoves,j];
                    end
                end
                if ~isempty(possibleRemoves)
                    for k=1:numel(possibleRemoves)
                        childboard(possibleRemoves(k))=0; %removes stone from board
                        score=minimaxMuehle(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1);
                        if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                            (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                            bestScore = score;
                            bestMoveTo = availableSpaces(i);
                            bestStoneRemove=possibleRemoves(k);
                        end 
                    end
                else
                    score=minimaxMuehle(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1);
                    if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                        (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                        bestScore = score;
                        bestMoveTo = availableSpaces(i);
                    end  
                end
                
            
            else
                score=minimaxMuehle(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1);
                if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                    (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                    bestScore = score;
                    bestMoveTo = availableSpaces(i);
                end     
            end
        end
        
    else %phase 2&3
        
        possibleFrom=(find(childboard==playerType));
        
        for i=1:numel(possibleFrom)
            possibleTo=[];
            for j=1:numel(childboard)
                if isValidMove(childboard,possibleFrom(i),j,playerType,phase1,phase2)
                    possibleTo=[possibleTo, j];
                end
            end
            if ~isempty(possibleTo)
               for k=1:numel(possibleTo)
                  childboard([possibleFrom(i), possibleTo(k)])=childboard([possibleTo(k), possibleFrom(i)]);
                  
                  if checkMuehle(childboard,possibleTo(k)) %take away opponent's stone if you have a muehle
                      possibleRemoves=[];
                      for l=1:numel(childboard)
                          if validRemove(childboard,playerType,l) %check if there are any possible stones to remove
                              possibleRemoves=[possibleRemoves,l];
                          end
                      end
                      if ~isempty(possibleRemoves)
                          for m=1:numel(possibleRemoves)
                              childboard(possibleRemoves(m))=0; %removes stone from board
                              score=minimaxMuehle(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1);
                              if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                                  (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                                  bestScore = score;
                                  bestMoveFrom=possibleFrom(i);
                                  bestMoveTo = possibleTo(k);
                                  bestStoneRemove=possibleRemoves(m);
                              end 
                          end
                      else
                        score=minimaxMuehle(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1);
                        if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                            (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                            bestScore = score;
                            bestMoveFrom=possibleFrom(i);
                            bestMoveTo = possibleTo(k);
                        end
                      end
                      
                      
                  else
                      
                      score=minimaxMuehle(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1);
                      if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                        (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                          bestScore = score;
                          bestMoveFrom=possibleFrom(i);
                          bestMoveTo = possibleTo(k);
                      end 
   
                  end
               end
            end
            
        end 
        
    end
    
end


end
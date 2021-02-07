function [bestScore, bestMoveFrom, bestMoveTo, bestStoneRemove] = minimaxMuehle2(board, depth, phase1, phase2, playerType,stonesBeginningPhase, latestMoveTo)



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


[isOver, finscore]=evaluateMuehleBoard2(board, depth, phase1, phase2, -playerType, latestMoveTo);
if (isOver || depth==3)
    bestScore=finscore; %*(playerType);
%     disp(['best Score of this iteration: ' num2str(bestScore)]);

    
%     disp('simulated branch is over or AI looked ahead 3 moves');
%     disp(['best Score of this simulation is: ' num2str(bestScore)]);
%     disp(['best Move of this simulation is: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
else
    
    bestScore =  -Inf * playerType;
    
    if phase1==1
        
%         disp([num2str(playerType) ' makes a move in phase 1']);
        availableSpaces=find(board==0);
        
%         disp('They can place a stone at these spaces: ');
%         availableSpaces
        
        for i=1:numel(availableSpaces(:))
            childboard=board;
            childboard(availableSpaces(i))=playerType;
%             disp(['they place a stone on space: ' num2str(availableSpaces(i))]);
            if checkMuehle(childboard,availableSpaces(i)) %take away opponent's stone if you have a muehle
%                 disp('with this move, the player made a mill');
%                 childboard
                possibleRemoves=[];
                for j=1:numel(childboard)
                    if validRemove(childboard,playerType,j) %check if there are any possible stones to remove
                        possibleRemoves=[possibleRemoves,j];
                    end
                end
                if ~isempty(possibleRemoves)
                    
%                     disp('they can remove these stones: ');
%                     possibleRemoves
                    
                    for k=1:numel(possibleRemoves)
                        childboard(possibleRemoves(k))=0; %removes stone from board
%                         disp(['they remove stone: ' num2str(possibleRemoves(k))]);
%                         disp(' ');
                        score=minimaxMuehle2(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1, availableSpaces(i));
                        if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                            (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
%                             disp('this move is better than the last one');
%                             disp(['best score in depth ' num2str(depth) ' before was: ' num2str(bestScore)]);
%                             disp(['best move in depth ' num2str(depth) ' before was: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                            bestScore = score;
                            bestMoveTo = availableSpaces(i);
                            bestStoneRemove=possibleRemoves(k);
%                             disp(['best score in depth ' num2str(depth) ' now is: ' num2str(bestScore)]);
%                             disp(['best move in depth ' num2str(depth) ' now is: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                        end 
                    end
                else
%                     disp('unfortunately they can''t remove any stone');
%                     disp(' ');
                    score=minimaxMuehle2(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1, availableSpaces(i));
                    if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                        (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
%                         disp('this move is better than the last one');
%                         disp(['best score in depth ' num2str(depth) ' before was: ' num2str(bestScore)]);
%                         disp(['best move in depth ' num2str(depth) ' before was: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                        bestScore = score;
                        bestMoveTo = availableSpaces(i);
                        bestStoneRemove=0;
%                         disp(['best score in depth ' num2str(depth) ' now is: ' num2str(bestScore)]);
%                         disp(['best move in depth ' num2str(depth) ' now is: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                    end  
                end
                
            
            else
%                 disp('no mill, continue normally');
%                 disp(' ');
                score=minimaxMuehle2(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1, availableSpaces(i));
                if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                    (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
%                     disp('this move is better than the last one');
%                     disp(['best score in depth ' num2str(depth) ' before was: ' num2str(bestScore)]);
%                     disp(['best move in depth ' num2str(depth) ' before was: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                    bestScore = score;
                    bestMoveTo = availableSpaces(i);
                    bestStoneRemove=0;
%                     disp(['best score in depth ' num2str(depth) ' now is: ' num2str(bestScore)]);
%                     disp(['best move in depth ' num2str(depth) ' now is: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                end     
            end
        end
        
    else %phase 2&3
%         disp([num2str(playerType) ' makes a move in phase 2 or 3']);
        possibleFrom=(find(board==playerType));
        
        for i=1:numel(possibleFrom)
            possibleTo=[];
            for j=1:numel(board)
                if isValidMove(board,possibleFrom(i),j,playerType,phase1,phase2)
                    possibleTo=[possibleTo, j];
                end
            end
            
            
            
            if ~isempty(possibleTo)
                
%                disp(['they can move stone ' num2str(possibleFrom(i)) ' to: ']);
%                possibleTo
               
               for k=1:numel(possibleTo)
                  childboard=board;
                  childboard([possibleFrom(i), possibleTo(k)])=childboard([possibleTo(k), possibleFrom(i)]);
%                   disp(['they move stone ' num2str(possibleFrom(i)) ' to: ' num2str(possibleTo(k))]);
                  if checkMuehle(childboard,possibleTo(k)) %take away opponent's stone if you have a muehle
%                       disp('with this move, the player made a mill');
                      possibleRemoves=[];
                      for l=1:numel(childboard)
                          if validRemove(childboard,playerType,l) %check if there are any possible stones to remove
                              possibleRemoves=[possibleRemoves,l];
                          end
                      end
                      if ~isempty(possibleRemoves)
                          
%                           disp('they can remove these stones: ');
%                           possibleRemoves
                          
                          for m=1:numel(possibleRemoves)
                              childboard(possibleRemoves(m))=0; %removes stone from board
                              disp(['they remove stone: ' num2str(possibleRemoves(m))]);
                              disp(' ');
                              score=minimaxMuehle2(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1, possibleTo(k));
                              if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                                  (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
%                                   disp('this move is better than the last one');
%                                   disp(['best score in depth ' num2str(depth) ' before was: ' num2str(bestScore)]);
%                                   disp(['best move in depth ' num2str(depth) ' before was: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                                  bestScore = score;
                                  bestMoveFrom=possibleFrom(i);
                                  bestMoveTo = possibleTo(k);
                                  bestStoneRemove=possibleRemoves(m);
%                                   disp(['best score in depth ' num2str(depth) ' now is: ' num2str(bestScore)]);
%                                   disp(['best move in depth ' num2str(depth) ' now is: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                              end 
                          end
                      else
%                         disp('unfortunately they can''t remove any stone');
%                         disp(' ');
                        score=minimaxMuehle2(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1, possibleTo(k));
                        if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                            (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
%                             disp('this move is better than the last one');
%                             disp(['best score in depth ' num2str(depth) ' before was: ' num2str(bestScore)]);
%                             disp(['best move in depth ' num2str(depth) ' before was: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                            bestScore = score;
                            bestMoveFrom=possibleFrom(i);
                            bestMoveTo = possibleTo(k);
                            bestStoneRemove=0;
%                             disp(['best score in depth ' num2str(depth) ' now is: ' num2str(bestScore)]);
%                             disp(['best move in depth ' num2str(depth) ' now is: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                        end
                      end
                      
                      
                  else
%                       disp('no mill, continue normally');
%                       disp(' ');
                      score=minimaxMuehle2(childboard, depth+1, phase1,phase2,-playerType,stonesBeginningPhase-1, possibleTo(k));
                      if (playerType == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                        (playerType == - 1 && score < bestScore)    %minimizing player --> wants negative scores
%                           disp('this move is better than the last one');
%                           disp(['best score in depth ' num2str(depth) ' before was: ' num2str(bestScore)]);
%                           disp(['best move in depth ' num2str(depth) ' before was: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                          bestScore = score;
                          bestMoveFrom=possibleFrom(i);
                          bestMoveTo = possibleTo(k);
                          bestStoneRemove=0;
%                           disp(['best score in depth ' num2str(depth) ' now is: ' num2str(bestScore)]);
%                           disp(['best move in depth ' num2str(depth) ' now is: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
                      end 
   
                  end
               end
            end
            
        end 
        
    end
    
end

% if bestScore==(Inf)
%     disp(['This move changed bestScore to Inf: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
% end


% disp(['move of depth ' num2str(depth) ' that gets returned: ' num2str(bestMoveFrom) ', ' num2str(bestMoveTo) ', ' num2str(bestStoneRemove)]);
% disp(' ');
end
function b=muehleController5(b,startingPlayer)
%Mühle controller for a human player and an improved AI, I/O via GUI
%inputs:
%  b  (default:empty) specifies a board (3x3x3, 0=empty; 1=mark pl1(white); -1=mark pl2(black); nan=not a valid space)
%  startingPlayer (default:random) specifies which players (1/-1) turn it is

phase1=1;
phase2=1;
stonesBeginningPhase=18;
removedStone = NaN;

%Determine which player begins
if ~exist('startingPlayer','var')
    startingPlayer = 1;
    if rand()>0.5
        startingPlayer = -1; 
    end
end

playerType = startingPlayer;

%Create 3x3x3 board
if ~exist('b','var') || size(b,1)~=3 || size(b,2)~=3 || size(b,3)~=3 %create board if nonexistent
    a = zeros(3,3,3); 
    a(2,2,:) = NaN; %NaN at every middle position since muehle has no middle position in each layer
    b=a;
end

moveTo = NaN;
moveFrom = NaN;
bestStoneRemove = NaN;

while 1
    %Human Player
    if playerType == 1 
        
        %Phase 1
        if stonesBeginningPhase>0
            
            %Count down stones
            stonesBeginningPhase=stonesBeginningPhase-1; 
            
            %Call GUI and do the magik
            [b, moveTo] = GUI(b, playerType, [phase1 phase2], "move", [moveFrom moveTo removedStone]);
        
        %Phase 2 and 3
        elseif phase1==2 || phase1==3 %%check for phase 2 or 3

            [b, moveTo] = GUI(b, playerType, [phase1 phase2], "move", [moveFrom moveTo removedStone]);
            
        end
        
        removedStone = NaN;
    
    %AI Player    
    else
        
        %Call GUI to tell the player that AI is calculating
        GUI(b, playerType, [phase1 phase2], "waitForAI", [moveFrom moveTo removedStone]);
        
        [bestScore, moveFrom, moveTo, bestStoneRemove] = minimaxMuehle2(b, 0, phase1, phase2, playerType,stonesBeginningPhase, 1);
        if phase2==1
            stonesBeginningPhase=stonesBeginningPhase-1;
            b(moveTo)=playerType;
            moveFrom = NaN;
        else
            if bestScore==(Inf) %AI knows that it loses -> makes the first move possible
                possibleFrom=(find(b==playerType));
                for i=1:numel(possibleFrom)
                    for j=1:numel(b)
                        if isValidMove(b,possibleFrom(i),j,playerType,phase1,phase2)
                            moveFrom=possibleFrom(i);
                            moveTo=j;
                            break;
                        end
                    end
                    if moveFrom~=0
                        break;
                    end
                end
            end

            b([moveFrom moveTo])=b([moveTo moveFrom]); 
   
           
        end
    end
    
    %Take away opponent's stone if you have a muehle
    if checkMuehle(b,moveTo) 
        
        %Human Player
        if playerType==1
            
             [b, moveTo] = GUI(b, playerType, [phase1 phase2], "remove", [moveFrom moveTo removedStone]);
            
        %AI
        else
            
            possibleRemoves=[];
            for l=1:numel(b)
                if validRemove(b,playerType,l) %check if there are any possible stones to remove
                    possibleRemoves=[possibleRemoves,l];
                end
            end
            if ~isempty(possibleRemoves)
                if bestScore~=(Inf) 
                    b(bestStoneRemove)=0;
                    removedStone = bestStoneRemove;
                else %AI knows that it loses -> makes the first remove possible if it makes a muehle by accident
                    b(possibleRemoves(1))=0;
                end
            end
   
        end
        
        %Change opponent to phase 3 when they only have 3 stones remaining
        if (playerType==1 && phase1==2) || (playerType==-1 && phase2==2)||(playerType==1 && phase1==3) || (playerType==-1 && phase2==3)
            if sum(b==-playerType,'all')==3 
                if -playerType==1
                    phase1=3;
                else
                    phase2=3;
                end
            end
        end
        
    end
    
    %Change Phase from 1 to 2 after all stones have been placed
    if stonesBeginningPhase==0 && phase1 == 1 && phase2 == 1
        phase1=2;
        phase2=2;
        
    end
    
    %Check if game is over
    isOver = evaluateMuehleBoard2(b, 0, phase1, phase2, -playerType, moveTo);
    if(isOver)
        GUI(b, playerType, [phase1 phase2], "GameOver", [moveFrom moveTo removedStone]);
        break; 
    end
    playerType = -playerType;
end
end

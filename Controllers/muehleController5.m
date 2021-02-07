%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Game Controller (For Human Player against AI V2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-Input-
%board:                     Nine-Men-Morris board if you wish to supply one (optional)
%startingPlayer:            Player to start the game (optional)
%phase(1):                  Phase of Player 1 (optional)
%phase(2):                  Phase of Player 2 (optional)
%stonesBeginningPhase:      How many stones there are in total left *TO LAY DOWN* in the beginning (optional)

function muehleController5(board, startingPlayer, phase, stonesBeginningPhase)

    %Determine which player begins
    if ~exist('startingPlayer','var')
        startingPlayer = 1;
        if rand()>0.5
            startingPlayer = -1; 
        end
    end
    playerType = startingPlayer;

    %Set how many stones there are in total left *TO LAY DOWN*
    if ~exist('stonesBeginningPhase','var')
        stonesBeginningPhase = 18;
    end

    %Phase of Human Player
    if ~exist('phase(1)','var')
        phase(1) = 1;
    end

    %Phase of AI
    if ~exist('phase(2)','var')
        phase(2) = 1;
    end

    %Create 3x3x3 board
    if ~exist('board','var') || size(board,1)~=3 || size(board,2)~=3 || size(board,3)~=3 %create board if nonexistent
        a = zeros(3,3,3); 
        a(2,2,:) = NaN; %NaN at every middle position since muehle has no middle position in each layer
        board=a;
    end

    moveTo = NaN;
    moveFrom = NaN;
    bestStoneRemove = NaN; %Stone to remove (AI)
    removedStone = NaN; %If a stone was removed, this stays active for one GUI call (AI)

    while 1
        %Human Player
        if playerType == 1 

            %Phase 1
            if stonesBeginningPhase>0

                %Count down stones
                stonesBeginningPhase=stonesBeginningPhase-1; 

                %Call GUI to lay stone
                [board, moveTo] = GUI(board, playerType, [phase(1) phase(2)], "move", [moveFrom moveTo removedStone]);

            %Phase 2 and 3
            elseif phase(1)==2 || phase(1)==3 %%check for phase 2 or 3

                %Call GUI to move
                [board, moveTo] = GUI(board, playerType, [phase(1) phase(2)], "move", [moveFrom moveTo removedStone]);

            end

            removedStone = NaN;

        %AI Player    
        else

            %Call GUI to tell the player that AI is calculating
            GUI(board, playerType, [phase(1) phase(2)], "waitForAI", [moveFrom moveTo removedStone]);

            [bestScore, moveFrom, moveTo, bestStoneRemove] = minimaxMuehle2(board, 0, phase(1), phase(2), playerType,stonesBeginningPhase, 1);
            if phase(2)==1
                stonesBeginningPhase=stonesBeginningPhase-1;
                board(moveTo)=playerType;
                moveFrom = NaN;
            else
                %AI knows that it loses -> makes the first move possible
                if bestScore==(Inf) 
                    possibleFrom=(find(board==playerType));
                    for i=1:numel(possibleFrom)
                        for j=1:numel(board)
                            if isValidMove(board,possibleFrom(i),j,playerType,phase(1),phase(2))
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

                %Switch Indices
                board([moveFrom moveTo])=board([moveTo moveFrom]); 

            end
        end

        %Take away opponent's stone if you have a muehle
        if checkMuehle(board,moveTo) 

            %Human Player
            if playerType==1

                %Call GUI to remove a opponent's stone
                [board, moveTo] = GUI(board, playerType, [phase(1) phase(2)], "remove", [moveFrom moveTo removedStone]);

            %AI
            else

                possibleRemoves=[];
                for l=1:numel(board)

                    %check if there are any possible stones to remove
                    if validRemove(board,playerType,l) 
                        possibleRemoves=[possibleRemoves,l];
                    end
                end
                if ~isempty(possibleRemoves)
                    if bestScore~=(Inf) 
                        board(bestStoneRemove)=0;
                        removedStone = bestStoneRemove;
                    else %AI knows that it loses -> makes the first remove possible if it makes a muehle by accident
                        board(possibleRemoves(1))=0;
                    end
                end

            end

            %Change opponent to phase 3 when they only have 3 stones remaining
            if (playerType==1 && phase(1)==2) || (playerType==-1 && phase(2)==2)||(playerType==1 && phase(1)==3) || (playerType==-1 && phase(2)==3)
                if sum(board==-playerType,'all')==3 
                    if -playerType==1
                        phase(1)=3;
                    else
                        phase(2)=3;
                    end
                end
            end
        end

        %Change Phase from 1 to 2 after all stones have been placed
        if stonesBeginningPhase==0 && phase(1) == 1 && phase(2) == 1
            phase(1)=2;
            phase(2)=2;

        end

        %Check if game is over
        isOver = evaluateMuehleBoard2(board, 0, phase(1), phase(2), -playerType, moveTo);
        if(isOver)
            GUI(board, playerType, [phase(1) phase(2)], "GameOver", [moveFrom moveTo removedStone]);
            break; 
        end
        playerType = -playerType;
    end
end

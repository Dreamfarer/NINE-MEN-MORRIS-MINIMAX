function b=muehleControler4(b,startingPlayer)
%minimal Mühle controler for two human players, I/O via Command Window
%inputs:
%  b  (default:empty) specifies a board (3x3x3, 0=empty; 1=mark pl1(white); -1=mark pl2(black))
%  startingPlayer (default:random) specifies which players (1/-1) turn it is


phase1=1;
phase2=1;
stonesBeginningPhase=18;

%Determine which player begins
if ~exist('startingPlayer','var')
    startingPlayer = 1;
    if rand()>0.5
        startingPlayer = -1; 
    end
end

%TEMPPPPPPPPPPPPPPPPPPPPPPPPPPP:
startingPlayer = -1;

%Create 3x3x3 board
if ~exist('b','var') || size(b,1)~=3 || size(b,2)~=3 || size(b,3)~=3 %create board if nonexistent
    a = zeros(3,3,3); 
    a(2,2,:) = NaN; %NaN at every middle position since muehle has no middle position in each layer
    b=a;
end

playerType = startingPlayer;

while 1
    %Human Player
    if playerType == 1 
        
        %Phase 1
        if stonesBeginningPhase>0
            
            %Count down stones
            stonesBeginningPhase=stonesBeginningPhase-1; 
            
            %Call GUI and do the magik
            [b, moveTo] = GUI(b, playerType, phase1, phase2);
            
            if stonesBeginningPhase==0
                disp('end of Phase 1');
                phase1=2;
                phase2=2;
            end
        
        %Phase 2 and 3
        elseif phase1==2 || phase1==3 %%check for phase 2 or 3
            
            [b, moveTo] = GUI(b, playerType, phase1, phase2);
            
        end
    
    %AI Player    
    else
        [bestScore, moveFrom, moveTo, bestStoneRemove] = minimaxMuehle(b, 0, phase1, phase2, playerType,stonesBeginningPhase);
        if phase2==1
            stonesBeginningPhase=stonesBeginningPhase-1;
            b(moveTo)=playerType;
        else
            b([moveFrom moveTo])=b([moveTo moveFrom]);
        end
    end
    
    if checkMuehle(b,moveTo) %take away opponent's stone if you have a muehle
        if playerType==1
            disp('spieler hat eine Mühle gemacht');
            n=0;
            for l=1:numel(b)
                if validRemove(b,playerType,l) %check if there are any possible stones to remove
                    n=n+1;
                end
            end
            if n==0
                disp('no possible stones to remove');
            else
                stoneToRemove=input('entferne Stein: ');
                while ~(validRemove(b, playerType, stoneToRemove)) 
                    stoneToRemove=input('nicht gültiger Input! Entferne Stein: ');
                    validRemove(b, playerType, stoneToRemove);
                end
                b(stoneToRemove)=0; %removes stone from board
            end
        else
            n=0;
            for l=1:numel(b)
                if validRemove(b,playerType,l) %check if there are any possible stones to remove
                    n=n+1;
                end
            end
            if n==0
            else
            b(bestStoneRemove)=0;
            disp(['AI removed stone: ' num2str(bestStoneRemove)]);
            end
        end
        if (playerType==1 && phase1==2) || (playerType==-1 && phase2==2)||(playerType==1 && phase1==3) || (playerType==-1 && phase2==3)
            if sum(b==-playerType,'all')==3 %change opponent's phase to 3 if they only have 3 stones left
                if -playerType==1
                    phase1=3;
                else
                    phase2=3;
                end
            end
        end
        
    end
    
    %Check if game is over
    isOver = evaluateMuehleBoard(b, 0, phase1, phase2, -playerType);
    if(isOver)
        disp(b);
        disp(['Player ' num2str(playerType) ' won!'])
        break; 
    end
    playerType = -playerType;
end
end

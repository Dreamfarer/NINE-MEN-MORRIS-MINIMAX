function b=muehleController2(b,startingPlayer)
%minimal Mühle controller for two human players, I/O via Command Window
%inputs:
%  b  (default:empty) specifies a board (3x3x3, 0=empty; 1=mark pl1(white);
%  -1=mark pl2(black); nan=not a valid space)
%  startingPlayer (default:random) specifies which players (1/-1) turn it is


phase1=1;
phase2=1;
stonesBeginningPhase=18;

if ~exist('startingPlayer','var')
    startingPlayer = 1;
    if rand()>0.5
        startingPlayer = -1; 
    end
end

if ~exist('b','var') || size(b,1)~=3 || size(b,2)~=3 || size(b,3)~=3 %create board if nonexistent
    a = zeros(3,3,3); 
    a(2,2,:) = NaN; %NaN at every middle position since muehle has no middle position in each layer
    b=a;
end

playerType = startingPlayer;

while 1   
    disp(b); %show current board
    
    if stonesBegnningPhase>0 %%check for phase 1
        moveTo = input(['Move of Player ' num2str(playerType) ':  ']);
        
        while ~(isValidMove(b,0,moveTo,playerType,phase1,phase2))
            moveTo = input(['Not a valid move! Move of Player ' num2str(playerType) ':  ']);
            isValidMove(b,0,moveTo,playerType,phase1,phase2);
        end
        
        %Count down stones
        stonesBeginningPhase=stonesBeginningPhase-1;
        b(moveTo) = playerType;
        
        if stonesBeginningPhase==0
            disp('end of Phase 1');
            phase1=2;
            phase2=2;
        end
        
    else %phase 2 or 3
        selectedStone = input(['Player ' num2str(playerType) ' chooses Stone: ']);
        moveTo = input('and moves it to: ');
        while ~(isValidMove(b,selectedStone,moveTo,playerType,phase1,phase2)) %check for valid input/move
            selectedStone = input(['Not a valid move! Player ' num2str(playerType) ' chooses Stone: ']);
            moveTo = input('and moves it to: ');
            isValidMove(b,0,moveTo,playerType,phase1,phase2);
        end
        b([selectedStone moveTo]) = b([moveTo selectedStone]); %switch the 2 indices
    end
    
    if checkMuehle(b,moveTo) %take away opponent's stone if you have a muehle
        disp('spieler hat eine Mühle gemacht');
        n=0;
        for i=1:numel(b) %check if there are any possible stones to remove
            if validRemove(b,playerType,i) 
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
        
        
        if sum(b==-playerType,'all')==3 %change opponent's phase to 3 if they only have 3 stones left
            if -playerType==1
                phase1=3;
            else
                phase2=3;
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

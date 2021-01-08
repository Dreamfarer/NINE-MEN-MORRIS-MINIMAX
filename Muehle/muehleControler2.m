function b=muehleControler2(b,startingPlayer)
%minimal Mühle controler for two human players, I/O via Command Window
%inputs:
%  b  (default:empty) specifies a board (3x3x3, 0=empty; 1=mark pl1(white); -1=mark pl2(black))
%  startingPlayer (default:random) specifies which players (1/-1) turn it is


phase1=1;
phase2=1;
stonesBeginningPhase=7;

if ~exist('startingPlayer','var')
    startingPlayer = 1;
    if rand()>0.5; startingPlayer = -1; end
end
if ~exist('b','var') || size(b,1)~=3 || size(b,2)~=3
    a = zeros(3,3,3); 
    a(2,2,:) = NaN; %NaN at every middle position since muehle has no middle position in each layer
    b=a;
end

playerType = startingPlayer;

while 1   
    disp(b);
    if (playerType==1 && phase1==3) || (playerType==-1 && phase2==3) %%check for phase 3
        disp([num2str(playerType) ' is in phase 3']);
        selectedStone = input(['Player ' num2str(playerType) ' chooses Stone: ']);
        moveTo = input(['and moves it to: ']);
        while ~(isValidMove(b,selectedStone,moveTo,playerType,phase1,phase2))
            selectedStone = input(['Not a valid move! Player ' num2str(playerType) ' chooses Stone: ']);
            moveTo = input(['and moves it to: ']);
            isValidMove(b,0,move,playerType,phase1,phase2);
        end
        b([selectedStone moveTo]) = b([moveTo selectedStone]);    
    end
    
    
    if (playerType==1 && phase1==2) || (playerType==-1 && phase2==2) %%check for phase 2
        
        
        selectedStone = input(['Player ' num2str(playerType) ' chooses Stone: ']);
        moveTo = input(['and moves it to: ']);
        while ~(isValidMove(b,selectedStone,moveTo,playerType,phase1,phase2))
            selectedStone = input(['Not a valid move! Player ' num2str(playerType) ' chooses Stone: ']);
            moveTo = input(['and moves it to: ']);
            isValidMove(b,0,move,playerType,phase1,phase2);
        end
        b([selectedStone moveTo]) = b([moveTo selectedStone]);
        if sum(b==-playerType,'all')==3 %change player phase if needed
            if -playerType==1
                phase1=3;
            else
                phase2=3;
            end
        end
    end
    
    if stonesBeginningPhase>0 %%check for phase 1
    move = input(['Move of Player ' num2str(playerType) ':  ']);
    while ~(isValidMove(b,0,move,playerType,phase1,phase2))
    move = input(['Not a valid move! Move of Player ' num2str(playerType) ':  ']);
    
    isValidMove(b,0,move,playerType,phase1,phase2);
    end
    stonesBeginningPhase=stonesBeginningPhase-1;
    b(move) = playerType;
    if stonesBeginningPhase==0
        disp('end of Phase 1');
        phase1=2;
        phase2=2;
    end
    end
    
   
    
    [isOver, finscore] = evaluateMuehleBoard(b, 0, phase1, phase2);
    if(isOver)
        disp(b);
        if finscore == 0
            disp('It''s a draw!')
        else 
            disp(['Player ' num2str(playerType) ' won!'])
        end
        break; 
    end
    playerType = -playerType;
   
end

end

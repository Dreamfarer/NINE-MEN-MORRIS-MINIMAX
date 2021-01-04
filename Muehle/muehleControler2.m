function b=muehleControler2(b,startingPlayer)
%minimal Mühle controler for two human players, I/O via Command Window
%inputs:
%  b  (default:empty) specifies a board (3x3x3, 0=empty; 1=mark pl1(white); -1=mark pl2(black))
%  startingPlayer (default:random) specifies which players (1/-1) turn it is


phase1=1;
phase2=1;
stonesBeginningPhase=2;

if ~exist('startingPlayer','var')
    startingPlayer = 1;
    if rand()>0.5; startingPlayer = -1; end
end
if ~exist('b','var') || size(b,1)~=3 || size(b,2)~=3
    a = zeros(3,3,3); 
    a(2,2,:) = NaN; %NaN at every middle position since muhle has no middle position in each layer
    b=a;
end

playerType = startingPlayer;

while 1   
    disp(b);
    
     if (playerType==1 && phase1==2) || (playerType==-1 && phase2==2) %%check for phase 2
        disp('we reached phase 2');
        
        selectedStone = input(['Player ' num2str(playerType) ' chooses Stone: ']);
        moveTo = input(['and moves it to: ']);
        if isValidMove(b,selectedStone,moveTo,playerType)
            %make move
        end
    end
    
    if stonesBeginningPhase>0 %%check for phase 1
    move = input(['Move of Player ' num2str(playerType) ':  ']);
    stonesBeginningPhase=stonesBeginningPhase-1;
    while ~(isfloat(move) && isscalar(move) && move>0 && move<=27 && b(move)==0)
        disp('Impossible move (must be the linear index of an empty cell). Try again');
        move = input(['Move of Player ' num2str(playerType) ' :  ']);
    end
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

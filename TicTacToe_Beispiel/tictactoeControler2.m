function b = tictactoeControler2(b,startingPlayer)
%minimal TicTacToe Controler for two human players, GUI version
%inputs:
%  b  (default:empty) specifies a board (3x3, 0=empty; 1=mark pl1(X); -1=mark pl2(O))
%  startingPlayer (default:random) specifies which players (1/-1) turn it is


if ~exist('startingPlayer','var')
    startingPlayer = 1;
    if rand()>0.5; startingPlayer = -1; end
end
if ~exist('b','var') || size(b,1)~=3 || size(b,2)~=3
    b = zeros(3,3); 
end

playerType = startingPlayer;
b = tictactoeGUImove(b,0); %show empty board

while 1
    b = tictactoeGUImove(b,playerType);    
    [isOver, finscore] = evaluateBoard(b, 0);
    if(isOver)
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


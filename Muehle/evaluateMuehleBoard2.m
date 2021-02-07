function [isOver, finscore]=evaluateMuehleBoard2(board, depth, phase1, phase2, playerType)
% evaluation function for Mühle
% input:
%   board specifies the current state of the game (3x3x3, 0=empty; 1=mark pl1(white); -1=mark pl2(black))
%   depth (default 0) allows to adjust the score by searchdepth
% output:
%   isOver specifies (0/1) if the current state is a final state
%   finscore ist the payout for the final state (positive for p1 (=1/X), negative for p2(=-1/O)



if phase1==1
isOver=0;
finscore=0;
elseif (playerType==1 && phase1==2) || (playerType==-1 && phase2==2)
    n=0;
    a=find(board==playerType);
    for i=1:numel(a)
        for j=1:numel(board)
            if isValidMove(board,a(i),j,playerType,phase1,phase2)
                n=n+1;
            end
        end
    end
    if n==0
        isOver=1;
        
        finscore=-playerType*(10-depth);
       
        
    else 
        isOver=0;
        finscore=0;
    end
elseif (playerType==1 && phase1==3) || (playerType==-1 && phase2==3)
    if numel(board(board==playerType))<3
        isOver=1;
        finscore=-playerType*(10-depth);
    else
        isOver=0;
        finscore=0;
    end
end

% disp(['finscore is: ' num2str(finscore)]);
end
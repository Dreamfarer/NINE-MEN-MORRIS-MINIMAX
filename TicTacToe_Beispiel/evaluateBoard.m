function [isOver, finscore] = evaluateBoard(board, depth)
% evaluation function for TicTacToe
% input:
%   board specifies the current state of the game (3x3, 0=empty; 1=mark pl1(X); -1=mark pl2(O))
%   depth (default 0) allows to adjust the score by searchdepth
% output:
%   isOver specifies (0/1) if the current state is a final state
%   finscore ist the payout for the final state (positive for p1 (=1/X), negative for p2(=-1/O)

if nargin < 2; depth=0; end

    isOver = 1;    
    p1marks = board == 1; 
    
    p2marks = board == -1;
    if any(sum(p1marks)==3) || any(sum(p1marks,2)==3) || ...
            sum(diag(p1marks))==3 || sum(diag(flipud(p1marks)))==3
        finscore = (10 + depth);
    elseif any(sum(p2marks)==3) || any(sum(p2marks,2)==3) || ...
            sum(diag(p2marks))==3 || sum(diag(flipud(p2marks)))==3
        finscore = -(10 + depth);
    elseif sum(board==0)==0
        finscore = 0;
    else
        isOver = 0;
        finscore = nan;
    end
end 
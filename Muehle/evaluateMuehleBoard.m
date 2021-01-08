function [isOver, finscore]=evaluateMuehleBoard(board, depth, phase1, phase2)
% evaluation function for Mühle
% input:
%   board specifies the current state of the game (3x3x3, 0=empty; 1=mark pl1(white); -1=mark pl2(black))
%   depth (default 0) allows to adjust the score by searchdepth
% output:
%   isOver specifies (0/1) if the current state is a final state
%   finscore ist the payout for the final state (positive for p1 (=1/X), negative for p2(=-1/O)




isOver=0;
finscore=NaN;


end
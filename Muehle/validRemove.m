function r=validRemove(board, playerType, stoneToRemove)
if ~(isfloat(stoneToRemove) && isscalar(stoneToRemove) && stoneToRemove>0 && stoneToRemove<=27 && board(stoneToRemove)~=0)||isnan(board(stoneToRemove))||(board(stoneToRemove)==playerType)%not possible index value, empty field, not opponent's stone
    r=0;
elseif checkMuehle(board,stoneToRemove)
    r=0;
else 
    r=1;
end
end
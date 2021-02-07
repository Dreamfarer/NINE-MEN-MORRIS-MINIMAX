function v=validRemove(board, playerType, stoneToRemove)
%checks if player can remove selected stone

if ~(isfloat(stoneToRemove) && isscalar(stoneToRemove) && stoneToRemove>0 && stoneToRemove<=27 && board(stoneToRemove)~=0)...
        ||isnan(board(stoneToRemove))||(board(stoneToRemove)==playerType)%not possible index value, empty field, not opponent's stone
    v=0;
elseif checkMuehle(board,stoneToRemove) %can't remove stones that are in a muehle
    v=0;
else 
    v=1;
end
end
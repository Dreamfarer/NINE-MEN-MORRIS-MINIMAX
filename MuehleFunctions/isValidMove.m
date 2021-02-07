function v=isValidMove(board,selectedIndex,moveToIndex, playerType, phase1,phase2)
%checks if the move made is valid

%Phase 3
if (playerType==1&&phase1==3) || (playerType==-1&&phase2==3)
    if ~(isfloat(moveToIndex) && isscalar(moveToIndex) && moveToIndex>0 && moveToIndex<=27 && board(moveToIndex)==0)...
            ||~(isfloat(selectedIndex) && isscalar(selectedIndex) && selectedIndex>0 && selectedIndex<=27)||(board(selectedIndex)~=playerType)%not possible index value, not empty field, not your stone
        v=0;
    else 
        v=1;
    end
end

%Phase 2
if (playerType==1&&phase1==2) || (playerType==-1&&phase2==2)
    [colSel,rowSel,pgSel]=ind2sub(size(board),selectedIndex);
    [~,~,pgMov]=ind2sub(size(board),moveToIndex);
   if ~(isfloat(moveToIndex) && isscalar(moveToIndex) && moveToIndex>0 && moveToIndex<=27 && board(moveToIndex)==0)...
           ||~(isfloat(selectedIndex) && isscalar(selectedIndex) && selectedIndex>0 && selectedIndex<=27)||(board(selectedIndex)~=playerType)%not possible index value, not empty field, not your stone
        v=0;
   elseif ~(abs(selectedIndex-moveToIndex)==1||abs(selectedIndex-moveToIndex)==3||abs(selectedIndex-moveToIndex)==9)%not even close to a possible move
        v=0;
   elseif (abs(selectedIndex-moveToIndex)==1) && mod(min(selectedIndex,moveToIndex),3)==0 %bottom of one column to top of next column (3 can't move to 4)
        v=0;
   elseif (abs(selectedIndex-moveToIndex)==3) && (pgSel~=pgMov) %"horizontal" movement crosses page (7 can't move to 10)
        v=0;
   elseif (abs(selectedIndex-moveToIndex)==9) && ((rowSel==1&&colSel~=2)||(rowSel==3&&colSel~=2)) %diagonal move
        v=0;
   else 
        v=1;
   end
end

%Phase 1
if (playerType==1&&phase1==1) || (playerType==-1&&phase2==1)
    if ~(isfloat(moveToIndex) && isscalar(moveToIndex) && moveToIndex>0 ...
            && moveToIndex<=27 && board(moveToIndex)==0) %not possible index value, not empty field
    v = 0;
    else 
    v=1;
    end
end
end


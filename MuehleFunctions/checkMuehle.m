function m=checkMuehle(board,moveToIndex)
%checks if player made a mühle with his recent move

[colIdx, rowIdx,pgIdx]=ind2sub(size(board),moveToIndex);
if moveToIndex==0
    m=0;
elseif abs(sum(board(colIdx,:,pgIdx))) == 3 || abs(sum(board(:,rowIdx,pgIdx))) == 3 || (abs(sum(board(colIdx,rowIdx,:))) == 3 && (colIdx==2||rowIdx==2)) %all muehle cases
    m=1;
else
    m=0;
end
end
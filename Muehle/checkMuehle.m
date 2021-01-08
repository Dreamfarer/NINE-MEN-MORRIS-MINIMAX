function m=checkMuehle(board,moveToIndex)
[colIdx, rowIdx,pgIdx]=ind2sub(size(board),moveToIndex);
if abs(sum(board(colIdx,:,pgIdx))) == 3 || abs(sum(board(:,rowIdx,pgIdx))) == 3 || (abs(sum(board(colIdx,rowIdx,:))) == 3 && (colIdx==2||rowIdx==2)) %all muehle cases
    m=1;
else
    m=0;
end
end
function indexCalculated = CalcIndex(index, mode)
%Translate Luca's Matrix into GUI matrix

%Matrix Luca with linear indexing
A = [
	1 NaN NaN 4 NaN NaN 7; 
	NaN 10 NaN 13 NaN 16 NaN; 
	NaN NaN 5 22 25 NaN NaN; 
	2 11 20 NaN 20 17 8; 
	NaN NaN 21 24 27 NaN NaN; 
	NaN 12 NaN 15 NaN 18 NaN; 
	3 NaN NaN 6 NaN NaN 9
	];

if (mode == "Controller_To_GUI")
    
    %Find the wanted index and give back the linear indice of Gianluca
    indexCalculated = find(A == index);
    
elseif (mode == "GUI_To_Controller")
    
    indexCalculated = A(index);

else
     indexCalculated = "Error";
     return
end

end


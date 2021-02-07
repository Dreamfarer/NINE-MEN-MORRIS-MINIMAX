%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matrix of Luca to 7x7 Figure-Matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-Input-
%x:                     Linear index
%y:                     1: x-value, 2: y-value of given linear index
%mode("rectangle"):     This mode adds -0.25 because of aligement reasons
%mode("line"):          Nothing is added to the coordinates

function position = matrixToPosition(x, y, mode)

    %Linear Index of Luca 3x3x3
    A = [
        0 6; %1
        0 3; %2
        0 0; %3
        3 6; %4
        NaN NaN; %5 
        3 0; %6
        6 6; %7
        6 3; %8
        6 0; %9
        1 5; %10
        1 3; %11
        1 1; %12
        3 5; %13
        NaN NaN; %14 
        3 1; %15
        5 5; %16
        5 3; %17
        5 1; %18
        2 4; %19
        2 3; %20
        2 2; %21
        3 4; %22
        NaN NaN; %23 
        3 2; %24
        4 4; %25
        4 3; %26
        4 2; %27
        ];

    if mode == "rectangle"
        position = A(x,y)-0.25;
    elseif mode == "line"
        position = A(x,y);
    end

end
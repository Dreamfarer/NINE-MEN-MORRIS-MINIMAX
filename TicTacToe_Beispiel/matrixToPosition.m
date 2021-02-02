function position = matrixToPosition(index, mode)

%Get index of Luca's matrix and return the cooresponding 2D position

A = [
    0 6;
    0 3; 
    0 0;
    3 6;
    NaN NaN;
    3 3;
    6 6;
    6 3;
    6 0;
    1 5;
    1 3;
    1 1;
    3 5;
    NaN NaN;
    3 1;
    5 5;
    5 3;
    5 1;
    2 4;
    2 3;
    2 2;
    3 4;
    NaN NaN;
    3 2;
    4 4;
    4 3;
    4 2;
];

position = A-0.25

end
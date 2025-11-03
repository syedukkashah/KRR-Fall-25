% Syed Ukkashah Ahmed Shah
% 23K-0055
% BAI - 5A
% Q4

% tried my best to implement Kakuro solver, but was unable to get it fully working. 
% Below is my attempt. 

% Main predicate to solve Kakuro 
solve_kakuro(Grid) :-
    % Start filling from first row with variables
    fill_rows(Grid, 1). % Start at row 1 

% Fill each row with digits 
fill_rows(Grid, Row) :-
    length(Grid, Rows),
    Row >= Rows, !. % Base case: past last row
fill_rows(Grid, Row) :-
    nth0(Row, Grid, [Sum|Cells]), % Get row sum and cells
    fill_row(Cells, Sum, Filled), % Fill cells to match sum
    replace_row(Grid, Row, [Sum|Filled], NewGrid), % Update grid
    NextRow is Row + 1,
    fill_rows(NewGrid, NextRow).

% Fill a row to match sum 
fill_row([], _, []). % Base case: no cells left
fill_row([Var|Rest], Sum, [Var|FilledRest]) :-
    var(Var), % If variable, assign a digit
    between(1, 9, Var), % Try digits 1-9 
    sum_list([Var|Rest], CurrentSum), % Check current sum
    CurrentSum =< Sum, % Ensure sum not exceeded 
    fill_row(Rest, Sum, FilledRest). % Recurse
fill_row([Num|Rest], Sum, [Num|FilledRest]) :-
    number(Num), % Keep existing numbers
    fill_row(Rest, Sum, FilledRest).

% Replace row in grid 
replace_row([], _, _, []). % Base case
replace_row([_|Rest], 1, NewRow, [NewRow|Rest]). % Replace at row 1
replace_row([Row|Rest], RowNum, NewRow, [Row|NewRest]) :-
    RowNum > 1,
    NextRow is RowNum - 1,
    replace_row(Rest, NextRow, NewRow, NewRest).

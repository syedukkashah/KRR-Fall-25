% Syed Ukkashah Ahmed Shah
% 23K-0055
% BAI - 5A
% Q3

% I have attempted to explain my logic for the recursive predicates through my comments 
% attempted to use DFS below to solve the island counting problem


% starting from [0,0]
count_islands(Grid, TotalIslands) :- 
    scan_grid(Grid, Grid, 0, 0, [], 0, TotalIslands).

% reached end of all rows
scan_grid(_, CurrentGrid, RowNum, _, Visited, IslandCount, IslandCount) :-
    length(CurrentGrid, TotalRows),
    RowNum >= TotalRows.

% Finished current row - move to next row, reset col to 0
scan_grid(OrigGrid, CurrentGrid, RowNum, ColNum, Visited, IslandCount, FinalCount) :-
    nth0(RowNum, CurrentGrid, CurrentRow),
    length(CurrentRow, TotalCols),
    ColNum >= TotalCols,
    NextRow is RowNum + 1,
    scan_grid(OrigGrid, CurrentGrid, NextRow, 0, Visited, IslandCount, FinalCount).

% Check current cell
scan_grid(OrigGrid, CurrentGrid, RowNum, ColNum, Visited, IslandCount, FinalCount) :-
    nth0(RowNum, CurrentGrid, CurrentRow),
    nth0(ColNum, CurrentRow, CellValue),
    NextCol is ColNum + 1,
    (   CellValue = 1, \+ member((RowNum, ColNum), Visited) ->
        % If new land found (cell = 1) and not visited, mark entire island and increment island count
        mark_island(CurrentGrid, RowNum, ColNum, Visited, NewVisited),
        NewCount is IslandCount + 1,
        scan_grid(OrigGrid, CurrentGrid, RowNum, NextCol, NewVisited, NewCount, FinalCount)
    ;
        % if water or visited, we continue
        scan_grid(OrigGrid, CurrentGrid, RowNum, NextCol, Visited, IslandCount, FinalCount)
    ).

% Stop if out of bounds (negative position)
mark_island(Grid, RowNum, ColNum, Visited, Visited) :-
    (RowNum < 0 ; ColNum < 0), !.

% Stop if position doesn't exist in grid
mark_island(Grid, RowNum, ColNum, Visited, Visited) :-
    (\+ nth0(RowNum, Grid, _) ; 
     nth0(RowNum, Grid, Row), \+ nth0(ColNum, Row, _)), !.

% Stop if cell is water or already visited
mark_island(Grid, RowNum, ColNum, Visited, Visited) :-
    nth0(RowNum, Grid, Row),
    nth0(ColNum, Row, CellValue),
    (CellValue = 0 ; member((RowNum, ColNum), Visited)), !.

% once land is found we add it to visited and explore 4 neighbors
mark_island(Grid, RowNum, ColNum, Visited, NewVisited) :-
    nth0(RowNum, Grid, Row),
    nth0(ColNum, Row, 1),
    % Add this cell to visited
    append(Visited, [(RowNum, ColNum)], Visited1),
    % Explore 4 directions from this cell
    Up is RowNum - 1, 
    mark_island(Grid, Up, ColNum, Visited1, Visited2),
    Down is RowNum + 1, 
    mark_island(Grid, Down, ColNum, Visited2, Visited3),
    Left is ColNum - 1, 
    mark_island(Grid, Left, RowNum, Visited3, Visited4),
    Right is ColNum + 1, 
    mark_island(Grid, Right, RowNum, Visited4, NewVisited).

% we basically start at [0,0] and scan each cell from left to right and top to bottom.
% when a 1 is encountered, island count is incremented and all connected cells are added to visited list using dfs
% we continue scanning grid, skipping visited cells, and return total count at the end
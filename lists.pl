max(X,Y,Max) :- 
    X>=Y,
    Max is X;
    Max is Y.

min(X,Y,Min):-
X>Y,
Min is Y;
Min is X.

resistance_in_series(R1,R2,Res):-
    Res is R1+R2.

resistance_in_parallel(R1,R2,Res):-
    Res is ((R1*R2)/(R1+R2)).


list_length([], 0).
list_length([H|T], N):-
    list_length(T, N1), 
    N is N1+1.

list_concat([], L, L).
list_concat([H|T], L2, [H|L3]):-
    list_concat(T, L2, L3).

% in words
in_words[(0, 'zero'), [1, 'one'], [2, 'two'], [3, 'three'], [4, 'four'], 
        [5, 'five'], [6, 'six'], [7, 'seven'], [8, 'eight'], [9, 'nine']].

digit_to_word(Digit, Word):-
    Word_List(in_words),
    member([Digit, Word], Word_List).


func(X, [X], []).
func(X, [X|T], T).
func(X, [H|T1], [H|T2]):- func(X, T1, T2).

func2([], []).
func2([X|L], P):- func2


func3(X, [], X).
func3(X, [H|T1], [H|T2]):-func3(X,T1,T2).


% Utility: Get number of rows
num_rows(Grid, Rows) :-
    length(Grid, Rows).

% Utility: Get number of columns (assumes rectangular grid)
num_cols(Grid, Cols) :-
    Grid = [FirstRow|_],
    length(FirstRow, Cols).

% Check if position (R, C) is land (1)
is_land(Grid, R, C) :-
    nth0(R, Grid, Row),
    nth0(C, Row, 1).

% Check if position (R, C) is valid (within bounds)
valid_pos(Grid, R, C) :-
    num_rows(Grid, Rows),
    num_cols(Grid, Cols),
    R >= 0, R < Rows,
    C >= 0, C < Cols.

% Generate neighbors (up, down, left, right)
neighbors(R, C, NR, NC) :-
    member((DR, DC), [(-1,0), (1,0), (0,-1), (0,1)]),
    NR is R + DR,
    NC is C + DC.

% DFS to explore one island, accumulating visited positions
dfs(Grid, (R, C), VisitedIn, VisitedOut) :-
    \+ member((R, C), VisitedIn),  % Not already visited
    is_land(Grid, R, C),           % Must be land
    append(VisitedIn, [(R, C)], VisitedTmp),  % Add current to visited
    findall((NR, NC), (neighbors(R, C, NR, NC), valid_pos(Grid, NR, NC)), Neighs),
    dfs_list(Grid, Neighs, VisitedTmp, VisitedOut).  % Recurse on neighbors

% Helper for DFS on a list of positions
dfs_list(_, [], Visited, Visited).
dfs_list(Grid, [Pos|Rest], VisitedIn, VisitedOut) :-
    dfs(Grid, Pos, VisitedIn, VisitedMid),
    dfs_list(Grid, Rest, VisitedMid, VisitedOut).

% Process all positions, counting islands
process([], _, Visited, Count, Count, Visited).  % Base case
process([(R, C)|Rest], Grid, VisitedIn, CountIn, CountOut, VisitedOut) :-
    (   member((R, C), VisitedIn)
    ->  CountMid = CountIn, VisitedMid = VisitedIn  % Already visited, skip
    ;   is_land(Grid, R, C)
    ->  dfs(Grid, (R, C), VisitedIn, VisitedNew),   % New island: explore and count
        CountMid is CountIn + 1,
        VisitedMid = VisitedNew
    ;   CountMid = CountIn, VisitedMid = VisitedIn  % Water, skip
    ),
    process(Rest, Grid, VisitedMid, CountMid, CountOut, VisitedOut).

% Main predicate: Count islands
count_islands(Grid, Count) :-
    num_rows(Grid, Rows),
    num_cols(Grid, Cols),
    findall((R, C), (between(0, Rows-1, R), between(0, Cols-1, C)), AllPositions),
    process(AllPositions, Grid, [], 0, Count, _).  % _ for final visited (unused)
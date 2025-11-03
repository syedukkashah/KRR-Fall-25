min(X,Y,Min):-
X>Y,
Min is Y;
Min is X.

resistance_in_series(R1,R2,Res):-
    Res is R1+R2.

resistance_in_parallel(R1,R2,Res):-
    Res is ((R1*R2)/(R1+R2)).

list_member([X|T], X).
list_member([_|T], X) :- list_member(T, X).


list_concat([], L2, L2). 
list_concat([X|T1], L2, [X|T3]) :- list_concat(T1, L2, T3).

% sequence of queries to delete first and last 3 elements of a list
% ?- list_concat([1,2,3], L, [1,2,3,4,5,6,7,8,9]), list_concat(L2, [7,8,9], L).
% L = [4, 5, 6, 7, 8, 9],
% L2 = [4, 5, 6] ;  -> result

add(X, L, [X|L]).

del(X, [X|T], T).
del(X, [H|T], [H|T1]) :- del(X, T, T1).

is_sublist(S,L):-
    list_concat(L1, L2, L), 
    list_concat(S, L3, L2).


listLen([], 0).
listLen([_|T], N) :- listLen(T, N1), N is N1 + 1.
evenLength([H|T]):-
    listLen([H|T], X),
    (X mod 2 =:= 0).
    
oddLength([H|T]):-
    listLen([H|T], X),
    (X mod 2 =\= 0).
    
reverse([], L, L).
reverse([H|T], L2, L3) :-
    reverse(T, [H|L2], L3). %keep adding the head until base case is reached

my_max(X,Y,Max):- (X > Y), Max is X; Max is Y.

listmax([X], X).
listmax([H|T], Max) :- listmax(T, TailMax),(H > TailMax -> Max = H; Max = TailMax).

sumList([X], X).
sumList([X|T], Sum) :- sumList(T, SumTail), Sum is X + SumTail.

ordered([]).
ordered([X]).
ordered([X, X2|T]) :- ordered([X2|T]), X =< X2.

isSubset([], []).
isSubset([H|T], [H|T2]) :- isSubset(T, T2). %include H
isSubset([_|T], T2) :- isSubset(T,T2). %exclude H

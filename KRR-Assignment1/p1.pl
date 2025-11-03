% Syed Ukkashah Ahmed Shah
% 23K-0055
% BAI - 5A
% Q1

% Operator declarations for union, intersection, and power set
:- op(650, xfy, union).      % Infix for union
:- op(650, xfy, intersect).  % Infix for intersection
:- op(700, fx, power).       % Prefix for power set

% I have attempted to explain my logic for the recursive predicates through my comments 
% I know that a list is made up of a head an a tail for eg. [a,b,c,d] -> head = a, tail = [b,c,d]
% the tail is a list in itself, so it will have it's own head, and so on

set_member(X,[X|_]).  %Base case -> the target element is the head of the list 
set_member(X,[_|Tail]) :- set_member(X,Tail). %Recursive case -> the target element is in the tail of the list 

% check if a list contains only distinct elements (is a valid set) 
is_set([]).  % empty list is a valid set
is_set([H|T]) :- 
    \+ set_member(H, T),  % head must not appear in tail
    is_set(T).             % tail must also be a valid set

% Implemented the set validation rule in each set operation predicate to ensure that the inputs being passed in from the console are valid

set_union([],S,S). %base case -> if the 1st list is empty, then the union is the 2nd list in it's entirety

set_union([H|S1], S2, S):-
    is_set(S2), 
    is_set([H|S1]), 
   set_member(H,S2), % we check if head of the 1st list is in the 2nd list 
   set_union(S1, S2, S). %if it is, we skip it and continue w/ tail of 1st list

set_union([H|S1], S2, [H|S]):-
    is_set(S2), 
    is_set([H|S1]),
% if head of 1st list is not in 2nd list (/+ is used to negate the result, so if it returns false, 
% it means 1st list head isn't in 2nd list, which is what we want for this case)
    \+ set_member(H,S2), 
    set_union(S1, S2, S).

set_cardinality([], 0). %base case -> if list is empty, cardinality is 0

set_cardinality([H|Tail], N):- % FIXED: changed _ to H so we can validate the full list
    is_set([H|Tail]), 
    set_cardinality(Tail, N1), % recursive call on tail
    N is N1+1. %increment count by 1 for each head encountered 

set_intersection([], _, []). %base case logic -> if first list is empty, then the intersection of the two lists is also empty (since there are no elements in common b/w the two lists)

set_intersection([X|Tail1], S2, [X|Tail3]):-
    is_set([X|Tail1]), 
    is_set(S2), 
    set_member(X,S2), % check if head of 1st list in 2nd list
    set_intersection(Tail1, S2, Tail3). % if it is, include it in the intersection list and continue w/ tail of 1st list

set_intersection([X|Tail1], S2, Tail3):-
    is_set([X|Tail1]),
    is_set(S2), 
    \+ set_member(X,S2), % check if head of 1st list is not in 2nd list
    set_intersection(Tail1, S2, Tail3). % if it is not, then skip it and continue w/ tail of 1st list

set_difference([], _, []). %if 1st list is empty, difference is empty

set_difference([X|Tail1], S2, Tail3):- %(S1 - S2) = S3
    is_set([X|Tail1]),
    is_set(S2), 
    set_member(X,S2), %if head of S1 is in S2
    set_difference(Tail1, S2, Tail3). %skip it and continue w/ tail of S1

set_difference([X|Tail1], S2, [X|Tail3]):- %(S1 - S2) = S3
    is_set([X|Tail1]),
    is_set(S2), 
    \+ set_member(X,S2), %if head of S1 is not in S2
    set_difference(Tail1, S2, Tail3). %include it S3 and continue w/ tail of S1


power_set([], [[]]). %base case -> power set of empty set is a set containing an empty set
power_set([H|T], Power):- 
    is_set([H|T]), % validate input is a valid set
    power_set(T, PowerT), % recursive call on tail to get power set of tail
    add_element_to_each(H, PowerT, WithH), % add head to each subset of tail's power set
    append(PowerT, WithH, Power). % combine subsets without and with head

% power_set: Add element to each subset
add_element_to_each(_, [], []). %base case -> no subsets, return empty
add_element_to_each(E, [S|Rest], [[E|S]|WithRest]):- % add element E to subset S
    add_element_to_each(E, Rest, WithRest). % recurse on remaining subsets


% Evaluate union operator - makes 'union' actually call set_union
eval(S1 union S2, Result) :-
    eval(S1, E1),
    eval(S2, E2),
    set_union(E1, E2, Result).

% Evaluate intersection operator - makes 'intersect' actually call set_intersection
eval(S1 intersect S2, Result) :-
    eval(S1, E1),
    eval(S2, E2),
    set_intersection(E1, E2, Result).

% Evaluate power set operator - makes 'power' actually call power_set
eval(power S, Result) :-
    eval(S, E),
    power_set(E, Result).

% Base case: if it's already a list, return it
eval(S, S) :- is_list(S).

% You can test the operator with queries like:

% eval([a,b] union [c,d], Result).
% eval([1,2,3] intersect [2,3,4], Result).
% eval(power [a,b], Result).


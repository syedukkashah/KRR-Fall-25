family(
    person(tom, fox, date(7,may,1950), works(bbc,15200) ),
    person(ann, fox, date(9,may,1951), unemployed),
        [ person(pat, fox, date(5,may,1973), unemployed),
        person(jim, fox, date(5,may,1973), unemployed) ] ).

husband(X) :- 
    family(X,_,_).

wife(X):-
    family(_,X,_).

child(X):-
    family(_,_,Children),
    list_member(X,Children).

list_member(X,[X|L]).
list_member(X, [Y|L]) :- list_member(X, L).

exists(Person):-
    husband(Person);
    wife(Person);
    child(Person).

dateOfBirth(person(_,_,Date,_), Date).
salary(person(_,_,_,works(_,S)), S).
salary(person(_,_,_,unemployed), 0).

%?- family(person(Name,Surname, _, _), _, []). names of families without children
%?- family(_, _, Children), member(person(_, _, _, works(_, _)), Children). employed children

%all the children whose parents differ in age by at least 15 years.
% child(X),
%family(person(_,_,date(_,_,A),_), person(_,_,date(_,_,B),_), X),
%Diff is B - A,
%Diff >= 15.

nthMember(1, [X|_], X).             % Base case: the 1st element is the head
nthMember(N, [_|T], X) :-           
    N > 1,                           % ensure N is greater than 1
    N1 is N - 1,                     % decrease N by 1
    nthMember(N1, T, X).            % recurse on the tail

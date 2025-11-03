% Syed Ukkashah Ahmed Shah
% 23K-0055
% BAI - 5A
% Q2

% I have attempted to explain my logic for the recursive predicates through my comments 

% representing roman numbers as a list and mapped them to their decimal values
roman_numerals([[i, 1],[v,5], [x,10], [l,50], [c,100], [d,500], [m,1000]]).

get_roman_val([], 0). %base case -> if list is empty, value is 0

get_roman_val(Symbol, Val):-
    roman_numerals(Num_List), %retrieving list of roman numerals
    member([Symbol, Val], Num_List). %using the member function to get the value of the symbol

%as per the rules stated in the assignment, no symbol can appear more than 3 times.
% according to that logic, Any list of length <=3 will always be valid 
is_valid([]).  % Empty list is valid
is_valid([_]).  % Single element is valid
is_valid([A,A,A,A|_]) :- !, fail.  % if repeated more than 3 times in a row, cut and fail
is_valid([_|T]) :- is_valid(T).  % Otherwise, check the rest


get_decimal([], 0). %base case -> if list is empty, value is 0

get_decimal([H], Val):- %also checking for single element
    get_roman_val(H, Val).

get_decimal([H1|[H2|T]], Val):- 
    is_valid([H1|[H2|T]]), %first we check if the roman numeral list is valid
    get_roman_val(H1,H1_val), %first, I retrieve the val of the head symbol
    get_roman_val(H2, H2_val), %then, I retrieve the val of the 2nd symbol (head of tail)
    get_decimal([H2|T], T_val), %recursive call on the tail to get it's values
    (H1_val >= H2_val -> Val is H1_val + T_val; %if head val >= next element val (head of tail val), add them. If not, subtract them as per roman numeral rules.
    Val is T_val - H1_val). % i am basically using an if-else condition here to check whether to add or subtract value at curr index with next index value 




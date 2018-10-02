%--------------------------------------------------------------%
%   Informed Graph Searching Algorithms                        %
%   The graph should be represented as a set of facts          %
%   arc(Node1,Node2,Cost) loaded in the database               %
%   (C) 1998 Zdravko Markov                                    %
%--------------------------------------------------------------%

%--------------------------------------------------------------%
%   Best-First Search                                          %
%   call: best_first(+[[Start]],+Goal,-Path,-ExploredNodes).   %
%--------------------------------------------------------------%
best_first([[Goal|Path]|_],Goal,[Goal|Path],0).
best_first([Path|Queue],Goal,FinalPath,N) :-
    extend(Path,NewPaths), 
    append(Queue,NewPaths,Queue1),
    sort_queue1(Queue1,NewQueue), wrq(NewQueue),
    best_first(NewQueue,Goal,FinalPath,M),
    N is M+1.

extend([Node|Path],NewPaths) :-
    findall([NewNode,Node|Path],
            (arc(Node,NewNode,_), 
            \+ member(NewNode,Path)), % for avoiding loops
            NewPaths).

sort_queue1(L,L2) :-
    swap1(L,L1), !,
    sort_queue1(L1,L2).
sort_queue1(L,L).

swap1([[A1|B1],[A2|B2]|T],[[A2|B2],[A1|B1]|T]) :-
    hh(A1,W1),
    hh(A2,W2),
    W1>W2.
swap1([X|T],[X|V]) :-
    swap1(T,V).

%--------------------------------------------------------------%
%   Heuristic functions                                        %
%--------------------------------------------------------------%

% check if the heuristic function is ok.
hh(State, Value) :- 
    h(State,Value),
    number(Value), !.
hh(State, Value) :- 
   write('Incorrect heuristic functionh: '),
   write(h(State, Value)), nl,
   abort.

%--------------------------------------------------------------%

wrq(Q) :- length(Q,N), writeln(N).



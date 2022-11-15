#!/bin/gprolog --consult-file

:- include('data.pl').

lte(time(_,_,am),time(_,_,pm)).
lte(time(Hour3,_,Period3),time(Hour1,_,Period1)) :- Hour3 < Hour1, Period3 == Period1.
lte(time(Hour3,Min3,Period3),time(Hour1,Min1,Period1)) :- Hour3 == Hour1, Min3 =< Min1, Period3 == Period1.

gte(time(_,_,pm),time(_,_,am)).
gte(time(Hour4,_,Period4),time(Hour2,_,Period2)) :- Hour4 > Hour2, Period4 == Period2.
gte(time(Hour4,Min4,Period4),time(Hour2,Min2,Period2)) :- Hour4 == Hour2, Min4 >= Min2, Period4 == Period2.

meetone(Person, slot(Time1, Time2)) :- free(Person, slot(Time3,Time4)), lte(Time3,Time1), gte(Time4,Time2).

main :- findall(Person,
		meetone(Person,slot(time(11,30,am),time(3,00,pm))),
		People),
	write(People), nl, halt.

/* main :- lte(time(10,00,am),time(9,30,am)), write('true'), nl, halt. */
/* main :- gte(time(10,00,am),time(9,30,am)), write('true'), nl, halt. */

:- initialization(main).

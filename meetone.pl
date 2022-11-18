#!/bin/gprolog --consult-file
/*
 *  author: Tony Nielsen
 *  course: CS-354
 *	assignment: LA-3
 *	date: 11-15-2022
 */

:- include('data.pl').

/* This less than or equal to function takes in two times and outputs true if the free time is earlier than or 
equal to the requested time */
lte(time(_,_,am),time(_,_,pm)).
lte(time(Hour3,_,Period3),time(Hour1,_,Period1)) :- Hour3 < Hour1, Period3 == Period1.
lte(time(Hour3,Min3,Period3),time(Hour1,Min1,Period1)) :- Hour3 == Hour1, Min3 =< Min1, Period3 == Period1.

/* This greater than or equal to function takes in two times and outputs true if the free time is later than or 
equal to the requested time */
gte(time(_,_,pm),time(_,_,am)).
gte(time(Hour4,_,Period4),time(Hour2,_,Period2)) :- Hour4 > Hour2, Period4 == Period2.
gte(time(Hour4,Min4,Period4),time(Hour2,Min2,Period2)) :- Hour4 == Hour2, Min4 >= Min2, Period4 == Period2.

/* This meet function takes in a requested slot time and compares this to the data file line by line to see if there is any
person that can meet at that time. In this calculation it uses a less than or equal to as well as a greater than or equal to 
functions to ensure that the requested time falls within the available time for the person. */
meetone(Person, slot(Time1, Time2)) :- free(Person, slot(Time3,Time4)), lte(Time3,Time1), gte(Time4,Time2).

main :- findall(Person,
		meetone(Person,slot(time(11,30,am),time(3,00,pm))),
		People),
	write(People), nl, halt.

%Unit tests
/* main :- lte(time(10,00,am),time(9,30,am)), write('true'), nl, halt. */
/* main :- gte(time(10,00,am),time(9,30,am)), write('true'), nl, halt. */

:- initialization(main).

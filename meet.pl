#!/bin/gprolog --consult-file
/*
 *  author: Tony Nielsen
 *  course: CS-354
 *	assignment: LA-3
 *	date: 11-15-2022
 */

:- include('data.pl').
:- include('uniq.pl').

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

/* This block contains 4 individual cases to check for overlap between two peoples free time, two that are complete overlap and two that are partial overlap */
overlap(slot(Time1,Time2),slot(Time3,Time4), Slot) :- gte(Time3,Time1), lte(Time2,Time4), lte(Time3,Time2), Time3 \== Time2, Slot = slot(Time3, Time2).
overlap(slot(Time1,Time2),slot(Time3,Time4), Slot) :- gte(Time1,Time3), lte(Time4,Time2), lte(Time1,Time4), Time1 \== Time4, Slot = slot(Time1, Time4).
overlap(slot(Time1,Time2),slot(Time3,Time4), Slot) :- gte(Time3,Time1), lte(Time4,Time2), lte(Time3,Time4), Time3 \== Time4, Slot = slot(Time3, Time4).
overlap(slot(Time1,Time2),slot(Time3,Time4), Slot) :- gte(Time1,Time3), lte(Time2,Time4), lte(Time1,Time2), Time1 \== Time2, Slot = slot(Time1, Time2).

/* This list instantiates the people to be selected to find a meeting between */
people([ann,bob,carla]).

/* This block creates the code to create a different length list for each of the possible combinations of people within the set
a two, three, four, as well as a five person implementation to later be compared with the inputed list later in the main meet function */
group2(Person1, Person2, Group) :- Group = [Person1, Person2].
group3(Person1, Person2, Person3, Group) :- Group = [Person1, Person2, Person3].
group4(Person1, Person2, Person3, Person4, Group) :- Group = [Person1, Person2, Person3, Person4].
group5(Person1, Person2, Person3, Person4, Person5, Group) :- Group = [Person1, Person2, Person3, Person4, Person5].

/* This block creates the logic to find the meeting times that would work between several different peoples' schedules. It includes the
ability to take in any amount of people from 2-5 which is the amount of people within the data set that we have been given. It takes in
two people, finds the overlap in their schedule and then continues if more than two are in to overlap the found overlap with the new schedule
until list is exhsausted. */
meet(Slot) :- free(Person1,slot(Time1,Time2)), free(Person2,slot(Time3,Time4)), group2(Person1, Person2, Group), people(L), 
Group == L, overlap(slot(Time1,Time2), slot(Time3,Time4), Slot).
meet(Slot) :- free(Person1,slot(Time1,Time2)), free(Person2,slot(Time3,Time4)), free(Person3,slot(Time5,Time6)), group3(Person1, Person2, Person3, Group), people(L), 
Group == L, overlap(slot(Time1,Time2), slot(Time3,Time4), Slot1), overlap(Slot1, slot(Time5,Time6), Slot).
meet(Slot) :- free(Person1,slot(Time1,Time2)), free(Person2,slot(Time3,Time4)), free(Person3,slot(Time5,Time6)), free(Person4,slot(Time7,Time8)), group4(Person1, Person2, Person3, Person4, Group), people(L), 
Group == L, overlap(slot(Time1,Time2), slot(Time3,Time4), Slot1), overlap(Slot1, slot(Time5,Time6), Slot2), overlap(Slot2, slot(Time7,Time8), Slot).
meet(Slot) :- free(Person1,slot(Time1,Time2)), free(Person2,slot(Time3,Time4)), free(Person3,slot(Time5,Time6)), free(Person4,slot(Time7,Time8)), free(Person5,slot(Time9,Time10)), group5(Person1, Person2, Person3, Person4, Person5, Group), people(L), 
Group == L, overlap(slot(Time1,Time2), slot(Time3,Time4), Slot1), overlap(Slot1, slot(Time5,Time6), Slot2), overlap(Slot2, slot(Time7,Time8), Slot3), overlap(Slot3, slot(Time9,Time10), Slot).


main :- findall(Slot, meet(Slot), Slots),
        uniq(Slots, Uniq),
        write(Uniq), nl, halt.
    
%Unit Tests
/* main :- overlap(slot(time(9,00,am),time(9,30,am)),slot(time(9,15,am),time(9,45,am)), Slot), write(Slot), nl, halt. */
/* main :- overlap(slot(time(9,15,am),time(9,45,am)),slot(time(9,00,am),time(9,40,am)), Slot), write(Slot), nl, halt. */
/* main :- overlap(slot(time(9,20,am),time(9,35,am)),slot(time(9,15,am),time(9,45,am)), Slot), write(Slot), nl, halt. */

:- initialization(main).

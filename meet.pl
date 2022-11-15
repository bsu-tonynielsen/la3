#!/bin/gprolog --consult-file

:- include('data.pl').
:- include('uniq.pl').

lte(time(_,_,am),time(_,_,pm)).
lte(time(Hour3,_,Period3),time(Hour1,_,Period1)) :- Hour3 < Hour1, Period3 == Period1.
lte(time(Hour3,Min3,Period3),time(Hour1,Min1,Period1)) :- Hour3 == Hour1, Min3 =< Min1, Period3 == Period1.

gte(time(_,_,pm),time(_,_,am)).
gte(time(Hour4,_,Period4),time(Hour2,_,Period2)) :- Hour4 > Hour2, Period4 == Period2.
gte(time(Hour4,Min4,Period4),time(Hour2,Min2,Period2)) :- Hour4 == Hour2, Min4 >= Min2, Period4 == Period2.

overlap(slot(Time1,Time2),slot(Time3,Time4), Slot) :- gte(Time3,Time1), lte(Time2,Time4), lte(Time3,Time2), Time3 \== Time2, Slot = slot(Time3, Time2).
overlap(slot(Time1,Time2),slot(Time3,Time4), Slot) :- gte(Time1,Time3), lte(Time4,Time2), lte(Time1,Time4), Time1 \== Time4, Slot = slot(Time1, Time4).
overlap(slot(Time1,Time2),slot(Time3,Time4), Slot) :- gte(Time3,Time1), lte(Time4,Time2), lte(Time3,Time4), Time3 \== Time4, Slot = slot(Time3, Time4).
overlap(slot(Time1,Time2),slot(Time3,Time4), Slot) :- gte(Time1,Time3), lte(Time2,Time4), lte(Time1,Time2), Time1 \== Time2, Slot = slot(Time1, Time2).

people([ann,bob,carla,dave,ed]).
group2(Person1, Person2, Group) :- Group = [Person1, Person2].
group3(Person1, Person2, Person3, Group) :- Group = [Person1, Person2, Person3].
group4(Person1, Person2, Person3, Person4, Group) :- Group = [Person1, Person2, Person3, Person4].
group5(Person1, Person2, Person3, Person4, Person5, Group) :- Group = [Person1, Person2, Person3, Person4, Person5].

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
    
/* main :- overlap(slot(time(9,00,am),time(9,30,am)),slot(time(9,15,am),time(9,45,am)), Slot), write(Slot), nl, halt. */
/* main :- overlap(slot(time(9,15,am),time(9,45,am)),slot(time(9,00,am),time(9,40,am)), Slot), write(Slot), nl, halt. */
/* main :- overlap(slot(time(9,20,am),time(9,35,am)),slot(time(9,15,am),time(9,45,am)), Slot), write(Slot), nl, halt. */

:- initialization(main).

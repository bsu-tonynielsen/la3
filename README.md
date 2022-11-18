# Language Assignment #3: Prolog

* Author: Tony Nielsen
* Class: CS354 Section 2
* Semester: Fall 2022

## Overview

This assignment uses the language Prolog and asks us to create two programs, one that finds if a requested time is available on a specified persons schedule is available, and the other is about finding available time to have meetings with between 2-5 prespecified individuals.
 
## Testing

I did quite a bit of testing for this project, most of it involved unit testing, of which I left a variety of the unit tests I developed within the program files themselves as artifacts. I used these to verify the individual peices of my code were working before trying to develop the bigger meetone and meet functions themselves. I built these tests with the help of the given documentation. I also modified some of the given overall main tests to make sure that the overall output from the functions was acceptable. I also added within the data.pl file an extra entry for ed so that his times could overlap with the output from the meet function for the other 4 people just to test out the meet for 5 people was actually working.

My tests resulted in the expected outcomes, with my own expected values created for the individual unit tests as well as on the larger main tests.

## Compiling and Using
To compile the meetone functionality enter:
gprolog meetone.pl

Then to run within the GNU Prolog enviroment enter:
consult(meetone).

To compile the meet functionality enter:
gprolog meet.pl

Then to run within the GNU Prolog enviroment enter:
consult(meet).

## Reflection

Overall this project was enjoyable, fairly rigorous and perhaps a little challenging however very entertaining and very much a relief now that it is complete. The mental legwork to get the basic functionality itself down was very much paled in comparrison to the amount of legwork it took to figure out the nuances of the Prolog language and how it functioned. Prolog is so different from any language I have thusfar encountered in that it is almost a pure logic engine and is built to capture the utility gained by being a pure logic engine.

Testing via unit tests was fine and worked well enough as well as the big main tests were very helpful and provided a good benchmark for when a project itself was done.

The hardest parts of this whole assignment was getting my head around prolog and its functionalities. And while developing the test suite and the actual coding itself were challenging and rigorous, neither were as difficult as merely understanding the ins and outs of the language.
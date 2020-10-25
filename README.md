# Mastermind

This is an adaptation of the Mastermind game designed by Mordecai Meirowitz. In the original version, there are a total of six colors and the code is four pegs long. In this version, there are eight colors and the code is six pegs long.


## How to Play

The goal of the game is to guess the color combination that has randomly been chosen by the computer (repeats are allowed). The player must select six pegs for each row. Each time a full combination is inputted, if at least one color from the guess is present in the hidden code, small black and/or white pegs will appear to the left of the corresponding row. A small black peg means that a color from the guess is in its correct location. A small white peg means that a color from the guess is present in the hidden code but is not in its correct location. There is no double-counting here. For example, if the leftmost peg of the hidden code is red and the leftmost peg of the guess is red, then only a small black peg (and not a white one) will appear to the left of the row once it is completed. The player has ten tries to narrow down the possible colors and their locations to come up with the correct combination.

## Game attributes

- filling in your guess: from all the colors at the bottom, select which color you would like to fill the next available hole with (availability goes from left to right)
- removing a peg: if you make a mistake before the last peg, simply click on the peg you would like to remove, and you should be left with an empty hole in the peg's previous location. The holes continue to be filled from left to right. So if, from a row that you already selected the first three pegs for, you remove the first peg, then the next color you select will go in the first hole, and the following color you select will go in the fourth hole.

## Organization of the Code

The main file, 'mastermindSketch.pde' (which can be run in Processing independently), contains the game code. The html file, 'mastermind.html', runs the game in a browser using processing.js to convert the Java code in 'mastermindSketch.pde' to JavaScript. For the html file to run properly, local file restrictions in your browser must be disabled. 

**Enjoy!**

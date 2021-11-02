# snapshot-tic-tac-toe
## A tic-tac-toe wiki of moves.

Yes, it is a great idea to begin the journey of a chess wiki of moves by scaling down the variables to the more simpler game of tic-tac-toe.
I remember in highschool, 1974, creating several version of the computer playing tic-tac-toe.  The best and favorite verion was the idea and creation of a simple search to find the next move.  The search key was the current play board! How?
I converted the square tic-tac-toe into a linear string thus:

     O | X | O                                                                    *****
    ---+---+---                                                                 * ~   ~ *
       | O |        became "OXO O XX "  Giving next move: "OXO O XXO"          *  O   o  *
    ---+---+---                         for the win!                            *   __, * 
     X | X |                                                                      *****
 
 
 And simply spent the time creating all possible board configurations and its next move.  The executable BASIC code was around 15 lines of code plus many more lines of DATA statements.  We can recreate this algorithm using Python and some GUI storing the moves in a text file and be done in a day.


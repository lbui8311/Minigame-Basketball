/**
    COMPE-271 Project - C Program
    Name: Luan Bui
    RedID: 824254178
    Objectives: Create a mini-game with a final scoreboard at the end.
    Requirements: 2-D arrays, condition statements, loops & stacks.

    Rand() function: https://www.tutorialspoint.com/c_standard_library/c_function_rand.htm

**/

#include <stdio.h>
#include <stdlib.h>

int main()
{

    int finalScore1, finalScore2, period, foul1, foul2; // Score-board variables
    char boardTemp[8][16]; // 2-D array Score-board template variable

    int pick1, pick2, P1, P2, totalP1, totalP2; // Scoring algorithm variables
    char option; // Option variable for prompting user.
    time_t t;   // Setting up time seed for rand() function.
    srand((unsigned) time(&t)); // Initializing random number using time seed.

    // Game Introduction and Rules

    printf("\n|------------------------------------------------------------------------------------------------------------|\n");
    printf("\n Welcome to the Eleventh!!! - a Basketball mini-game developed by Luan Bui. \n");
    printf("\n Rules: \n 1) Two players will be battling each other out by take turn picking the 'point', max is 3 points per turn.");
    printf("\n 2) The higher the chosen point, the lesser the chance of making the basket, the players will be given the same # of turns.");
    printf("\n 3) After a player has chosen a point, the scoring algorithm will then calculate and decide based on the scoring likeliness.");
    printf("\n 4) At the end,the player that has the highest score wins, game is up to 11. Good luck!");

    printf("\n\n So, are you ready? [y/n]: ");  // Prompting user to choose Yes/No for readiness
    scanf("%c", &option);   // Taking user input for readiness
    printf("\n\n");
    if(option == 'y') {     // If-else Condition

//<-------------------------------------------------------- Scoring Algorithm --------------------------------------------->
    period = 1;
    printf("Current period #: %d\n\n", period);

    totalP1 = 0; //Initializing totalP1 & totalP2
    totalP2 = 0;

do{//Do-while loop for Period # condition

   do { //Do-while loop for 11 points condition

    printf("########################################");
    printf("\nPlayer #1 - Score 1/2/3 point(s): ");
    scanf("%d", &pick1);

    if(pick1 == 1) {    // Nested If statements
        printf("You have picked: %d\n\n", pick1); // They pick #1, odd of landing to 1?
        P1 = rand() % 2;    // 0-1 => 1/2 = 50%
            if(pick1 = P1) {
                totalP1 += 1;
                printf("    You've scored 1 point!\n");
                printf("****************************************\n");
            }else {
                printf("Aw,you missed the shot!\n");
                printf("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n");
            }
    }else if(pick1 == 2) {   // They pick #2, odd of landing to 2?
        printf("You have picked: %d\n\n", pick1);
        P1 = rand() % 3;    // 0-2 => 1/3 = 33%
            if(pick1 = P1) {
                totalP1 += 2;
                printf("    You've scored 2 points!\n");
                printf("****************************************\n");
            }else {
                printf("Aw,you missed the shot!\n");
                printf("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n");
            }
    }else if(pick1 == 3) { // They pick #3, odd of landing to 3?
        printf("You have picked: %d\n\n", pick1);
        P1 = rand() % 4;  // 0-3, 1/4 = 25 %
            if(pick1 = P1) {
                totalP1 += 3;
                printf("    You've scored 3 points!\n");
                printf("****************************************\n");
            }else {
                printf("Aw,you missed the shot!\n");
                printf("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n");
            }
    }
    printf("\nPlayer #1 current score: %d\n",totalP1); // Tally up Player 1 current score
    printf("\n----------- Next&Player-----------------------------\n\n");

//<-------------------------------------------------------- Player's turn border --------------------------------------------->

    printf("########################################");
    printf("\nPlayer #2 - Score 1/2/3 point(s): ");
    scanf("%d", &pick2);

    if(pick2 == 1) {    // Nested If statements
        printf("You have picked: %d\n\n", pick2); // They pick #1, odd of landing to 1?
        P2 = rand() % 2;    // 0-1 => 1/2 = 50 %
            if(pick2 = P2) {
                totalP2 += 1;
                printf("    You've scored 1 point!\n");
                printf("****************************************\n");
            }else {
                printf("Aw,you missed the shot!\n");
                printf("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n");
            }
    }else if(pick2 == 2) {   // They pick #2, odd of landing to 2?
        printf("You have picked: %d\n\n", pick2);
        P2 = rand() % 3;    // 0-2 => 1/3 = 33 %
            if(pick2 = P2) {
                totalP2 += 2;
                printf("    You've scored 2 points!\n");
                printf("****************************************\n");
            }else {
                printf("Aw,you missed the shot!\n");
                printf("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n");
            }
    }else if(pick2 == 3) { // They pick #3, odd of landing to 3?
        printf("You have picked: %d\n\n", pick2);
        P2 = rand() % 4;  // 0-3, 1/4 = 25 %
            if(pick2 = P2) {
                totalP2 += 3;
                printf("    You've scored 3 points!\n");
                printf("****************************************\n");
            }else {
                printf("Aw,you missed the shot!\n");
                printf("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n");
            }
    }
    printf("\nPlayer #2 current score: %d\n",totalP2); // Tally up Player 2 current score
    printf("\n----------- Next&Player-----------------------------\n\n");


}while(totalP1 < 10 && totalP2 < 10); // The end of Do-while

    }while (totalP1 == totalP2); //Players will continue to score if they have passed 11 points and still equal.


//<---------------------------------------------------New Period Algothirm ------------------------------------------------------------------>

    if(totalP1 > 12 || totalP2 > 12){   //If-else statements for period #.
        period = 2;
    }
    if(totalP1 > 23 || totalP2 > 23){   //Period will start changing when P1 or P2 reach certain limits.
        period = 3;
    }
    if(totalP1 > 34 || totalP2 > 34){   //Period limits will be at 11,22,33 and +1 new period.
        period = 4;
    }

    printf("\nP1's Final score: %d\n", totalP1);
    printf("\nP2's Final score: %d\n", totalP2);
    printf("\nFinal period: %d\n", period);



 //<---------------------------------------------------Printing Player's scores via Score-board --------------------------------------------->
    	        printf("\n\n");

	        // Double For-loops
	        for(int i=0; i < 8; i++) { // # of Row
	            for(int j = 0; j < 16; j++){ // # of Column
	                boardTemp[i][j] = '~';
	                printf("  ");
	                boardTemp[1][1] = 'T';
	                boardTemp[1][2] = 'e';
	                boardTemp[1][3] = 'a';
	                boardTemp[1][4] = 'm';
	                boardTemp[1][5] = '1';

	                boardTemp[2][1] = ' ';
	                boardTemp[2][2] = ' ';
	                boardTemp[2][3] = ' ';
	                boardTemp[2][4] = ' ';
	                boardTemp[2][5] = ' ';

	                boardTemp[5][1] = 'F';
	                boardTemp[5][2] = 'o';
	                boardTemp[5][3] = 'u';
	                boardTemp[5][4] = 'l';
	                boardTemp[5][5] = '#';

	                boardTemp[6][1] = ' ';
	                boardTemp[6][2] = ' ';
	                boardTemp[6][3] = ' ';
	                boardTemp[6][4] = ' ';
	                boardTemp[6][5] = ' ';

	                boardTemp[2][7] = 'P';
	                boardTemp[2][8] = '#';

	                boardTemp[3][1] = ' ';
	                boardTemp[3][2] = ' ';
	                boardTemp[3][3] = ' ';
	                boardTemp[3][4] = ' ';
	                boardTemp[3][5] = ' ';

	                boardTemp[3][7] = ' ';
	                boardTemp[3][8] = ' ';


	                boardTemp[1][10] = 'T';
	                boardTemp[1][11] = 'e';
	                boardTemp[1][12] = 'a';
	                boardTemp[1][13] = 'm';
	                boardTemp[1][14] = '2';

	                boardTemp[3][10] = ' ';
	                boardTemp[3][11] = ' ';
	                boardTemp[3][12] = ' ';
	                boardTemp[3][13] = ' ';
	                boardTemp[3][14] = ' ';

	                boardTemp[5][10] = 'F';
	                boardTemp[5][11] = 'o';
	                boardTemp[5][12] = 'u';
	                boardTemp[5][13] = 'l';
	                boardTemp[5][14] = '#';

	                boardTemp[6][10] = ' ';
	                boardTemp[6][11] = ' ';
	                boardTemp[6][12] = ' ';
	                boardTemp[6][13] = ' ';
	                boardTemp[6][14] = ' ';

	                printf("%c ",boardTemp[i][j]); // Printing the Score-board
	            }
	            printf("\n");
	        }
	        printf("\n");


// <-------------------------------------------------------- If user select No in the ready section --------------------------------------------->
    } else {
        printf("\n See you next time!\n\n");
        printf("|------------------------------------------------------------------------------------------------------------|\n");

    }


    return 0;
}


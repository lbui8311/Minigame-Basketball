##   COMPE-271 Project - Assembly Program
##   Name: Luan Bui
##   RedID: 824254178
##   Objectives: Create a mini-game with a final scoreboard at the end.
##   Requirements: 2-D arrays, condition statements, loops.& stacks.
##   Idea on how to do Rand function: https://www.youtube.com/watch?v=s6snbrJ3Exk
.data
intro1: .asciiz "\n|------------------------------------------------------------------------------------------------------------|\n"
intro2: .asciiz "\n Welcome to the Eleventh!!! - a Basketball mini-game developed by Luan Bui. \n"
intro3: .asciiz "\n Rules: \n 1) Two players will be battling each other out by take turn picking the 'point', max is 3 points per turn."
intro4: .asciiz "\n 2) The higher the chosen point, the lesser the chance of making the basket, the players will be given the same # of turns."
intro5: .asciiz "\n 3) After a player has chosen a point, the scoring algorithm will then calculate and decide based on the scoring likeliness."
intro6: .asciiz "\n 4) At the end,the player that has the highest score wins, game is up to 11. Good luck!"
prompt1: .asciiz  "\n\n So, are you ready? [y/n]:"
outtro1: .asciiz "\n\n See you next time!\n\n"
outtro2: .asciiz "|------------------------------------------------------------------------------------------------------------|\n"
test1: .asciiz "\n This is equal"
test2: .asciiz "\n This is not equal"
## Scoring prompts
test3: .asciiz "You have picked: "
prompt3: .asciiz "\n########################################"
prompt4: .asciiz "\nPlayer #1 - Score 1/2/3 point(s): "
prompt5: .asciiz "\nPlayer #2 - Score 1/2/3 point(s): "
prompt6: .asciiz "   \n\n You've scored 1 point!\n"
prompt7: .asciiz "   \n\n You've scored 2 points!\n"
prompt8: .asciiz "   \n\n You've scored 3 points!\n"
prompt9: .asciiz "\n\nAw,you missed the shot!\n"
prompt10: .asciiz "****************************************\n"
prompt11: .asciiz "\nPlayer #1 current score: "
prompt12: .asciiz "\nPlayer #2 current score: "
prompt13: .asciiz "\nPlayer #1 final score: "
prompt14: .asciiz "\nPlayer #2 final score: "
prompt15: .asciiz "\n\n----------- Next&Player-----------------------------\n"
prompt16: .asciiz "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"

Scored: .word 70,70
Missed: .word 35,35

SoundDuration: .byte 100
SoundInstrument: .byte 25
SoundVolume: .byte 100


ScoreBoard:    .byte '\n', '\n', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '\n'
	     .byte ' ', '~', ' ', 'T', ' ','e',' ','a',' ','m', ' ', '1', ' ','~', ' ','~', ' ','~', ' ',' ', 'T', ' ','e',' ','a',' ','m', ' ', '2',' ',' ','~','\n'
	     .byte ' ', '~',' ',' ',' ',' ',' ','x',' ',' ',' ',' ',' ', '~',' ', '~',' ', '~',,' ',' ',' ',' ',' ',' ','x',' ',' ',' ',' ',' ',' ', '~', '\n'
	     .byte  ' ','~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '~', ' ', '\n'

.text
#<-------------------------------------------------------- Game Introduction --------------------------------------------->
main:	li $v0, 4 ## Print String Service #
	la $a0, intro1 ## Load address of string "Intro1" 		"\n|------------------------------------------------------------------------------------------------------------|\n"
	syscall
	
	li $v0, 4 ## Print String Service #
	la $a0, intro2 ## Load address of string "Intro2" 		"\n Welcome to the Eleventh!!! - a Basketball mini-game developed by Luan Bui. \n"
	syscall
	
	li $v0, 4 ## Print String Service #
	la $a0, intro3 ## Load address of string "Intro3"		"\n Rules: \n 1) Two players will be battling each other out by take turn picking the 'point', max is 3 points per turn."
	syscall
	
	li $v0, 4 ## Print String Service #
	la $a0, intro4 ## Load address of string "Intro4"		"\n 2) The higher the chosen point, the lesser the chance of making the basket, the players will be given the same # of turns."
	syscall
	
	li $v0, 4 ## Print String Service #
	la $a0, intro5 ## Load address of string "Intro5"		"\n 3) After a player has chosen a point, the scoring algorithm will then calculate and decide based on the scoring likeliness."
	syscall
	
	li $v0, 4 ## Print String Service #
	la $a0, intro6 ## Load address of string "Intro6"		"\n 4) At the end,the player that has the highest score wins, game is up to 11. Good luck!"
	syscall
	
	li $v0, 4 ## Print String Service #
	la $a0, prompt1 ## Load address of string "prompt1"		"\n\n So, are you ready? [y/n]:"
	syscall 
# <-------------------------------------------------------- Prompting user's input for readiness --------------------------------------------->	
	li $v0, 12 ## Read character input service # & taking user input
	syscall
	
	move $t0, $v0 ## Storing string input temporarily in $t0
	
	li  $t1, 'y'	## Load in 'y' to $t1 for comparison
	
	bne $t1, $t0, No ## If $t0 != y, branch to NO
	li $v0, 4     ## Print String Service #
	la $a0, test1 							## "This is equal" string
	syscall
# <-------------------------------------------------------- Scoring Algorithm --------------------------------------------->	
	addi $s1, $zero, 1 ## Storing 1,2,3 into saved registers for later use
	addi $s2, $zero, 2
	addi $s3, $zero, 3
	
	addi $s6, $zero, 10 ## Initializing limit for player 1
while: bgt $s4, $s6,Final_Score
	li $v0, 4	## Print String Service #
	la $a0, prompt3 ## Load address of string "prompt3"		"\n########################################"
	syscall
	
	li $v0, 4	## Print String Service #
	la $a0, prompt4 ## Load address of string "prompt4"		"\nPlayer #1 - Score 1/2/3 point(s): "
	syscall
	
	li $v0, 5	## read integer Service #
	syscall
	
	move $t0, $v0  ##Storing user's input to $t0
	
	li $v0, 4 ## Print String Service #
	la $a0, test3 ## Load address of string "test3" 		"You have picked: "
	syscall
	
	li $v0, 1	## Print integer service #
	add $a0, $t0, $zero ## load address of $t0 into $a0		## Printing the integer entered by user
	syscall

		#First If-else	
		bne $t0, $s1, ifElse2	## If user picked 1
		li $a1, 2 ## Setting up rand function upperbound
		li $v0, 42 ## Generating random integer service number  
		syscall
		
		move $t2, $a0 ## Storing the generated number in $t2
		
		bne $s1, $t2, Missed1 ## Branch the function based on the scoring likeliness
			li $v0, 4     ## Picked 1 => 0-1, 50% of success
			la $a0, prompt6					## "   \n\n You've scored 1 point!\n"
			syscall
			li $v0, 4
			la $a0, prompt10				## "****************************************\n"
			syscall
			addi $s4, $s4, 1				## Adding 1 to P1's current score
			jal ScoredSound	
			
		j Score
		
		Missed1:
			li $v0, 4
			la $a0, prompt9					## "\n\nAw,you missed the shot!\n"
			syscall
			
			li $v0, 4
			la $a0, prompt16				## "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
			syscall
			
			li $v0, 1 ## Check what number is randomly generated
			add $a0, $zero,$t2 ## Print the generated number
			syscall	
			jal MissedSound
	
		j Score
		
		#Second If-else
		ifElse2: bne $t0, $s2, ifElse3 ## If user picked 2
			 li $a1, 3 	       ## Picked 2 => 0-2, 33% of success
			 li $v0, 42
			 syscall
		
			 move $t2, $a0
		
				 bne $s2, $t2, Missed2 ## Branch the function based on the scoring likeliness
				 li $v0, 4	       
				 la $a0, prompt7			## "   \n\n You've scored 2 points!\n"
				 syscall
				 li $v0, 4
				 la $a0, prompt10			## "****************************************\n"
				 syscall
				 addi $s4, $s4, 2			## Adding 2 to P1's current score
				 jal ScoredSound	
			
			 j Score
			
				Missed2:
					li $v0, 4
					la $a0, prompt9			## "\n\nAw,you missed the shot!\n"
					syscall
			
					li $v0, 4
					la $a0, prompt16		## "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
					syscall
					
					li $v0, 1 ## Check what number is randomly generated
					add $a0, $zero,$t2 ## Print the generated number
					syscall	
					jal MissedSound
			
			j Score
		
			#Third If-else
			ifElse3:bne $t0,$s3, No	## If user picked 3
				li $a1, 4	        ## Picked 3 => 0-3, 25% of success
				li $v0, 42
				syscall
		
				move $t2, $a0
		
					bne $s3, $t2, Missed3 ## Branch the function based on the scoring likeliness
					li $v0, 4	      
					la $a0, prompt8			## "   \n\n You've scored 3 points!\n"
					syscall
					li $v0, 4
					la $a0, prompt10		## "****************************************\n"
					syscall
					addi $s4, $s4, 3		## Adding 3 to P1's current score
					jal ScoredSound	
					
				j Score
				
					Missed3:
						li $v0, 4
						la $a0, prompt9		## "\n\nAw,you missed the shot!\n"
						syscall
			
						li $v0, 4
						la $a0, prompt16	## "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
						syscall
						
						li $v0, 1 ## Check what number is randomly generated
						add $a0, $zero,$t2 ## Print the generated number
						syscall	
						jal MissedSound
				j Score
		
	Score: ## Printing P1's Current Score
		li $v0, 4
		la $a0, prompt11 		## "\nPlayer #1 current score: "
		syscall
		
		li $v0, 1
		add $a0, $zero, $s4 		## Print P1's current score
		syscall
		
		li $v0, 4
		la $a0, prompt15 		## "\n----------- Next&Player-----------------------------\n\n"
		syscall
		
		addi $s7, $zero, 10 ## Initializing limit for player 2
		
		j while2
## <-------------------------------------------------------- Player's turn border --------------------------------------------->
	  
	while2: bgt $s5, $s7,Final_Score
		li $v0, 4	## Print String Service #
		la $a0, prompt3 ## Load address of string "prompt3"		"\n########################################"
		syscall
	
		li $v0, 4	## Print String Service #
		la $a0, prompt5 ## Load address of string "prompt4"		"\nPlayer #2 - Score 1/2/3 point(s): "
		syscall
	
		li $v0, 5	## read integer Service #
		syscall
	
		move $t0, $v0  ##Storing user's input to $t0
	
		li $v0, 4 ## Print String Service #
		la $a0, test3 ## Load address of string "test3" 		"You have picked: "
		syscall
	
		li $v0, 1	## Print integer service #
		add $a0, $t0, $zero ## load address of $t0 into $a0		## Printing the integer entered by user
		syscall
	
		addi $s1, $zero, 1 ## Storing 1,2,3 into saved registers for later use
		addi $s2, $zero, 2
		addi $s3, $zero, 3
	
			#First If-else	
			bne $t0, $s1, ifElse4	## If user picked 1
			li $a1, 2 ## Setting up rand function upperbound
			li $v0, 42 ## Generating random integer service number
			syscall
		
			move $t2, $a0 ## Storing the generated number in $t2
		
			bne $s1, $t2, Missed4 ## Branch the function based on the scoring likeliness
				li $v0, 4     ## Picked 1 => 0-1, 50% of success
				la $a0, prompt6					## "   \n\n You've scored 1 point!\n"
				syscall
				li $v0, 4
				la $a0, prompt10				## "****************************************\n"
				syscall
				addi $s5, $s5, 1				## Adding 1 to P2's current score
				jal ScoredSound	
			
			j Score2
		
			Missed4:
				li $v0, 4
				la $a0, prompt9					## "\n\nAw,you missed the shot!\n"
				syscall
			
				li $v0, 4
				la $a0, prompt16				## "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
				syscall
			
				li $v0, 1 ## Check what number is randomly generated
				add $a0, $zero,$t2 ## Print the generated number
				syscall	
				jal MissedSound
	
			j Score2
		
			#Second If-else
			ifElse4: bne $t0, $s2, ifElse5 ## If user picked 2
				 li $a1, 3 	       ## Picked 2 => 0-2, 33% of success
				 li $v0, 42
				 syscall
		
				 move $t2, $a0
		
					 bne $s2, $t2, Missed5 ## Branch the function based on the scoring likeliness
					 li $v0, 4	       
					 la $a0, prompt7			## "   \n\n You've scored 2 points!\n"
					 syscall
					 li $v0, 4
					 la $a0, prompt10			## "****************************************\n"
					 syscall
					 addi $s5, $s5, 2			## Adding 2 to P2's current score
					 jal ScoredSound	
			
				 j Score2
			
					Missed5:
						li $v0, 4
						la $a0, prompt9			## "\n\nAw,you missed the shot!\n"
						syscall
			
						li $v0, 4
						la $a0, prompt16		## "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
						syscall
					
						li $v0, 1 ## Check what number is randomly generated
						add $a0, $zero,$t2 ## Print the generated number
						syscall	
						jal MissedSound
			
				j Score2
		
				#Third If-else
				ifElse5:bne $t0,$s3, No	## If user picked 3
					li $a1, 4	        ## Picked 3 => 0-3, 25% of success
					li $v0, 42
					syscall
		
					move $t2, $a0
		
						bne $s3, $t2, Missed6 ## Branch the function based on the scoring likeliness
						li $v0, 4	      
						la $a0, prompt8			## "   \n\n You've scored 3 points!\n"
						syscall
						li $v0, 4
						la $a0, prompt10		## "****************************************\n"
						syscall
						addi $s5, $s5, 3		## Adding 3 to P2's current score
						jal ScoredSound	
					
					j Score2
				
						Missed6:
							li $v0, 4
							la $a0, prompt9		## "\n\nAw,you missed the shot!\n"
							syscall
			
							li $v0, 4
							la $a0, prompt16	## "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
							syscall
						
							li $v0, 1 ## Check what number is randomly generated
							add $a0, $zero,$t2 ## Print the generated number
							syscall	
							jal MissedSound
					j Score2
		
		Score2: ## Printing P2's Current Score
			li $v0, 4
			la $a0, prompt12 		## "\nPlayer #2 current score: "
			syscall
			
			li $v0, 1
			add $a0, $zero, $s5		## Print P2's current score
			syscall
			
			li $v0, 4
			la $a0, prompt15 		## "\n----------- Next&Player-----------------------------\n\n"
			syscall
		
		j while
	
## <-------------------------------------------------------- Final Scores Display --------------------------------------------->	
	Final_Score: 
			li $v0, 4
			la $a0, prompt13	## "\nPlayer #1 final score: "
			syscall
			
			li $v0, 1
			add $a0, $zero, $s4 ## Print P1's final score
			syscall
			
			li $v0, 4
			la $a0, prompt14	## "\nPlayer #2 final score: "
			syscall
			
			li $v0, 1
			add $a0, $zero, $s5 ## Print P2's final score
			syscall
			
			#beq $s4, $s5 while ## Loop again if final scores are equal
## <--------------------------------------------------Printing the final scoreboard------------------------------------------->			
	li $s0, 0 # Reseting saved registers for later iterations
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s6, 0
	li $s7, 0 

	la $s0, ScoreBoard # Load Address of the array to $s0
	
	addi $t0, $zero, 15 # Player 1's Score column 15
	addi $t1, $zero, 4 # Player'1's Score row 4
	
	addi $t3, $zero, 19 #  Player 2's Score column 19
	addi $t4, $zero, 4 # Player 2's Score row 4
			
	jal ScoreReplace 
	
	j End
		
ScoreReplace:
		addi $sp, $sp, -4  # Reserve Stack Space
		sw $ra, 0($sp)     # Preserve the return address
		
		addi $t2,$t0, 4 # Adding the column offset for P1
		mul $t2, $t2, $t1 # Multipling the row offset for P1
		la $s0, ScoreBoard
		add $s1, $s0, $t2
		
		addi $t5,$t3, 4 # Adding the column offset for P2
		mul $t5, $t5, $t4 # Multipling the row offset for P2
		la $s0, ScoreBoard
		add $s2, $s0, $t5
				  
		li $t6, 10 # Setting conversion limit to 10 for comparison
				  
	       P1Convert: bge $s4, $t6, StackReturn ## If P1's score is great than 10, branch to Continue
	
			  addi $t7, $zero, 0	## Desclaring $t7 = 0 for number comparison
			  beq $s4, $t7, Zero
			  
			  addi $t7, $t7, 1	## Itenrate each time until the number matches final score, then branch to designated ASCII conversion
			  beq $s4, $t7, One
			  	
			  addi $t7, $t7, 1
			  beq $s4, $t7, Two
			  		
			  addi $t7, $t7, 1
			  beq $s4, $t7, Three

	       		  addi $t7, $t7, 1
			  beq $s4, $t7, Four
			  	
			  addi $t7, $t7, 1
			  beq $s4, $t7, Five
			  	
			  addi $t7, $t7, 1
			  beq $s4, $t7, Six
			  	
			  addi $t7, $t7, 1
			  beq $s4, $t7, Seven
			  	
			  addi $t7, $t7, 1
			  beq $s4, $t7, Eight
			  	
			  addi $t7, $t7, 1
			  beq $s4, $t7, Nine
			  		  	
			  			Zero:
			  				li $s6, 48
			  				sb $s6, 0($s1) # Store ASCII "0" into ScoreBoard
			  				j P2Convert
			  			One:
			  				li $s6, 49
			  				sb $s6, 0($s1) # Store ASCII "1" into ScoreBoard
			  				j P2Convert
			  			Two:
			  				li $s6, 50
			  				sb $s6, 0($s1) # Store ASCII "2" into ScoreBoard
			  				j P2Convert
						Three:
			  				li $s6, 51
			  				sb $s6, 0($s1) # Store ASCII "3" into ScoreBoard
			  				j P2Convert
						Four:
			  				li $s6, 52
			  				sb $s6, 0($s1) # Store ASCII "4" into ScoreBoard
			  				j P2Convert
			  			Five:
			  				li $s6, 53
			  				sb $s6, 0($s1) # Store ASCII "5" into ScoreBoard
			  				j P2Convert
						Six:
			  				li $s6, 54
							sb $s6, 0($s1) # Store ASCII "6" into ScoreBoard
			  				j P2Convert
			  			Seven:
			  				li $s6, 55
			  				sb $s6, 0($s1) # Store ASCII "7" into ScoreBoard
			  				j P2Convert
			  			Eight:
							li $s6, 56
			  				sb $s6, 0($s1) # Store ASCII "8" into ScoreBoard
			  				j P2Convert
			  			Nine:
			  				li $s6, 57
			  				sb $s6, 0($s1) # Store ASCII "9" into ScoreBoard
		
		 P2Convert: bge $s5, $t6, StackReturn ## If P1's score is great than 10, branch to Continue
	
			   addi $s3, $zero, 0 ## Desclaring $s3 = 0 for number comparison
			   beq $s5, $s3, Zero2
			  
			   addi $s3, $s3, 1  ## Itenrate each time until the number matches final score, then branch to designated ASCII conversion
			   beq $s5, $s3, One2
			  	
			   addi $s3, $s3, 1
			   beq $s5, $s3, Two2
			  		
			   addi $s3, $s3, 1
			   beq $s5, $s3, Three2

	       		   addi $s3, $s3, 1
			   beq $s5, $s3, Four2
			  	
			   addi $s3, $s3, 1
			   beq $s5, $s3, Five2
			  	
			   addi $s3, $s3, 1
			   beq $s5, $s3, Six2
			  	
			   addi $s3, $s3, 1
			   beq $s5, $s3, Seven2
			  	
			   addi $s3, $s3, 1
			   beq $s5, $s3, Eight2
			  	
			   addi $s3, $s3, 1
			   beq $s5, $s3, Nine2
			  		  	
			  			Zero2:
			  				li $s7, 48
			  				sb $s7, 0($s2) # Store ASCII "0" into ScoreBoard
			  				j StackReturn
			  			One2:
			  				li $s7, 49
			  				sb $s7, 0($s2) # Store ASCII "1" into ScoreBoard
			  				j StackReturn
			  			Two2:
			  				li $s7, 50
			  				sb $s7, 0($s2) # Store ASCII "2" into ScoreBoard
			  				j StackReturn
						Three2:
			  				li $s7, 51
			  				sb $s7, 0($s2) # Store ASCII "3" into ScoreBoard
			  				j StackReturn
						Four2:
			  				li $s7, 52
			  				sb $s7, 0($s2) # Store ASCII "4" into ScoreBoard
			  				j StackReturn
			  			Five2:
			  				li $s7, 53
			  				sb $s7, 0($s2) # Store ASCII "5" into ScoreBoard
			  				j StackReturn
						Six2:
			  				li $s7, 54
							sb $s7, 0($s2) # Store ASCII "6" into ScoreBoard
			  				j StackReturn
			  			Seven2:
			  				li $s7, 55
			  				sb $s7, 0($s2) # Store ASCII "7" into ScoreBoard
			  				j StackReturn
			  			Eight2:
							li $s7, 56
			  				sb $s7, 0($s2) # Store ASCII "8" into ScoreBoard
			  				j StackReturn
			  			Nine2:
			  				li $s7, 57
			  				sb $s7, 0($s2) # Store ASCII "9" into ScoreBoard
			  						  	  		

	StackReturn:	
		move $a0, $s0
		li $v0, 4 	# Print the 2D-Array
		syscall
		
		lw $ra, 0($sp) # restore the return address
		addi $sp, $sp, 4 # restore the stack space
		jr $ra
												
# <-------------------------------------------------------- Sound's Setup --------------------------------------------->
	MissedSound:
		la $a1, SoundDuration
		la $a2, SoundInstrument
		la $a3, SoundVolume

		li $v0, 31
		la $t3, Missed # Sound String

		li $t4, 2 # 2 Pitch
		li $t5, 1 # Increment Counter

		SoundLoop1: 
			beq $t5, $t4, Return
			lw $a0, 0($t3)
			syscall
			addi $t5, $t5, 1 
			addi $t3, $t3, 4 # Each pitch in sound is 4 bytes.
		j SoundLoop1
		
	ScoredSound:
		la $a1, SoundDuration
		la $a2, SoundInstrument
		la $a3, SoundVolume

		li $v0, 31
		la $t3, Scored # Sound String

		li $t4, 2 # 2 Pitchs
		li $t5, 1 # Increment Counter

		SoundLoop2: 
			beq $t5, $t4, Return
			lw $a0, 0($t3)
			syscall
			addi $t5, $t5, 1 
			addi $t3, $t3, 4 # Each pitch in sound is 4 bytes.
			j SoundLoop2	
	
	Return:
		jr $ra
			
	
	No: 
		li $v0, 4
		la $a0, test2 # "This is not equal" string
		syscall

# <-------------------------------------------------------- End of Program ------------------------------------------------>	
	
End:
	li $v0, 4 ## String Service #
	la $a0, outtro1 ## Load address of string "outtro1"
	syscall
	
	li $v0, 4 ## String Service #
	la $a0, outtro2 ## Load address of string "outtro2"
	syscall
	
	li $v0, 10 ## Exit the Program 
	syscall

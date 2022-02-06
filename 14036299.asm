# Jack Hodgkiss, 14036299, Options 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 implemented.

.data

	# Useful strings will be needed throughout the program.
	newLine: .asciiz "\n" 
	additionSym: .asciiz " + "
	subtractionSym: .asciiz " - "
	multiplicationSym: .asciiz " * "
	divisionSym: .asciiz " / "
	equalSym: .asciiz " = "
	powerSym: .asciiz "^"
	space: .asciiz " "

	# The menu that shall be printed to the console allowing the user to find their desired option.
	menu: .ascii "Menu \n"  
	      .ascii "\n1.  Set the value of number 1" 
	      .ascii "\n2.  Set the value of number 2"
	      .ascii "\n3.  Display the two chosen numbers" 
	      .ascii "\n4.  Display the sum of number 1 and number 2"
	      .ascii "\n5.  Display the product of number 1 and number 2"
	      .ascii "\n6.  Divide number 1 by number 2 (quotient and remainder displayed)"
	      .ascii "\n7.  Swap number 1 and number 2"
	      .ascii "\n8.  Display the numbers in between number 1 and number 2"
	      .ascii "\n9.  Display the total sum of all numbers between number 1 and number 2"
	      .ascii "\n10. Raise number 1 to the power of number 2"
	      .ascii "\n11. Display all of the prime number between number 1 and number 2"
	      .ascii "\n12. Quit"
	      .asciiz "\n\nPlease chose one of the above options: "
	
	# Option introductions used to tell the user what option they have selected and what input is needed or the output is being displayed.
	option1Selected: .asciiz "You have chosen option 1 - Set the value of number 1: "
	option2Selected: .asciiz "You have chosen option 2 - Set the value of number 2: "
	option3Selected: .asciiz "You have chosen option 3 - Display number 1 and number 2"
	option4Selected: .asciiz "You have chosen option 4 - Display the sum of the two numbers"
	option5Selected: .asciiz "You have chosen option 5 - Display the product of the two numbers"
	option6Selected: .asciiz "You have chosen option 6 - Divide number 1 by number 2, display the quotient and remainder"
	option7Selected: .asciiz "You have chosen option 7 - Swap number 1 and number 2"
	option8Selected: .asciiz "You have chosen option 8 - Display the numbers between the two numbers"
	option9Selected: .asciiz "You have chosen option 9 - Display the sum of the numbers between the two numbers"
	option10Selected: .asciiz "You have chosen option 10 - Raise number 1 to the power of number 2"
	option11Selected: .asciiz "You have chosen option 11 - Display the prime numbers between number 1 and number 2"
	
	# Option specific messages.
	option3MsgA: .asciiz "Number 1: "
	option3MsgB: .asciiz "Number 2: "
	option6MsgA: .asciiz " remainder "
	option7MsgA: .asciiz "Your numbers have been swapped."
	option12MsgA: .asciiz "Thank you for using this number minipulation program.\nCreated By Jack Hodgkiss.\n"
	# Little return message asking the user to hit enter when they would like to return to main menu when they would like to carry using the program.
	returnMenuMsg: .asciiz "Press 'Enter' To return to the main menu"

.text
	
main:
	
	printMenu: # Print the menu to the output window. Using system call service 4 prints string stored within the argument register $a0
	li $v0, 4
	la $a0, menu
	syscall
	
	promptUserInput: # Ask the user for input in the form of a integer. Using system call service 5 reads input in the form of an integer. Input read is stored in $v0.
	li $v0, 5
	syscall
	
	move $t0, $v0 # Move the integer provided by the user and placed it within $t0. This allows the beq block above to compare it value to a potential menu option.
	
	jal nLine

	# A group of branch on equals to test to see if $t0 (user selected option) equals one of the options from the menu. See it as a elseif statement.
	blt $t0, 1, printMenu # Test to see if the user has provide a value outside of the menu.
	beq $t0, 1, option1
	beq $t0, 2, option2
	beq $t0, 3, option3
	beq $t0, 4, option4
	beq $t0, 5, option5
	beq $t0, 6, option6
	beq $t0, 7, option7
	beq $t0, 8, option8
	beq $t0, 9, option9
	beq $t0, 10, option10
	beq $t0, 11, option11
	beq $t0, 12, quit
	bgt $t0, 12, printMenu # Test to see if the user has provide a value outside of the menu.
		
	# # # # # # # # #
	#   Option 01   #
	# # # # # # # # #

	option1: # Ask the user for their 1st integer value and store it within $s0 register.
	li $v0, 4
	la $a0, option1Selected
	syscall	
	
	li $v0, 5
	syscall	# Ask the user for an integer. 
	
	move $s0, $v0 # Store the user's number 1 in $s0. (Saved Register shouldn't change throughout the program)

	jal nLine

	j returnToMenu # Call returnToMenu, ask the user if they would like to return to main menu by pressing 'Enter'
	
	# # # # # # # # #
	#   Option 02   #
	# # # # # # # # #

	option2: # Ask the user for their 2nd integer value and store it within $s1 register.
	li $v0, 4
	la $a0, option2Selected
	syscall
	
	li $v0, 5
	syscall

	move $s1, $v0 # Store number 2 within $s1. 
	
	jal nLine

	j returnToMenu
	
	# # # # # # # # #
	#   Option 03   #
	# # # # # # # # #

	option3: # Display the user's two numbers back to them by fetching from their respective register location.
	li $v0, 4
	la $a0, option3Selected
	syscall
		
	jal nLine
	
	li $v0, 4
	la $a0, option3MsgA
	syscall
	
	li $v0, 1
	move $a0, $s0 # move the contents of $s0 into the argument register.
	syscall

	jal nLine
	
	li $v0, 4
	la $a0, option3MsgB
	syscall

	li $v0, 1
	move $a0, $s1 # move the contents of $s1 into the argument register.
	syscall
	
	jal nLine
	
	j returnToMenu

	# # # # # # # # #
	#   Option 04   #
	# # # # # # # # #
	
	option4: # Display the sum of the two numbers chosen by fetching them for their respective registers and adding them together.
	li $v0, 4
	la $a0, option4Selected
	syscall

	jal nLine

	# Calculate the sum of the two numbers
	add $t0, $s0, $s1

	# Following prints number 1 + number 2 = sum
	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 4
	la $a0, additionSym
	syscall

	li $v0, 1
	move $a0, $s1
	syscall

	jal printEqualSym

	li $v0, 1
	move $a0, $t0
	syscall

	jal nLine

	j returnToMenu

	# # # # # # # # #
	#   Option 05   #
	# # # # # # # # #

	option5: # Display the product of the two numbers chosen by fetching them for their respective registers multiplying them together.
	li $v0, 4
	la $a0, option5Selected
	syscall

	jal nLine

	# Calculate the product of the two numbers. Result is stored within hi lo registers
	mult $s0, $s1
	
	# Following prints number 1 * number 2 = product
	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 4
	la $a0, multiplicationSym
	syscall

	li $v0, 1
	move $a0, $s1
	syscall

	jal printEqualSym

	li $v0, 1
	mflo $a0 # Use the special instruction 'mflo' (move from lo - the location in which the product of the two numbers has been stored) to place it in the $a0 ready for printing to the screen.
	syscall	
	
	jal nLine

	j returnToMenu

	# # # # # # # # #
	#   Option 06   #
	# # # # # # # # #

	option6: # Display the division of the two numbers. Display the quotient and remainder
	li $v0, 4
	la $a0, option6Selected
	syscall

	jal nLine

	# Calculate the division of the two numbers. Result is stored within hi lo registers
	div $s0, $s1
	
	# Following prints number 1 / number 2 = quotient remainder
	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 4
	la $a0, divisionSym
	syscall

	li $v0, 1
	move $a0, $s1
	syscall

	jal printEqualSym
	
	li $v0, 1
	mflo $a0 # Fetch the quotient from the lo register
	syscall	
	
	li $v0, 4
	la $a0, option6MsgA
	syscall

	li $v0, 1
	mfhi $a0 # Fetch the remainder from the hi register
	syscall

	jal nLine

	j returnToMenu

	# # # # # # # # #
	#   Option 07   #
	# # # # # # # # #

	option7: # Swap the two numbers around
	li $v0, 4
	la $a0, option7Selected
	syscall

	jal nLine
	
	# Store the numbers in temporary registers
	move $t0, $s0
	move $t1, $s1

	# Swap the numbers around by moving the contents of the temporary registers to the other saved register.
	move $s0, $t1
	move $s1, $t0
	
	# Clear the contents of the temporary registers.
	move $t0, $zero
	move $t1, $zero

	# Print a message to the user telling them their numbers have been swapped.
	li $v0, 4
	la $a0, option7MsgA
	syscall

	jal nLine

	j returnToMenu	

	# # # # # # # # #
	#   Option 08   # 
	# # # # # # # # #
	
	option8: # Display the number between number 1 and number 2 in sequence
	li $v0, 4
	la $a0, option8Selected
	syscall

	jal nLine
	
	sub $t0, $s1, $s0 # Place the range of the two numbers inside a temporary register number 2 - number 1
	move $t1, $zero # Set counter to 0
	bgtz $t0, positiveLoop # If the range is positive then do the positive loop. If not start the negative loop.
	
	negativeLoop:
	blt	$t1, $t0, end # Check to see if the counter is less than the range. If so end it.
	li $v0, 1 
	add $a0, $s0, $t1
	syscall # Print the number at the current sequence position. Number 1 add the current counter (negative)
	sub $t1, $t1, 1 # Subtract the counter by 1 to move it closer to the end of the loop (range)
	blt $t1, $t0, negativeLoop # Check to see if the counter is less than the range if so loop back round. This stops a space being added to the end of the sequence.
	jal printSpace
	j negativeLoop # End of loop has been reached loop back around.

	positiveLoop:
	bgt	$t1, $t0, end # Check to see if the counter is greater than the range. If so end it.
	li $v0, 1
	add $a0, $s0, $t1
	syscall # Print the number at the current sequence position. Number 1 add the current counter (positive)
	add $t1, $t1, 1  # Subtract the counter by 1 to move it closer to th end of the loop (range)
	bgt $t1, $t0, positiveLoop # Check to see if the counter is greater than the range if so loop back round. This tops a space being added to the end of the sequence.
	jal printSpace
	j positiveLoop # End of loop has been reached loop back around.

	end:

	jal nLine
	
	j returnToMenu

	# # # # # # # # #
	#   Option 09   #
	# # # # # # # # #

	option9: # Display the total sum of the sequence between number 1 and number 2
	li $v0, 4
	la $a0, option9Selected
	syscall		
	
	jal nLine
	
	move $t0, $s0 # Load in the two chosen numbers. Presumes that $s0 contains the smallest number out of the two.
	move $t1, $s1
	blt $s0, $s1 sumTotal # If however $s0 doesn't contain the smallest number then swap them around.
	move $t0, $s1
	move $t1, $s0

	sumTotal:
	# S = n / 2 [2a + (n - 1)d]
	sub $t2, $t1, $t0 # Find the number of terms within the sequence by taking the largest from the biggest. 
	add $t2, $t2, 1 # Add one to the number of terms to ensure that the last number within the sequence is including within the total sum.
	sub $t3, $t2, 1 # (n - 1)
	add $t9, $t9, 2 # Store the number 2 for mult
	mult $t0, $t9 # Multiply the first number in the sequence by 2.
	mflo $t4 # 2a
	add $t5, $t4, $t3 # 2a + (n - 1)
	mult $t2, $t5 
	mflo $t6 # n * [2a + (n - 1)]
	div $t7, $t6, 2 # (n * [2a + (n - 1)] / 2

	li $v0, 1
	move $a0, $t7 # Load the total sum into the argument register for printing.
	syscall
	
	jal nLine
	
	j returnToMenu

	# # # # # # # # #
	#   Option 10   #
	# # # # # # # # #

	option10: # Display the calculation of raising number 1 to the power of number 2
	li $v0, 4
	la $a0, option10Selected
	syscall

	jal nLine
	
	move $t0, $zero
	li $t1, 1
	
	powerLoop: # Multiply the user's first number by 'number 2' as many times. 
	# The loop shall cycle around until the counter has reached the users number 2. Each time multiplying the previous multiplication by number 1
	beq $t0, $s1, endPowerLoop
	mult $s0, $t1
	mflo $t1 # Hold the result of the above multiplication.
	add $t0, $t0, 1 # Increase the loop counter.
	j powerLoop
	
	endPowerLoop: # End of the loop has been reached now print the result to the console for the user.
	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 4
	la $a0, powerSym
	syscall

	li $v0, 1
	move $a0, $s1
	syscall

	jal printEqualSym

	li $v0, 1
	move $a0, $t1
	syscall

	jal nLine

	j returnToMenu
	
	# # # # # # # # #
	#   Option 11   #
	# # # # # # # # #

	option11: # Display only the primes numbers between number 1 and number 2
	li $v0, 4
	la $a0, option11Selected
	syscall

	jal nLine
	
	# t0 = the lower limit number. Arranged if detected by higher the lowest number.
	# t1 = the higher limit number. Arranged if otherwise.
	# t2 = the current number being tested.
	# t3 = the number that is being used to test the number being tested.

	# Load the numbers in to temp registers
	move $t0, $s0	 
	move $t1, $s1
	move $t2, $t0 # set the number to be tested equal to the lower limit
	sub $t2, $t2, 1 # Subtract 1 from the number to be tested to ensure that the lower end of the sequence (user's number 1) is included within sequence.
	blt $t0, $t1, primeNumberLoop # Move on to the prime number loop in the event that the lowest number is already wthin the $t0 register.
	move $t0, $s1
	move $t1, $s0
	move $t2, $t0
	sub $t2, $t2, 1 # Subtract 1 from the number to be tested to ensure that the lower end of the sequence (user's number 1) is included within sequence.
	
	primeNumberLoop:
	add $t2, $t2, 1 # Add 1 to the number being tested each time the loop starts again.
	move $t3, $zero # Set the number used to test $t2 back to zero and increase by 2 to skip 1 and ensure the number being tested is being tested by all numbers.
	add $t3, $t3, 2 
	bgt $t2, $t1, endPrimeNumberLoop # If the numbers being tested greater the higher limit then all prime numbers within the sequence must have been found, so end the loop.
	testNumber: # Test each number by dividing by the current number used to test increases each loop of this inner loop. So the number be used to test is all the numbers before the potential prime number.
	beq $t2, $t3, outputPrimeNumber # If the number being used to test the potential prime number is the same then all numbers has been used an the result that is a prime number so output.
	bge $t3, $t1, primeNumberLoop # check to see if the number being used to test the current number has exceeded the higher limit. If so start the loop again. This is only to be used if the user has chosen '1' as a value. 
	div $t2, $t3 # Divide the potential prime by the numbers before.
	mfhi $t4 # Fetch the remainder
	beqz $t4, primeNumberLoop # If at any point a remainder equal zero then end this loop and check the next number in the sequence.
	add $t3, $t3, 1 # Increase the number being used test the potential prime number by 1
	j testNumber # Loop back around to test next number against the current potential prime number.	

	outputPrimeNumber: # Print out found prime number a space to seperate.
	li $v0, 1
	move $a0, $t2
	syscall
	
	jal printSpace
	
	j primeNumberLoop # Jump back to the start of the primeNumberLoop to test the next number.
			
	endPrimeNumberLoop: # End of the prime number loop create new and ask the user if they would like to return to main menu.

	jal nLine

	j returnToMenu

	# # # # # # # # #  
	#   Utilities   # 
	# # # # # # # # # 

	returnToMenu: # This shall allow the user to return to the main menu way the choose. Used by all options apart for option 12 since that quits the program. 
	
	li $v0, 4
	la $a0, returnMenuMsg
	syscall # Print the return to menu message.
	
	li $v0, 12
	syscall # Wait for the user to press the 'Enter' key since that submits content to read such as string or integers. However this case it is a character being read (a syscall service of 12 means read char) to ensure that the user can't input any unnecessary characters or words since they shall be discarded. 
	
	jal nLine
	
	jal resetTemporaries # Reset the temporaries to ensure no values are carried between options.

	j printMenu # goto menu to print the menu once again.

	resetTemporaries: # reset temp registers to ensure in correct calculations aren't being made.
	move $t0, $zero
	move $t1, $zero
	move $t2, $zero
	move $t3, $zero
	move $t4, $zero
	move $t5, $zero
	move $t6, $zero
	move $t7, $zero	
	move $t8, $zero
	move $t9, $zero
	
	jr $ra # Jump return back to the caller using its return address.

	nLine: # Creates a new line to be used throughout the program to help the user read by spacing content.
	li $v0, 4
	la $a0, newLine
	syscall
	
	jr $ra # Jump return back to the caller using its return address.
	
	printEqualSym:
	li $v0, 4
	la $a0, equalSym
	syscall
	
	jr $ra
	
	printSpace:
	li $v0, 4
	la $a0, space
	syscall

	jr $ra

	# # # # # # # # #
	#   Option 12   #
	# # # # # # # # #

	quit: # Successfully end the program by returning 10 (Exit).
	li $v0, 4
	la $a0, option12MsgA
	syscall
	
	li $v0, 10
	syscall



		;		;         ARM Programming Assignment #3: IEEE 754 to TNS bit-level marshaller
		;
		;		Write a program to convert a 32-bit single-precision IEEE 754 floating-point
		;		number to the Tandem Non-stop Series (TNS) format. Refer to the README for a
		;		description of the format. Convert the numbers in `floats` and write the TNS
		;		equivalents into the `tns` area, one after the other.
		;
		;		Bonus:
		;		1. (30 extra points) Implement the reverse conversion, from TNS to IEEE.
		;		2. (50 extra points) Organize the code into two subroutines, with stack
		;		support.
		;		3. (10 extra points) In the main program, implement a round-trip conversion
		;		and prove the results match the initial values in 'floats'.  Define a
		;		`FILL` region to hold the IEEE 754 results.
		;
		
		;		Your code here
		ADR		R2, floats
		LDR		R0, [R2]
		LDR		R1, [R2, #4]
		
		BL		ieeetns
		MOV		R7, #7
		END
		
ieeetns	ADR		R5, SIGNM
		ADR		R6, IEEEEXP
		ADR		R7, IEEESIGM
		LDR		R2, [R5]
		LDR		R3, [R6]
		LDR		R4, [R7]
		AND		R5, R0, R2
		AND		R6, R0, R3
		MOV		R6, r6, LSR #23
		ADD		R6, R6, #129
		AND		R7, R0, R4
		ADD		R7, R8, R7, LSL #8
		ORR		R8, R5, R6
		ORR		R8, R8, R7
		MOV		PC, LR
		
		
		
floats	DCD		0xa0bcff0d, 0x13c0adea
tns		FILL		16
		
SIGNM	DCD		0x80000000  ; sign bit
IEEEEXP	DCD		0x7F800000  ; IEEE Exponent
IEEESIGM	DCD		0xFFFF007F  ; IEEE Significand
TNSSIG	DCD		0xFE007FFF  ; TNS Significand
TNSEXP	DCD		0x01FF0000  ; TNS Exponent

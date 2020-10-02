	.file	"snake.c"
	.globl	main                            // -- Begin function main
main:                                   // @main
// %bb.0:
	DATA	R2, -18
	ADD	R2, R3
	CLF
	DATA	R0, 7
	OUT	Addr, R0
	DATA	R2, Ltmp0
	STORE	R3, R2
	JMP	prepare_multiplication_table
Ltmp0:
	DATA	R2, Ltmp1
	STORE	R3, R2
	JMP	fill_level
Ltmp1:
	DATA	R0, __const.initialize_snake.coords+1
	LOAD	R0, R0
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, snake+3
	STORE	R1, R0
	DATA	R0, 1
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 14
	ADD	R3, R1
	ADD	R0, R1
	CLF
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, __const.initialize_snake.coords
	LOAD	R0, R1
	DATA	R0, snake+2
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	STORE	R0, R1
	DATA	R2, 14
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, head_index
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	ADD	R0, R1
	CLF
	DATA	R0, SNAKE_PATTERN
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp2
	STORE	R3, R2
	JMP	set_cell_content
Ltmp2:
	DATA	R1, 199
	DATA	R0, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	CLF
	CMP	R1, R0
	JA	BB0_1
// %bb.2:
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	JMP	BB0_3
BB0_1:
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
BB0_3:
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R1, 2
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	DATA	R2, 14
	ADD	R3, R2
	STORE	R2, R1
	SHL	R0
	CLF
	XOR	R1, R1
	ADD	R0, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, snake+1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	ADD	R0, R1
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, snake
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp3
	STORE	R3, R2
	JMP	set_cell_content
Ltmp3:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R0, R1
	JA	BB0_4
// %bb.5:
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	JMP	BB0_6
BB0_4:
	XOR	R0, R0
	ADD	R1, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	XOR	R1, R1
	ADD	R0, R1
BB0_6:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, 3
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 14
	ADD	R3, R2
	STORE	R2, R0
	SHL	R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp4
	STORE	R3, R2
	JMP	set_cell_content
Ltmp4:
	DATA	R0, direction
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, tail_index
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	JMP	BB0_7
BB0_8:                                  //   Parent Loop BB0_7 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB0_42 Depth 3
	DATA	R0, 15
	OUT	Addr, R0
	IN	Data, R1
	DATA	R0, 263
	CLF
	CMP	R1, R0
	JA	BB0_13
	JMP	BB0_9
BB0_13:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 264
	CLF
	CMP	R1, R0
	JE	BB0_17
// %bb.14:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 265
	XOR	R0, R1
	DATA	R0, 0
	CLF
	CMP	R1, R0
	JA	BB0_24
// %bb.15:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, direction
	LOAD	R1, R1
	DATA	R0, -2
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R1, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	AND	R0, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 2
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R0, R1
	JE	BB0_22
// %bb.16:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 9
	JMP	BB0_21
BB0_9:                                  //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 262
	CLF
	CMP	R1, R0
	JE	BB0_19
// %bb.10:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 263
	CLF
	CMP	R1, R0
	JE	BB0_11
	JMP	BB0_24
BB0_11:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, direction
	LOAD	R0, R0
	DATA	R1, 2
	CLF
	CMP	R0, R1
	JA	BB0_23
// %bb.12:                              //   in Loop: Header=BB0_8 Depth=2
	XOR	R0, R0
	ADD	R1, R0
	JMP	BB0_23
BB0_17:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, direction
	LOAD	R0, R0
	DATA	R1, -2
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R0
	AND	R0, R1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 2
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 1
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R0, R1
	JE	BB0_22
// %bb.18:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 8
	JMP	BB0_21
BB0_19:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, direction
	LOAD	R0, R0
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 2
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 3
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R1, R0
	JA	BB0_22
// %bb.20:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 10
BB0_21:                                 //   in Loop: Header=BB0_8 Depth=2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
BB0_22:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
BB0_23:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R1, direction
	STORE	R1, R0
BB0_24:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 7
	OUT	Addr, R0
	DATA	R1, 1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 12
	ADD	R3, R0
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, head_index
	LOAD	R0, R0
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	SHL	R0
	CLF
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, snake+1
	ADD	R0, R1
	CLF
	LOAD	R1, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R1, snake
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	LOAD	R1, R0
	DATA	R2, 12
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, direction
	LOAD	R0, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R1, R0
	JA	BB0_28
// %bb.25:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 0
	CLF
	CMP	R1, R0
	JE	BB0_31
// %bb.26:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 1
	CLF
	CMP	R1, R0
	JE	BB0_27
	JMP	BB0_34
BB0_27:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R1, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	JMP	BB0_34
BB0_28:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 2
	CLF
	CMP	R1, R0
	JE	BB0_32
// %bb.29:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 3
	CLF
	CMP	R1, R0
	JE	BB0_30
	JMP	BB0_34
BB0_30:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 1
	JMP	BB0_33
BB0_31:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 1
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, -1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	JMP	BB0_34
BB0_32:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, -1
BB0_33:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R1, 12
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 12
	ADD	R3, R2
	STORE	R2, R1
BB0_34:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 1
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	ADD	R0, R1
	CLF
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R1
	LOAD	R1, R0
	DATA	R1, multiplication_table_one_row
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R0, R1
	CLF
	LOAD	R1, R0
	DATA	R1, 12
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	ADD	R1, R0
	CLF
	DATA	R1, grid
	ADD	R0, R1
	CLF
	LOAD	R1, R0
	DATA	R1, 0
	CLF
	CMP	R0, R1
	JE	BB0_53
// %bb.35:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 199
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JA	BB0_36
// %bb.37:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB0_38
BB0_53:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R0, 199
	DATA	R1, 0
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	CLF
	CMP	R0, R1
	JA	BB0_54
// %bb.55:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	JMP	BB0_56
BB0_36:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB0_38:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, apple
	LOAD	R0, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R0, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R1, R0
	JA	BB0_41
// %bb.39:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, apple+1
	LOAD	R0, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R0, R1
	DATA	R0, 0
	CLF
	CMP	R1, R0
	JA	BB0_41
	JMP	BB0_40
BB0_41:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, tail_index
	LOAD	R0, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JE	BB0_46
	JMP	BB0_42
BB0_46:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, __const.initialize_snake.coords+1
	LOAD	R0, R0
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, snake+3
	STORE	R1, R0
	DATA	R0, 1
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 16
	ADD	R3, R1
	ADD	R0, R1
	CLF
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, __const.initialize_snake.coords
	LOAD	R0, R1
	DATA	R0, snake+2
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	STORE	R0, R1
	DATA	R2, 16
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, head_index
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	ADD	R0, R1
	CLF
	DATA	R0, SNAKE_PATTERN
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp5
	STORE	R3, R2
	JMP	set_cell_content
Ltmp5:
	DATA	R1, 199
	DATA	R0, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	CLF
	CMP	R1, R0
	JA	BB0_47
// %bb.48:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	JMP	BB0_49
BB0_44:                                 //   in Loop: Header=BB0_42 Depth=3
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	XOR	R1, R1
	ADD	R0, R1
BB0_45:                                 //   in Loop: Header=BB0_42 Depth=3
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	XOR	R0, R0
	ADD	R1, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R1, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JA	BB0_42
	JMP	BB0_46
BB0_42:                                 //   Parent Loop BB0_7 Depth=1
                                        //     Parent Loop BB0_8 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R1
	ADD	R1, R0
	CLF
	DATA	R1, EMPTY_PATTERN
	STORE	R0, R1
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	SHL	R1
	CLF
	DATA	R0, snake
	ADD	R1, R0
	CLF
	DATA	R2, Ltmp6
	STORE	R3, R2
	JMP	set_cell_content
Ltmp6:
	DATA	R0, tail_index
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R1
	DATA	R0, 199
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 0
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R0, R1
	JA	BB0_43
	JMP	BB0_44
BB0_43:                                 //   in Loop: Header=BB0_42 Depth=3
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	JMP	BB0_45
BB0_54:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
BB0_56:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, head_index
	STORE	R0, R1
	SHL	R1
	CLF
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, snake+1
	ADD	R1, R0
	CLF
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, snake
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 12
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, SNAKE_PATTERN
	STORE	R0, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp7
	STORE	R3, R2
	JMP	set_cell_content
Ltmp7:
	DATA	R0, tail_index
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R3
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, EMPTY_PATTERN
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	SHL	R0
	CLF
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R2, Ltmp8
	STORE	R3, R2
	JMP	set_cell_content
Ltmp8:
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R1, R0
	JA	BB0_57
// %bb.58:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	JMP	BB0_59
BB0_57:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
BB0_59:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	JMP	BB0_8
BB0_47:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
BB0_49:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R1, 2
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	DATA	R2, 16
	ADD	R3, R2
	STORE	R2, R1
	SHL	R0
	CLF
	XOR	R1, R1
	ADD	R0, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, snake+1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	ADD	R0, R1
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, snake
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp9
	STORE	R3, R2
	JMP	set_cell_content
Ltmp9:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R0, R1
	JA	BB0_50
// %bb.51:                              //   in Loop: Header=BB0_8 Depth=2
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	JMP	BB0_52
BB0_50:                                 //   in Loop: Header=BB0_8 Depth=2
	XOR	R0, R0
	ADD	R1, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	XOR	R1, R1
	ADD	R0, R1
BB0_52:                                 //   in Loop: Header=BB0_8 Depth=2
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, 3
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 16
	ADD	R3, R2
	STORE	R2, R0
	SHL	R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp10
	STORE	R3, R2
	JMP	set_cell_content
Ltmp10:
	DATA	R0, direction
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, tail_index
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	JMP	BB0_8
BB0_40:                                 //   in Loop: Header=BB0_7 Depth=1
	DATA	R0, head_index
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	SHL	R1
	CLF
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, snake+1
	ADD	R1, R0
	CLF
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	LOAD	R1, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, snake
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 12
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, SNAKE_PATTERN
	STORE	R0, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp11
	STORE	R3, R2
	JMP	set_cell_content
Ltmp11:
BB0_7:                                  // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_8 Depth 2
                                        //       Child Loop BB0_42 Depth 3
	DATA	R2, Ltmp12
	STORE	R3, R2
	JMP	show_next_apple
Ltmp12:
	JMP	BB0_8
                                        // -- End function
	.globl	is_cell_occupied                // -- Begin function is_cell_occupied
is_cell_occupied:                       // @is_cell_occupied
// %bb.0:
	DATA	R2, -3
	ADD	R2, R3
	CLF
	DATA	R2, 1
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 1
	ADD	R0, R1
	CLF
	LOAD	R1, R0
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, multiplication_table_one_row
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	LOAD	R1, R1
	DATA	R0, 1
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
	DATA	R1, grid
	ADD	R0, R1
	CLF
	LOAD	R1, R1
	DATA	R2, 3
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	grow_snake                      // -- Begin function grow_snake
grow_snake:                             // @grow_snake
// %bb.0:
	DATA	R2, -6
	ADD	R2, R3
	CLF
	DATA	R0, head_index
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R1
	DATA	R0, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 199
	CLF
	CMP	R0, R1
	JA	BB2_1
// %bb.2:
	DATA	R1, 0
	JMP	BB2_3
BB2_1:
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
BB2_3:
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	SHL	R1
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, snake+1
	ADD	R1, R0
	CLF
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	LOAD	R0, R0
	DATA	R1, 2
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R0, snake
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	LOAD	R1, R1
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, SNAKE_PATTERN
	STORE	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp13
	STORE	R3, R2
	JMP	set_cell_content
Ltmp13:
	DATA	R2, 6
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	move_snake                      // -- Begin function move_snake
move_snake:                             // @move_snake
// %bb.0:
	DATA	R2, -9
	ADD	R2, R3
	CLF
	DATA	R0, head_index
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R1, 1
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 199
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 0
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R1, R0
	JA	BB3_1
// %bb.2:
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	JMP	BB3_3
BB3_1:
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
BB3_3:
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	SHL	R0
	CLF
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, snake+1
	ADD	R0, R1
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	LOAD	R1, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R1, snake
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	LOAD	R1, R1
	STORE	R0, R1
	XOR	R1, R1
	ADD	R3, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	XOR	R0, R0
	ADD	R1, R0
	DATA	R1, SNAKE_PATTERN
	STORE	R0, R1
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp14
	STORE	R3, R2
	JMP	set_cell_content
Ltmp14:
	DATA	R0, tail_index
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R3
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, EMPTY_PATTERN
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	SHL	R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R2, Ltmp15
	STORE	R3, R2
	JMP	set_cell_content
Ltmp15:
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R1, R0
	JA	BB3_4
// %bb.5:
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	JMP	BB3_6
BB3_4:
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
BB3_6:
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R2, 9
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	next_index                      // -- Begin function next_index
next_index:                             // @next_index
// %bb.0:
	DATA	R2, -1
	ADD	R2, R3
	CLF
	DATA	R1, 199
	CLF
	CMP	R1, R0
	JA	BB4_1
// %bb.2:
	DATA	R0, 0
	JMP	BB4_3
BB4_1:
	DATA	R1, 1
	ADD	R1, R0
	CLF
BB4_3:
	XOR	R1, R1
	ADD	R0, R1
	DATA	R2, 1
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	set_cell_content                // -- Begin function set_cell_content
set_cell_content:                       // @set_cell_content
// %bb.0:
	DATA	R2, -16
	ADD	R2, R3
	CLF
	DATA	R2, 12
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 1
	DATA	R2, 15
	ADD	R3, R2
	STORE	R2, R1
	XOR	R1, R1
	ADD	R0, R1
	DATA	R0, 15
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	LOAD	R1, R0
	DATA	R2, 14
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, multiplication_table_eight_rows
	DATA	R0, 14
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	LOAD	R1, R1
	DATA	R0, 12
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
	DATA	R2, 14
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, EMPTY_PATTERN
	DATA	R2, 13
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 17
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 0
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 13
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB5_2
// %bb.1:
	DATA	R1, 15
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R1
BB5_2:
	DATA	R1, 14
	ADD	R3, R1
	LOAD	R1, R1
	OUT	Data, R1
	DATA	R1, 15
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 15
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 3
	ADD	R0, R1
	CLF
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 2
	ADD	R0, R1
	CLF
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 7
	DATA	R2, 13
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 13
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 13
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 6
	ADD	R0, R1
	CLF
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 5
	ADD	R0, R1
	CLF
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 4
	ADD	R0, R1
	CLF
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 30
	DATA	R1, 14
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	OUT	Data, R0
	DATA	R0, 15
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R1, 210
	DATA	R0, 14
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R2, 15
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 180
	ADD	R0, R1
	CLF
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 150
	ADD	R0, R1
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 120
	ADD	R0, R1
	CLF
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 90
	ADD	R0, R1
	CLF
	DATA	R2, 1
	ADD	R3, R2
	STORE	R2, R1
	XOR	R1, R1
	ADD	R0, R1
	DATA	R0, 60
	ADD	R1, R0
	CLF
	OUT	Data, R0
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 1
	ADD	R3, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 15
	ADD	R3, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 13
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	OUT	Data, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	DATA	R1, multiplication_table_one_row
	ADD	R0, R1
	CLF
	LOAD	R1, R0
	DATA	R1, 12
	ADD	R3, R1
	LOAD	R1, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R0, grid
	ADD	R1, R0
	CLF
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R2, 16
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	kill_snake                      // -- Begin function kill_snake
kill_snake:                             // @kill_snake
// %bb.0:
	DATA	R2, -8
	ADD	R2, R3
	CLF
	DATA	R0, head_index
	LOAD	R0, R1
	DATA	R0, 199
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JA	BB6_1
// %bb.2:
	DATA	R0, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB6_3
BB6_1:
	DATA	R0, 1
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
BB6_3:
	DATA	R0, tail_index
	LOAD	R0, R1
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	CLF
	CMP	R1, R0
	JE	BB6_8
	JMP	BB6_4
BB6_8:
	DATA	R2, 8
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
BB6_6:                                  //   in Loop: Header=BB6_4 Depth=1
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R1
BB6_7:                                  //   in Loop: Header=BB6_4 Depth=1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R1, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JA	BB6_4
	JMP	BB6_8
BB6_4:                                  // =>This Inner Loop Header: Depth=1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	ADD	R1, R0
	CLF
	DATA	R1, EMPTY_PATTERN
	STORE	R0, R1
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	SHL	R1
	CLF
	DATA	R0, snake
	ADD	R1, R0
	CLF
	DATA	R2, Ltmp16
	STORE	R3, R2
	JMP	set_cell_content
Ltmp16:
	DATA	R0, tail_index
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R1, 199
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R1, R0
	JA	BB6_5
	JMP	BB6_6
BB6_5:                                  //   in Loop: Header=BB6_4 Depth=1
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R1, 2
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB6_7
                                        // -- End function
	.globl	next_head_position              // -- Begin function next_head_position
next_head_position:                     // @next_head_position
// %bb.0:
	DATA	R2, -5
	ADD	R2, R3
	CLF
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, head_index
	LOAD	R0, R1
	SHL	R1
	CLF
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, snake+1
	ADD	R1, R0
	CLF
	LOAD	R0, R0
	DATA	R2, 1
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 1
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 1
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, snake
	DATA	R1, 2
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	LOAD	R0, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R0, direction
	LOAD	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R1, R0
	JA	BB7_4
// %bb.1:
	DATA	R0, 0
	CLF
	CMP	R1, R0
	JE	BB7_7
// %bb.2:
	DATA	R0, 1
	CLF
	CMP	R1, R0
	JE	BB7_3
	JMP	BB7_11
BB7_3:
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	ADD	R0, R1
	CLF
	JMP	BB7_10
BB7_4:
	DATA	R0, 2
	CLF
	CMP	R1, R0
	JE	BB7_8
// %bb.5:
	DATA	R0, 3
	CLF
	CMP	R1, R0
	JE	BB7_6
	JMP	BB7_11
BB7_6:
	DATA	R0, 1
	JMP	BB7_9
BB7_7:
	DATA	R0, 1
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R0, -1
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB7_10
BB7_8:
	DATA	R0, -1
BB7_9:
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
BB7_10:
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	LOAD	R1, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
BB7_11:
	DATA	R2, 5
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	initialize_snake                // -- Begin function initialize_snake
initialize_snake:                       // @initialize_snake
// %bb.0:
	DATA	R2, -14
	ADD	R2, R3
	CLF
	DATA	R0, __const.initialize_snake.coords+1
	LOAD	R0, R0
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, snake+3
	STORE	R1, R0
	DATA	R0, 1
	DATA	R2, 11
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 12
	ADD	R3, R1
	ADD	R0, R1
	CLF
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, __const.initialize_snake.coords
	LOAD	R0, R1
	DATA	R0, snake+2
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	STORE	R0, R1
	DATA	R2, 12
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, head_index
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	ADD	R0, R1
	CLF
	DATA	R0, SNAKE_PATTERN
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp17
	STORE	R3, R2
	JMP	set_cell_content
Ltmp17:
	DATA	R1, 199
	DATA	R0, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	CLF
	CMP	R1, R0
	JA	BB8_1
// %bb.2:
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	JMP	BB8_3
BB8_1:
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
BB8_3:
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R1, 2
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	DATA	R2, 12
	ADD	R3, R2
	STORE	R2, R1
	SHL	R0
	CLF
	XOR	R1, R1
	ADD	R0, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, snake+1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	ADD	R0, R1
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, snake
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp18
	STORE	R3, R2
	JMP	set_cell_content
Ltmp18:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	LOAD	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R0, R1
	JA	BB8_4
// %bb.5:
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	JMP	BB8_6
BB8_4:
	XOR	R0, R0
	ADD	R1, R0
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	XOR	R1, R1
	ADD	R0, R1
BB8_6:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R0, R1
	DATA	R0, 3
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 12
	ADD	R3, R2
	STORE	R2, R0
	SHL	R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R1, R0
	CLF
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	XOR	R1, R1
	ADD	R3, R1
	DATA	R0, 11
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp19
	STORE	R3, R2
	JMP	set_cell_content
Ltmp19:
	DATA	R0, direction
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, tail_index
	DATA	R1, 11
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R2, 14
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	show_next_apple                 // -- Begin function show_next_apple
show_next_apple:                        // @show_next_apple
// %bb.0:
	DATA	R2, -11
	ADD	R2, R3
	CLF
BB9_1:                                  // =>This Loop Header: Depth=1
                                        //     Child Loop BB9_3 Depth 2
	DATA	R0, random.x
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 1
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	ADD	R1, R0
	CLF
	DATA	R1, 5
	STORE	R0, R1
	DATA	R1, 2
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	ADD	R1, R0
	CLF
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp20
	STORE	R3, R2
	JMP	shift
Ltmp20:
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, random.y
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R3, R1
	CLF
	DATA	R0, 0
	STORE	R1, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	STORE	R0, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R0, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R1, R0
	DATA	R2, Ltmp21
	STORE	R3, R2
	JMP	shift
Ltmp21:
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R0, R1
	SHR	R0
	CLF
	XOR	R1, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R1, R0
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R1, 31
	AND	R0, R1
	DATA	R0, 29
	CLF
	CMP	R1, R0
	JA	BB9_1
// %bb.2:                               //   in Loop: Header=BB9_1 Depth=1
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
BB9_3:                                  //   Parent Loop BB9_1 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	DATA	R0, random.x
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 1
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	ADD	R1, R0
	CLF
	DATA	R1, 5
	STORE	R0, R1
	DATA	R1, 2
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	ADD	R1, R0
	CLF
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp22
	STORE	R3, R2
	JMP	shift
Ltmp22:
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, random.y
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R3, R1
	CLF
	DATA	R0, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	STORE	R1, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	STORE	R0, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R0, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R1, R0
	DATA	R2, Ltmp23
	STORE	R3, R2
	JMP	shift
Ltmp23:
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R0, R1
	SHR	R0
	CLF
	XOR	R1, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R1, R0
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	XOR	R1, R1
	ADD	R0, R1
	DATA	R0, 31
	AND	R1, R0
	DATA	R1, 19
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	CLF
	CMP	R0, R1
	JA	BB9_3
// %bb.4:                               //   in Loop: Header=BB9_1 Depth=1
	DATA	R1, multiplication_table_one_row
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	LOAD	R1, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	XOR	R0, R0
	ADD	R1, R0
	DATA	R1, grid
	ADD	R0, R1
	CLF
	LOAD	R1, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R1, R0
	JA	BB9_1
// %bb.5:
	DATA	R1, apple+1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R1, apple
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, 1
	ADD	R3, R0
	CLF
	DATA	R1, APPLE_PATTERN
	STORE	R0, R1
	DATA	R0, 10
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp24
	STORE	R3, R2
	JMP	set_cell_content
Ltmp24:
	DATA	R2, 11
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	random                          // -- Begin function random
random:                                 // @random
// %bb.0:
	DATA	R2, -11
	ADD	R2, R3
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
BB10_1:                                 // =>This Inner Loop Header: Depth=1
	DATA	R0, random.x
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 1
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	ADD	R1, R0
	CLF
	DATA	R1, 5
	STORE	R0, R1
	DATA	R1, 2
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	ADD	R1, R0
	CLF
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp25
	STORE	R3, R2
	JMP	shift
Ltmp25:
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, random.y
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	LOAD	R0, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R3, R1
	CLF
	DATA	R0, 0
	STORE	R1, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	STORE	R0, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R0, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R1, R0
	DATA	R2, Ltmp26
	STORE	R3, R2
	JMP	shift
Ltmp26:
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 10
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R0, R1
	SHR	R0
	CLF
	XOR	R1, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	XOR	R1, R0
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R1, 31
	AND	R0, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R1, R0
	JAE	BB10_1
// %bb.2:
	DATA	R2, 11
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	fill_level                      // -- Begin function fill_level
fill_level:                             // @fill_level
// %bb.0:
	DATA	R2, -12
	ADD	R2, R3
	CLF
	DATA	R0, 0
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB11_1
BB11_45:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 2
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 20
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R1, R0
	JE	BB11_46
BB11_1:                                 // =>This Inner Loop Header: Depth=1
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 7
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, LEVEL
	ADD	R1, R0
	CLF
	LOAD	R0, R1
	DATA	R0, 16384
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	AND	R1, R0
	DATA	R1, 2
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB11_3
// %bb.2:                               //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 0
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp27
	STORE	R3, R2
	JMP	set_cell_content
Ltmp27:
BB11_3:                                 //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, -2
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 36
	CLF
	CMP	R1, R0
	JA	BB11_5
// %bb.4:                               //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp28
	STORE	R3, R2
	JMP	set_cell_content
Ltmp28:
	DATA	R0, 2
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp29
	STORE	R3, R2
	JMP	set_cell_content
Ltmp29:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R0, 3
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp30
	STORE	R3, R2
	JMP	set_cell_content
Ltmp30:
BB11_5:                                 //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 1024
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JE	BB11_7
// %bb.6:                               //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 4
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp31
	STORE	R3, R2
	JMP	set_cell_content
Ltmp31:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_7:                                 //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 512
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB11_9
// %bb.8:                               //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp32
	STORE	R3, R2
	JMP	set_cell_content
Ltmp32:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_9:                                 //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 256
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JE	BB11_11
// %bb.10:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 6
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp33
	STORE	R3, R2
	JMP	set_cell_content
Ltmp33:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_11:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 128
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB11_13
// %bb.12:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 7
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp34
	STORE	R3, R2
	JMP	set_cell_content
Ltmp34:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_13:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 64
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JE	BB11_15
// %bb.14:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 8
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp35
	STORE	R3, R2
	JMP	set_cell_content
Ltmp35:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_15:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 32
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB11_17
// %bb.16:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 9
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp36
	STORE	R3, R2
	JMP	set_cell_content
Ltmp36:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_17:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 16
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 0
	CLF
	CMP	R0, R1
	JE	BB11_19
// %bb.18:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 10
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp37
	STORE	R3, R2
	JMP	set_cell_content
Ltmp37:
BB11_19:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, -2
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 36
	CLF
	CMP	R1, R0
	JA	BB11_21
// %bb.20:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 11
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 1
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp38
	STORE	R3, R2
	JMP	set_cell_content
Ltmp38:
	DATA	R0, 12
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp39
	STORE	R3, R2
	JMP	set_cell_content
Ltmp39:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R0, 13
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp40
	STORE	R3, R2
	JMP	set_cell_content
Ltmp40:
BB11_21:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	AND	R1, R0
	DATA	R1, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JE	BB11_23
// %bb.22:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 14
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp41
	STORE	R3, R2
	JMP	set_cell_content
Ltmp41:
BB11_23:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, LEVEL+1
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	LOAD	R0, R1
	DATA	R0, 16384
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	AND	R1, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB11_25
// %bb.24:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 15
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp42
	STORE	R3, R2
	JMP	set_cell_content
Ltmp42:
	DATA	R0, 7
	ADD	R3, R0
	LOAD	R0, R0
BB11_25:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, -1
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 36
	CLF
	CMP	R1, R0
	JA	BB11_27
// %bb.26:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 16
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 1
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp43
	STORE	R3, R2
	JMP	set_cell_content
Ltmp43:
	DATA	R0, 17
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp44
	STORE	R3, R2
	JMP	set_cell_content
Ltmp44:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R0, 18
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp45
	STORE	R3, R2
	JMP	set_cell_content
Ltmp45:
BB11_27:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 1024
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JE	BB11_29
// %bb.28:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 19
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp46
	STORE	R3, R2
	JMP	set_cell_content
Ltmp46:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_29:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 512
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB11_31
// %bb.30:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 20
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp47
	STORE	R3, R2
	JMP	set_cell_content
Ltmp47:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_31:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 256
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JE	BB11_33
// %bb.32:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 21
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp48
	STORE	R3, R2
	JMP	set_cell_content
Ltmp48:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_33:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 128
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB11_35
// %bb.34:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 22
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp49
	STORE	R3, R2
	JMP	set_cell_content
Ltmp49:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_35:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 64
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	CLF
	CMP	R0, R1
	JE	BB11_37
// %bb.36:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 23
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp50
	STORE	R3, R2
	JMP	set_cell_content
Ltmp50:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_37:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 32
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R0, R1
	JE	BB11_39
// %bb.38:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 24
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp51
	STORE	R3, R2
	JMP	set_cell_content
Ltmp51:
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
BB11_39:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 16
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	AND	R1, R0
	DATA	R1, 0
	CLF
	CMP	R0, R1
	JE	BB11_41
// %bb.40:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 25
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp52
	STORE	R3, R2
	JMP	set_cell_content
Ltmp52:
BB11_41:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, -1
	DATA	R1, 7
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 36
	CLF
	CMP	R1, R0
	JA	BB11_43
// %bb.42:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 26
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 1
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 10
	ADD	R3, R0
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	ADD	R1, R0
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 9
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 9
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp53
	STORE	R3, R2
	JMP	set_cell_content
Ltmp53:
	DATA	R0, 27
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp54
	STORE	R3, R2
	JMP	set_cell_content
Ltmp54:
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R1, R0
	DATA	R0, 28
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R0
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp55
	STORE	R3, R2
	JMP	set_cell_content
Ltmp55:
BB11_43:                                //   in Loop: Header=BB11_1 Depth=1
	DATA	R0, 1
	DATA	R1, 8
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 6
	ADD	R3, R2
	STORE	R2, R0
	AND	R0, R1
	DATA	R0, 0
	CLF
	CMP	R1, R0
	JE	BB11_45
// %bb.44:                              //   in Loop: Header=BB11_1 Depth=1
	DATA	R1, 10
	ADD	R3, R1
	DATA	R2, 8
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 9
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R1, 29
	DATA	R2, 10
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, WALL_PATTERN
	STORE	R0, R1
	DATA	R0, 8
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp56
	STORE	R3, R2
	JMP	set_cell_content
Ltmp56:
	JMP	BB11_45
BB11_46:
	DATA	R2, 12
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	poll_input                      // -- Begin function poll_input
poll_input:                             // @poll_input
// %bb.0:
	DATA	R2, -5
	ADD	R2, R3
	CLF
	DATA	R0, 15
	OUT	Addr, R0
	IN	Data, R1
	DATA	R0, 263
	CLF
	CMP	R1, R0
	JA	BB12_5
// %bb.1:
	DATA	R0, 262
	CLF
	CMP	R1, R0
	JE	BB12_11
// %bb.2:
	DATA	R0, 263
	CLF
	CMP	R1, R0
	JE	BB12_3
	JMP	BB12_16
BB12_3:
	DATA	R0, direction
	LOAD	R0, R0
	DATA	R1, 2
	CLF
	CMP	R0, R1
	JA	BB12_15
// %bb.4:
	XOR	R0, R0
	ADD	R1, R0
	JMP	BB12_15
BB12_5:
	DATA	R0, 264
	CLF
	CMP	R1, R0
	JE	BB12_9
// %bb.6:
	DATA	R0, 265
	XOR	R0, R1
	DATA	R0, 0
	CLF
	CMP	R1, R0
	JA	BB12_16
// %bb.7:
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, direction
	LOAD	R1, R1
	DATA	R0, -2
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R1, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	AND	R0, R1
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	DATA	R1, 2
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R0, R1
	JE	BB12_14
// %bb.8:
	DATA	R0, 2
	JMP	BB12_13
BB12_11:
	DATA	R0, direction
	LOAD	R0, R0
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 2
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 3
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 2
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R1, R0
	JA	BB12_14
// %bb.12:
	DATA	R0, 3
	JMP	BB12_13
BB12_9:
	DATA	R0, direction
	LOAD	R0, R0
	DATA	R1, -2
	DATA	R2, 1
	ADD	R3, R2
	STORE	R2, R0
	AND	R0, R1
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	DATA	R0, 2
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 1
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	CLF
	CMP	R0, R1
	JE	BB12_14
// %bb.10:
	DATA	R0, 1
BB12_13:
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
BB12_14:
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
BB12_15:
	DATA	R1, direction
	STORE	R1, R0
BB12_16:
	DATA	R0, 7
	OUT	Addr, R0
	DATA	R2, 5
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	prepare_multiplication_table    // -- Begin function prepare_multiplication_table
prepare_multiplication_table:           // @prepare_multiplication_table
// %bb.0:
	DATA	R2, -6
	ADD	R2, R3
	CLF
	DATA	R1, 1
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R1
	XOR	R0, R0
	ADD	R3, R0
	ADD	R1, R0
	CLF
	DATA	R1, 30
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	DATA	R0, 0
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp57
	STORE	R3, R2
	JMP	multiply
Ltmp57:
	DATA	R0, multiplication_table_one_row
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 240
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp58
	STORE	R3, R2
	JMP	multiply
Ltmp58:
	DATA	R0, multiplication_table_eight_rows
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp59
	STORE	R3, R2
	JMP	multiply
Ltmp59:
	DATA	R0, multiplication_table_one_row+1
	STORE	R0, R1
	XOR	R1, R1
	ADD	R3, R1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	ADD	R0, R1
	CLF
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	STORE	R1, R0
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp60
	STORE	R3, R2
	JMP	multiply
Ltmp60:
	DATA	R0, multiplication_table_eight_rows+1
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp61
	STORE	R3, R2
	JMP	multiply
Ltmp61:
	DATA	R0, multiplication_table_one_row+2
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp62
	STORE	R3, R2
	JMP	multiply
Ltmp62:
	DATA	R0, multiplication_table_eight_rows+2
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 3
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp63
	STORE	R3, R2
	JMP	multiply
Ltmp63:
	DATA	R0, multiplication_table_one_row+3
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp64
	STORE	R3, R2
	JMP	multiply
Ltmp64:
	DATA	R0, multiplication_table_eight_rows+3
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 4
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp65
	STORE	R3, R2
	JMP	multiply
Ltmp65:
	DATA	R0, multiplication_table_one_row+4
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp66
	STORE	R3, R2
	JMP	multiply
Ltmp66:
	DATA	R0, multiplication_table_eight_rows+4
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 5
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp67
	STORE	R3, R2
	JMP	multiply
Ltmp67:
	DATA	R0, multiplication_table_one_row+5
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp68
	STORE	R3, R2
	JMP	multiply
Ltmp68:
	DATA	R0, multiplication_table_eight_rows+5
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 6
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp69
	STORE	R3, R2
	JMP	multiply
Ltmp69:
	DATA	R0, multiplication_table_one_row+6
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp70
	STORE	R3, R2
	JMP	multiply
Ltmp70:
	DATA	R0, multiplication_table_eight_rows+6
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 7
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp71
	STORE	R3, R2
	JMP	multiply
Ltmp71:
	DATA	R0, multiplication_table_one_row+7
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp72
	STORE	R3, R2
	JMP	multiply
Ltmp72:
	DATA	R0, multiplication_table_eight_rows+7
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 8
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp73
	STORE	R3, R2
	JMP	multiply
Ltmp73:
	DATA	R0, multiplication_table_one_row+8
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp74
	STORE	R3, R2
	JMP	multiply
Ltmp74:
	DATA	R0, multiplication_table_eight_rows+8
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 9
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp75
	STORE	R3, R2
	JMP	multiply
Ltmp75:
	DATA	R0, multiplication_table_one_row+9
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp76
	STORE	R3, R2
	JMP	multiply
Ltmp76:
	DATA	R0, multiplication_table_eight_rows+9
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 10
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp77
	STORE	R3, R2
	JMP	multiply
Ltmp77:
	DATA	R0, multiplication_table_one_row+10
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp78
	STORE	R3, R2
	JMP	multiply
Ltmp78:
	DATA	R0, multiplication_table_eight_rows+10
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 11
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp79
	STORE	R3, R2
	JMP	multiply
Ltmp79:
	DATA	R0, multiplication_table_one_row+11
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp80
	STORE	R3, R2
	JMP	multiply
Ltmp80:
	DATA	R0, multiplication_table_eight_rows+11
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 12
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp81
	STORE	R3, R2
	JMP	multiply
Ltmp81:
	DATA	R0, multiplication_table_one_row+12
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp82
	STORE	R3, R2
	JMP	multiply
Ltmp82:
	DATA	R0, multiplication_table_eight_rows+12
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 13
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp83
	STORE	R3, R2
	JMP	multiply
Ltmp83:
	DATA	R0, multiplication_table_one_row+13
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp84
	STORE	R3, R2
	JMP	multiply
Ltmp84:
	DATA	R0, multiplication_table_eight_rows+13
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 14
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp85
	STORE	R3, R2
	JMP	multiply
Ltmp85:
	DATA	R0, multiplication_table_one_row+14
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp86
	STORE	R3, R2
	JMP	multiply
Ltmp86:
	DATA	R0, multiplication_table_eight_rows+14
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 15
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp87
	STORE	R3, R2
	JMP	multiply
Ltmp87:
	DATA	R0, multiplication_table_one_row+15
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp88
	STORE	R3, R2
	JMP	multiply
Ltmp88:
	DATA	R0, multiplication_table_eight_rows+15
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 16
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp89
	STORE	R3, R2
	JMP	multiply
Ltmp89:
	DATA	R0, multiplication_table_one_row+16
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp90
	STORE	R3, R2
	JMP	multiply
Ltmp90:
	DATA	R0, multiplication_table_eight_rows+16
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 17
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp91
	STORE	R3, R2
	JMP	multiply
Ltmp91:
	DATA	R0, multiplication_table_one_row+17
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp92
	STORE	R3, R2
	JMP	multiply
Ltmp92:
	DATA	R0, multiplication_table_eight_rows+17
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 18
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp93
	STORE	R3, R2
	JMP	multiply
Ltmp93:
	DATA	R0, multiplication_table_one_row+18
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp94
	STORE	R3, R2
	JMP	multiply
Ltmp94:
	DATA	R0, multiplication_table_eight_rows+18
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 4
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 19
	DATA	R2, 4
	ADD	R3, R2
	STORE	R2, R0
	DATA	R2, Ltmp95
	STORE	R3, R2
	JMP	multiply
Ltmp95:
	DATA	R0, multiplication_table_one_row+19
	STORE	R0, R1
	XOR	R0, R0
	ADD	R3, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R1, R0
	CLF
	DATA	R1, 3
	ADD	R3, R1
	LOAD	R1, R1
	STORE	R0, R1
	DATA	R0, 4
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, Ltmp96
	STORE	R3, R2
	JMP	multiply
Ltmp96:
	DATA	R0, multiplication_table_eight_rows+19
	STORE	R0, R1
	DATA	R2, 6
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	multiply                        // -- Begin function multiply
multiply:                               // @multiply
// %bb.0:
	DATA	R2, -4
	ADD	R2, R3
	CLF
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 0
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB14_1
BB14_1:                                 // =>This Inner Loop Header: Depth=1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 0
	CLF
	CMP	R0, R1
	JE	BB14_5
	JMP	BB14_2
BB14_2:                                 //   in Loop: Header=BB14_1 Depth=1
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 1
	AND	R1, R0
	DATA	R2, 1
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 1
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 0
	CLF
	CMP	R0, R1
	JE	BB14_4
	JMP	BB14_3
BB14_3:                                 //   in Loop: Header=BB14_1 Depth=1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 2
	ADD	R3, R1
	LOAD	R1, R1
	ADD	R0, R1
	CLF
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R1
	JMP	BB14_4
BB14_4:                                 //   in Loop: Header=BB14_1 Depth=1
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	SHL	R0
	CLF
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 5
	ADD	R3, R0
	LOAD	R0, R0
	SHR	R0
	CLF
	DATA	R2, 5
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB14_1
BB14_5:
	DATA	R1, 2
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 4
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	shift                           // -- Begin function shift
shift:                                  // @shift
// %bb.0:
	DATA	R2, -4
	ADD	R2, R3
	CLF
	DATA	R1, 6
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 3
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 3
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	DATA	R0, 0
	DATA	R2, 1
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB15_1
BB15_1:                                 // =>This Inner Loop Header: Depth=1
	DATA	R0, 1
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 5
	ADD	R3, R1
	LOAD	R1, R1
	CLF
	CMP	R1, R0
	JA	BB15_3
	JMP	BB15_2
BB15_2:
	JMP	BB15_8
BB15_3:                                 //   in Loop: Header=BB15_1 Depth=1
	DATA	R0, 6
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 0
	CLF
	CMP	R0, R1
	JE	BB15_5
	JMP	BB15_4
BB15_4:                                 //   in Loop: Header=BB15_1 Depth=1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	SHL	R0
	CLF
	JMP	BB15_6
BB15_5:                                 //   in Loop: Header=BB15_1 Depth=1
	DATA	R0, 2
	ADD	R3, R0
	LOAD	R0, R0
	SHR	R0
	CLF
	JMP	BB15_6
BB15_6:                                 //   in Loop: Header=BB15_1 Depth=1
	DATA	R2, 2
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB15_7
BB15_7:                                 //   in Loop: Header=BB15_1 Depth=1
	DATA	R0, 1
	ADD	R3, R0
	LOAD	R0, R0
	DATA	R1, 1
	ADD	R1, R0
	CLF
	DATA	R2, 1
	ADD	R3, R2
	STORE	R2, R0
	JMP	BB15_1
BB15_8:
	DATA	R1, 2
	ADD	R3, R1
	LOAD	R1, R1
	DATA	R2, 4
	ADD	R2, R3
	LOAD	R3, R2
	JMPR	R2
                                        // -- End function
	.globl	DISPLAY_ADDR                    // @DISPLAY_ADDR
DISPLAY_ADDR:
	.byte	7                               // 0x7

	.globl	KEY_ADAPTER_ADDR                // @KEY_ADAPTER_ADDR
KEY_ADAPTER_ADDR:
	.byte	15                              // 0xf

	.globl	MAX_SNAKE_LENGTH                // @MAX_SNAKE_LENGTH
MAX_SNAKE_LENGTH:
	.byte	200                             // 0xc8

	.globl	GRID_WIDTH                      // @GRID_WIDTH
GRID_WIDTH:
	.byte	30                              // 0x1e

	.globl	GRID_HEIGHT                     // @GRID_HEIGHT
GRID_HEIGHT:
	.byte	20                              // 0x14

	.globl	KEY_LEFT                        // @KEY_LEFT
KEY_LEFT:
	.byte	263                             // 0x107

	.globl	KEY_RIGHT                       // @KEY_RIGHT
KEY_RIGHT:
	.byte	262                             // 0x106

	.globl	KEY_UP                          // @KEY_UP
KEY_UP:
	.byte	265                             // 0x109

	.globl	KEY_DOWN                        // @KEY_DOWN
KEY_DOWN:
	.byte	264                             // 0x108

	.globl	APPLE_PATTERN                   // @APPLE_PATTERN
APPLE_PATTERN:
	.byte	40                              // 0x28
	.byte	16                              // 0x10
	.byte	8                               // 0x8
	.byte	60                              // 0x3c
	.byte	126                             // 0x7e
	.byte	126                             // 0x7e
	.byte	126                             // 0x7e
	.byte	60                              // 0x3c

	.globl	SNAKE_PATTERN                   // @SNAKE_PATTERN
SNAKE_PATTERN:
	.byte	126                             // 0x7e
	.byte	255                             // 0xff
	.byte	195                             // 0xc3
	.byte	195                             // 0xc3
	.byte	195                             // 0xc3
	.byte	195                             // 0xc3
	.byte	255                             // 0xff
	.byte	126                             // 0x7e

	.globl	WALL_PATTERN                    // @WALL_PATTERN
WALL_PATTERN:
	.byte	0                               // 0x0
	.byte	126                             // 0x7e
	.byte	66                              // 0x42
	.byte	90                              // 0x5a
	.byte	90                              // 0x5a
	.byte	66                              // 0x42
	.byte	126                             // 0x7e
	.byte	0                               // 0x0

	.globl	EMPTY_PATTERN                   // @EMPTY_PATTERN
EMPTY_PATTERN:
	.zero	8

	.globl	LEVEL_DATA_ITEM_LENGTH          // @LEVEL_DATA_ITEM_LENGTH
LEVEL_DATA_ITEM_LENGTH:
	.byte	15                              // 0xf

	.globl	LEVEL                           // @LEVEL
LEVEL:
	.byte	32767                           // 0x7fff
	.byte	32767                           // 0x7fff
	.byte	16384                           // 0x4000
	.byte	1                               // 0x1
	.byte	16384                           // 0x4000
	.byte	1                               // 0x1
	.byte	16384                           // 0x4000
	.byte	1                               // 0x1
	.byte	17392                           // 0x43f0
	.byte	2017                            // 0x7e1
	.byte	16896                           // 0x4200
	.byte	33                              // 0x21
	.byte	16896                           // 0x4200
	.byte	33                              // 0x21
	.byte	16896                           // 0x4200
	.byte	33                              // 0x21
	.byte	16896                           // 0x4200
	.byte	33                              // 0x21
	.byte	16384                           // 0x4000
	.byte	1                               // 0x1
	.byte	16384                           // 0x4000
	.byte	1                               // 0x1
	.byte	16896                           // 0x4200
	.byte	33                              // 0x21
	.byte	16896                           // 0x4200
	.byte	33                              // 0x21
	.byte	16896                           // 0x4200
	.byte	33                              // 0x21
	.byte	16896                           // 0x4200
	.byte	33                              // 0x21
	.byte	17392                           // 0x43f0
	.byte	2017                            // 0x7e1
	.byte	16384                           // 0x4000
	.byte	1                               // 0x1
	.byte	16384                           // 0x4000
	.byte	1                               // 0x1
	.byte	16384                           // 0x4000
	.byte	1                               // 0x1
	.byte	32767                           // 0x7fff
	.byte	32767                           // 0x7fff

	.globl	head_index                      // @head_index
head_index:
	.byte	0                               // 0x0

	.globl	tail_index                      // @tail_index
tail_index:
	.byte	0                               // 0x0

	.globl	direction                       // @direction
direction:
	.byte	3                               // 0x3

	.globl	apple                           // @apple
apple:
	.zero	2

	.globl	snake                           // @snake
snake:
	.zero	400

__const.initialize_snake.coords:        // @__const.initialize_snake.coords
	.byte	1                               // 0x1
	.byte	1                               // 0x1

	.globl	multiplication_table_eight_rows // @multiplication_table_eight_rows
multiplication_table_eight_rows:
	.zero	20

	.globl	multiplication_table_one_row    // @multiplication_table_one_row
multiplication_table_one_row:
	.zero	20

	.globl	grid                            // @grid
grid:
	.zero	600

random.x:                               // @random.x
	.byte	1                               // 0x1

random.y:                               // @random.y
	.byte	1                               // 0x1


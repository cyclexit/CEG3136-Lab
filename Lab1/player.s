
  AREA    |.text|, CODE, READONLY
  PRESERVE8;
  THUMB;


  EXPORT player_check_move_s

player_check_move_s FUNCTION	; char player_check_move_s(player_t *player, int row, int col);
	; r0 *player
	; r1 row
	; r2 col

	PUSH {R6, R7, R8}
	LDRH R6, [R0] ; R6 = player->state
	LSL R7, R1, #2 ; R7 = row << 2
	ADD R7, R7, R2 ; R7 = R7 + col
	MOV R8, #1 ; R8 = 1
	LSL R8, R8, R7 ; R8 = R8 << R7
	AND R8, R6 ; R8 = R8 & R6
	CMP R8, #0
	BNE RET0
	MOV	R0, #1					; 
	BX	LR						; return
RET0
	MOV R0, #0
	BX	LR						; return

  ENDFUNC
  

  EXPORT player_make_move_s

player_make_move_s FUNCTION	; char player_make_move_s(player_t *player, int row, int col);
	; r0 *player
	; r1 row
	; r2 col

	PUSH {R6, R7, R8, R9, LR}
	LDRH R6, [R0] ; R6 = player->state
	LSL R7, R1, #2 ; R7 = row << 2
	ADD R7, R7, R2 ; R7 = R7 + col
	MOV R8, #1 ; R8 = 1
	LSL R8, R8, R7 ; R8 = R8 << R7
	MOV R9, R8
	AND R8, R6 ; R8 = R8 & R6
	CMP R8, #0
	BNE RET0_1
	ORR R9, R6 ; R9 |= R6
	STRH R9, [R0]
	MOV	R0, #1					;
	BX	LR						; return
RET0_1
	MOV R0, #0
	BX	LR						; return

  ENDFUNC
  
  EXPORT player_won_s

player_won_s FUNCTION	; char player_won_s(player_t * player);
	; r0 *player
	MOV	R0, #0					; 
	BX	LR						; return
  ENDFUNC
  
  END

  AREA    |.text|, CODE, READONLY
  PRESERVE8;
  THUMB;


  EXPORT player_check_move_s

player_check_move_s FUNCTION	; char player_check_move_s(player_t *player, int row, int col);
	; r0 *player
	; r1 row
	; r2 col
	
	PUSH {R3, R4, R5}
	LDRH R3, [R0] ; R3 = player->state
	LSL R4, R1, #2 ; R4 = row << 2
	ADD R4, R4, R2 ; R4 = R4 + col
	MOV R5, #1 ; R5 = 1
	LSL R5, R5, R4 ; R5 = R5 << R4
	AND R5, R3 ; R5 = R5 & R3
	TST R5, #1
	CBNZ R0, RET1
	MOV	R0, #0					; 
	BX	LR						; return
RET1
	MOV R0, #1
	BX	LR						; return

  ENDFUNC
  

  EXPORT player_make_move_s

player_make_move_s FUNCTION	; char player_make_move_s(player_t *player, int row, int col);
	; r0 *player
	; r1 row
	; r2 col
	
	PUSH {R3, R4, R5, R6}
	LDRH R3, [R0] ; R3 = player->state
	LSL R4, R1, #2 ; R4 = row << 2
	ADD R4, R4, R2 ; R4 = R4 + col
	MOV R5, #1 ; R5 = 1
	LSL R5, R5, R4 ; R5 = R5 << R4
	MOV R6, R5
	AND R5, R3 ; R5 = R5 & R3
	TST R5, #1
	CBNZ R0, STORE
	MOV	R0, #0					;
	BX	LR						; return
STORE 
	ORR R6, R3 ; R6 |= R3
	STRH R6, [R0]
	MOV R0, #1
	BX	LR						; return

  ENDFUNC
  
  EXPORT player_won_s

player_won_s FUNCTION	; char player_won_s(player_t * player);
	; r0 *player
	MOV	R0, #0					; 
	BX	LR						; return
  ENDFUNC
  
  END
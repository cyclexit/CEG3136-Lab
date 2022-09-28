	AREA    |.text|, CODE, READONLY
	PRESERVE8;
	THUMB;

player_check_move_s FUNCTION	; char player_check_move_s(player_t *player, int row, int col);
	EXPORT player_check_move_s
	; r0 *player
	; r1 row
	; r2 col
	PUSH {r4-r5, lr}			; push registers
	MOV r3, r0
	LDRH r0, [r3, #0x00]
	ADD r5, r2, r1, LSL #2
	MOVS r4, #0x01
	LSLS r4, r4, r5
	AND r0, r0, r4
	CBZ r0, mov1
	MOV	r0, #0					;
return POP {r4-r5, pc}			; pop the registers
mov1 MOV r0, #1
	B return
	ENDFUNC

player_make_move_s FUNCTION	; char player_make_move_s(player_t *player, int row, int col);
	EXPORT player_make_move_s
	; r0 *player
	; r1 row
	; r2 col
	PUSH {r4-r5, lr}
	MOV r3, r0
	LDRH r0, [r3, #0x00]
	ADD r5, r2, r1, LSL #2
	MOVS r4, #0x01
	LSLS r4, r4, r5
	AND r0, r0, r4
	CBZ r0, store
	MOVS r0, #0x00
return1 POP {r4-r5, pc}
store LDRH r0, [r3, #0x00]
	ORRS r0, r0, r4
	STRH r0, [r3, #00]
	MOVS r0, #0x01
	B return1
	ENDFUNC

player_won_s FUNCTION	; char player_won_s(player_t * player);
	EXPORT player_won_s
	; r0 *player

	MOV	r0, #0					; 
	BX	lr						; return
	ENDFUNC
  
	END
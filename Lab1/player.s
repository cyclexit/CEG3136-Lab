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
	LDRH r0, [r3, #0]
	ADD r5, r2, r1, LSL #2
	MOVS r4, #1
	LSLS r4, r4, r5
	AND r0, r0, r4
	CBZ r0, pcms_rc1
	MOV	r0, #0					;
pcms_return POP {r4-r5, pc}			; pop the registers
pcms_rc1 MOV r0, #1
	B pcms_return
	ENDFUNC

player_make_move_s FUNCTION	; char player_make_move_s(player_t *player, int row, int col);
	EXPORT player_make_move_s
	; r0 *player
	; r1 row
	; r2 col
	PUSH {r4-r5, lr}
	MOV r3, r0
	LDRH r0, [r3, #0]
	ADD r5, r2, r1, LSL #2
	MOVS r4, #1
	LSLS r4, r4, r5
	AND r0, r0, r4
	CBZ r0, pmms_store
	MOVS r0, #0
pmms_return POP {r4-r5, pc}
pmms_store LDRH r0, [r3, #0]
	ORRS r0, r0, r4
	STRH r0, [r3, #0]
	MOVS r0, #1
	B pmms_return
	ENDFUNC

player_won_s FUNCTION	; char player_won_s(player_t * player);
	EXPORT player_won_s
	; r0 *player
	MOV r1, r0
	MOV r0, #0					; char won = 0;

s0x0007 LDRH r2,[r1,#0x00]
	AND r2,r2,#0x0007
	CMP r2,#0x0007
	BNE s0x0070
	B pws_rc1

s0x0070 LDRH r2,[r1,#0x00]
	AND r2,r2,#0x0070
	CMP r2,#0x0070
	BNE s0x0700
	B pws_rc1

s0x0700 LDRH r2,[r1,#0x00]
	AND r2,r2,#0x0700
	CMP r2,#0x0700
	BNE s0x0111
	B pws_rc1

s0x0111 LDRH r2,[r1,#0x00]
	MOVW r3,#0x0111
	AND r2,r2,r3
	CMP r2,r3
	BNE s0x0222
	B pws_rc1

s0x0222 LDRH r2,[r1,#0x00]
	MOVW r3,#0x0222
	AND r2,r2,r3
	CMP r2,r3
	BNE s0x0444
	B pws_rc1

s0x0444 LDRH r2,[r1,#0x00]
	MOVW r3,#0x0444
	AND r2,r2,r3
	CMP r2,r3
	BNE s0x0124
	B pws_rc1

s0x0124 LDRH r2,[r1,#0x00]
	MOVW r3,#0x0124
	AND r2,r2,r3
	CMP r2,r3
	BNE s0x0421
	B pws_rc1

s0x0421 LDRH r2,[r1,#0x00]
	MOVW r3,#0x0421
	AND r2,r2,r3
	CMP r2,r3
	BNE pws_return
	B pws_rc1

pws_return BX lr
pws_rc1 MOV r0, #1
	B pws_return

	ENDFUNC
  
	END
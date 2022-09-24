
  AREA    |.text|, CODE, READONLY
  PRESERVE8;
  THUMB;


  EXPORT player_check_move_s

player_check_move_s FUNCTION	; char player_check_move_s(player_t *player, int row, int col);
	; r0 *player
	; r1 row
	; r2 col
	MOV	R0, #0					; 
	BX	LR						; return
  ENDFUNC
  

  EXPORT player_make_move_s

player_make_move_s FUNCTION	; char player_make_move_s(player_t *player, int row, int col);
	; r0 *player
	; r1 row
	; r2 col
	MOV	R0, #0					; 
	BX	LR						; return
  ENDFUNC
  
  EXPORT player_won_s

player_won_s FUNCTION	; char player_won_s(player_t * player);
	; r0 *player
	MOV	R0, #0					; 
	BX	LR						; return
  ENDFUNC
  
  END
# CEG3136 Lab 4 Report

Group 9:
* Monique Diemert
* Hongyi Lin

- [CEG3136 Lab 4 Report](#ceg3136-lab-4-report)
  - [Task 1](#task-1)
    - [svc.h](#svch)
    - [svc.s](#svcs)
    - [svc.c](#svcc)
    - [Simulation logs](#simulation-logs)
  - [Task 2](#task-2)

## Task 1
### svc.h
```c
#include "stm32f4xx.h"
#include "stdio.h"
#include <string.h>

#include "stock_exchange.h"

void __svc(0) svc_zero(investor_t* investor, stock_holding_t* holding);
void __svc(1) svc_one(investor_t* investor, stock_holding_t* holding);

void __SVC_0(investor_t* investor, stock_holding_t* holding);
void __SVC_1(investor_t* investor, stock_holding_t* holding);
extern char SVC_Handler_s(void);
void SVC_Handler_c (investor_t* investor, stock_holding_t* holding, unsigned int svc_number);
```

### svc.s
```s
  AREA    |.text|, CODE, READONLY
  PRESERVE8;
  THUMB;


  EXPORT SVC_Handler

SVC_Handler FUNCTION	; char SVC_Handler();
    IMPORT SVC_Handler_c
    TST LR,#4             ; Called from Handler Mode? 
    MRSNE R12,PSP         ; Yes, use PSP 
    MOVEQ R12,SP          ; No, use MSP 
    LDR R12,[R12,#24]     ; Read Saved PC from Stack 
    LDRH R12,[R12,#-2]    ; Load Halfword 
    BICS R12,R12,#0xFF00  ; Extract SVC Number
    MOV R2, R12
    B SVC_Handler_c
  ENDFUNC
  
  END
```

### svc.c
```c

#include "svc.h"

void SVC_Handler_c (investor_t* investor, stock_holding_t* holding, unsigned int svc_number) {                    // SVC Interrupt Handler
  printf("svc_number = %d\n", svc_number);                                     // Increment Counter
  switch (svc_number) {
    case 0: __SVC_0(investor, holding); break;
    case 1: __SVC_1(investor, holding); break;
  }
}



void __SVC_0(investor_t* investor, stock_holding_t* holding){
  investor_buy(investor, holding);
}
void __SVC_1(investor_t* investor, stock_holding_t* holding){
  investor_sell(investor, holding);
}

```

### Simulation logs

The logs are in the file `task1-log.txt`.

## Task 2

The logs are in the file `task2-log.txt`.
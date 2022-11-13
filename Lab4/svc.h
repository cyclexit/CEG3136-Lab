#include "stm32f4xx.h"
#include "stdio.h"
#include <string.h>

void __svc(0) svc_zero(const char *string);
void __svc(1) svc_one(const char *string);

void __SVC_0(const char *string);
void __SVC_1(const char *string);
extern  char SVC_Handler_s(void);
void SVC_Handler_c (const char *string, unsigned int svc_number);

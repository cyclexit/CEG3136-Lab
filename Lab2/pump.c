#include "stdio.h"
#include "stdlib.h"
#include "stm32f4xx.h"
#include "pump.h"

void pump_init(pump_t *pump){
  pump->state = OFF;
  pump->flow = 0;
}

pump_state_e pump_update_state(pump_t *pump, float tank_height){
  // this is just a stub!
  // implement the state machine here
  return OFF;
}


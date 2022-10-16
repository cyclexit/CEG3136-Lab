#include "stdio.h"
#include "stdlib.h"
#include "stm32f4xx.h"
#include "pump.h"

void pump_init(pump_t *pump) {
  pump->state = OFF;
  pump->flow = 0;
}

pump_state_e pump_update_state(pump_t *pump, float tank_height) {
  // this is just a stub!
  // implement the state machine here
  switch (pump->state) {
    case OFF:
      if (tank_height < ALMOST_EMPTY) {
        pump->flow = 1.0;
        pump->state = ON_HIGH;
      }
      break;
    case ON_HIGH:
      if (tank_height > ALMOST_FULL) {
        pump->flow = 0.5;
        pump->state = ON_LOW;
      }
      break;
    case ON_LOW:
      if (tank_height > TANK_FULL) {
        pump->flow = 0.0;
        pump->state = OFF;
      }
      break;
    default:
      printf("Error: Unknown pump state!\n");
      break;
  }

  return pump->state;
}

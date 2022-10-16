#include "stdio.h"
#include "stdlib.h"
#include "stm32f4xx.h"
#include "pump.h"

void pump_init(pump_t *pump) {
  pump->state = OFF;
  pump->before_drain = OFF;
  pump->flow = 0;
}

pump_state_e pump_update_state(pump_t *pump, float tank_height, int drain_tank) {
  if (drain_tank == 1) {
    pump->flow = 0.0;
    pump->state = DRAIN;
    return pump->state;
  }

  switch (pump->state) {
    case OFF:
      if (tank_height < ALMOST_EMPTY) {
        pump->flow = 1.0;
        pump->state = ON_HIGH;
        pump->before_drain = ON_HIGH;
      }
      break;
    case ON_HIGH:
      if (tank_height > ALMOST_FULL) {
        pump->flow = 0.5;
        pump->state = ON_LOW;
        pump->before_drain = ON_LOW;
      }
      break;
    case ON_LOW:
      if (tank_height > TANK_FULL) {
        pump->flow = 0.0;
        pump->state = OFF;
        pump->before_drain = OFF;
      }
      break;
    case DRAIN:
      if (drain_tank == 0) {
        pump->state = pump->before_drain;
        if (pump->state == ON_HIGH) {
          pump->flow = 1.0;
        } else if (pump->state == ON_LOW) {
          pump->flow = 0.5;
        } else if (pump->state == OFF) {
          pump->flow = 0.0;
        }
      }
    default:
      printf("Error: Unknown pump state!\n");
      break;
  }

  return pump->state;
}

#include "stdio.h"
#include "stdlib.h"
#include "stm32f4xx.h"
#include "pump.h"

void pump_init(pump_t *pump) {
  pump->state = OFF;
  pump->flow = 0;
}

pump_state_e pump_update_state(pump_t *pump, float tank_height, int drain_tank) {

  switch (pump->state) {
    case OFF:
      if (drain_tank == 1) {
        pump->flow = 0.0;
        pump->state = DRAIN;
        return pump->state;
      } else if (tank_height < ALMOST_EMPTY) {
        pump->flow = 1.0;
        pump->state = ON_HIGH;
      }
      break;
    case ON_HIGH:
      if (drain_tank == 1) {
        pump->flow = 0.0;
        pump->state = DRAIN;
        return pump->state;
      } else if (tank_height > ALMOST_FULL) {
        pump->flow = 0.5;
        pump->state = ON_LOW;
      }
      break;
    case ON_LOW:
      if (drain_tank == 1) {
        pump->flow = 0.0;
        pump->state = DRAIN;
        return pump->state;
      } else if (tank_height > TANK_FULL) {
        pump->flow = 0.0;
        pump->state = OFF;
      }
      break;
    case DRAIN:
      if (drain_tank == 0) {
        if (tank_height < ALMOST_EMPTY) {
          pump->flow = 1.0;
          pump->state = ON_HIGH;
        } else if (tank_height > ALMOST_FULL) {
          pump->flow = 0.5;
          pump->state = ON_LOW;
        } else if (tank_height > TANK_FULL) {
          pump->flow = 0.0;
          pump->state = OFF;
        }
      }
      break;
    default:
      printf("Error: Unknown pump state %d!\n", (int) pump->state);
      break;
  }

  return pump->state;
}

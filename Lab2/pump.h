#include "stdio.h"
#include "stdlib.h"
#include "stm32f4xx.h"

#define ALMOST_EMPTY      5// 3 inch
#define ALMOST_FULL       25 // 2 inch
#define TANK_FULL         30 // 

typedef enum pump_States { OFF, ON_HIGH, ON_LOW, DRAIN } pump_state_e; // declare variable as pump state enum


typedef struct pump_s {
  float flow;
  pump_state_e state;
  // TODO: remove the before drain state
  //       no need to keep this
  //       the normal state is determined by the tank height
} pump_t;

pump_state_e pump_update_state(pump_t *pump, float tank_height, int drain_tank);
void pump_init(pump_t *pump);

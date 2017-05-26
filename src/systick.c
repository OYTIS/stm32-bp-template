#include "systick.h"

volatile uint32_t time_counter = 0;

void SysTick_Handler() {
	time_counter++;
}


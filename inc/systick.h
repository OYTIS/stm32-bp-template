#include <stdint.h>

extern volatile uint32_t time_counter;

#define delta_ms(t) (time_counter - (t))

static inline void delay_ms(uint32_t ms) {
	uint32_t now = time_counter;

	while(delta_ms(now) <= ms);
}


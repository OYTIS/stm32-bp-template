#include "stm32f10x.h" 
#include "core_cm3.h"  
#include "system_stm32f10x.h"

#include "systick.h"


void main() {
	int led = 0;

	SystemInit();
	SysTick_Config(72000); // every 1ms @ clockrate of 72MHz

	// GPIO initialization, ideally should be moved to a separate module
	RCC->APB2ENR |= (1 << 4); //GPIOC clock enable
	GPIOC->CRH = (0x2 << 20); //PC13 -> output (2Mhz), push-pull

	__enable_irq();

	for(;;) {
		delay_ms(500);
		if(led)
			GPIOC->ODR = (1 << 13);
		else
			GPIOC->ODR = ~(1 << 13);
		led = !led;
	}
}

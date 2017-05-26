TARGET = blink

CMSIS_DIR = CMSIS/CM3
SOURCES = src/main.c \
	  src/systick.c \
	  ${CMSIS_DIR}/system_stm32f10x.c \
	  ${CMSIS_DIR}/startup/gcc/startup_stm32f10x_md.c 

OBJECTS=$(SOURCES:%.c=%.o)

CFLAGS = -Iinc -I${CMSIS_DIR} -mcpu=cortex-m3 -mthumb -O0 -g
LDFLAGS = -T ./stm32f103.ld

CROSS = "arm-eabi-"

all: ${TARGET}.bin

${TARGET}.bin: ${OBJECTS}
	${CROSS}ld -o ${TARGET}.elf $^ ${LDFLAGS}
	${CROSS}objcopy -S -O binary ${TARGET}.elf ${TARGET}.bin

%.o: %.c
	${CROSS}gcc -c -o $@ $< ${CFLAGS}

clean:
	rm -f ${OBJECTS} ${TARGET}.bin ${TARGET}.elf

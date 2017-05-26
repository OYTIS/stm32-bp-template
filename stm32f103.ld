MEMORY
{
	RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
	FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 128K
}

SECTIONS
{
	.text :
	{
		. = ALIGN(4);
		KEEP(*(.isr_vector))
		*(.text)
		*(.text*)
		*(.rodata)
		*(.rodata*)
		. = ALIGN(4);
		_etext = .;
	} > FLASH

	_sidata = .;

	.data : AT ( _sidata )
	{
		. = ALIGN(4);
		_sdata = .;
		*(.data)
		*(.data*)
		. = ALIGN(4);
		_edata = .;
	} > RAM

	.bss :
	{
		_sbss = .;
		*(.bss)
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);
		_ebss = .;
	} > RAM

	_stack_size = 1024;
	_estack = ORIGIN(RAM)+LENGTH(RAM);
	_sstack = _estack - _stack_size;
	. = _sstack;
	._stack :
	{
		. = . + _stack_size;
	} > RAM
}

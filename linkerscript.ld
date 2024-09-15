ENTRY(Reset_Handler)

MEMORY
{
	FLASH(xr): ORIGIN = 0x08000000, LENGTH = 128k
	SRAM(rwx): ORIGIN = 0x20000000, LENGTH = 20k
}

SECTIONS
{
	.text :
	{
		*(.text)
		*(.isr_vector)
		*(.rodata)
		. = ALIGN(4);
	}>FLASH

	.data :
	{
		_sdata = .;
		*(.data)
		. = ALIGN(4);
		_edata = .;
	}>SRAM AT>FLASH
	.bss :
	{
		_sbss = .;
		*(.bss)
/*		*(.bss*)*/
		. = ALIGN(4);
		_ebss = .;
	}>SRAM
}
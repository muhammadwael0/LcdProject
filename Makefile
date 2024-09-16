cc = arm-none-eabi-gcc
CFLAGS = -c -mcpu=$(ACH) -std=gnu11 -mthumb
ACH = cortex-m3

all : main.o startup.o lcd.o Stm32_F103C6_GPIO.o app.elf

lcd.o:lcd.c
	$(cc) $(CFLAGS) $^ -o $@
main.o:main.c
	$(cc) $(CFLAGS) $^ -o $@
Stm32_F103C6_GPIO.o:Stm32_F103C6_GPIO.c
	$(cc) $(CFLAGS) $^ -o $@
startup.o:startup.c
	$(cc) $(CFLAGS) $^ -o $@
app.elf:main.o startup.o lcd.o Stm32_F103C6_GPIO.o
	$(cc) -T linkerscript.ld $^ -o $@
Program:
	openocd -f board/st_nucleo_f4.cfg
clear:
	rm -f *.o *.elf
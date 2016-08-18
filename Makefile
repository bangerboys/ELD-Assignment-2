CFLAGS = -mmcu=atmega328p -Os
CC = avr-gcc
name = blinkingled
objcp = avr-objcopy
ohex = -O ihex
dude = avrdude
carduino = -c arduino
patemega = -p atmega328p
root = -P /dev/ttyUSB0
lol = -b57600
rem = rm


all: $(name).hex

compile: $(name).hex $(name).c
	$(CC) $(CFLAGS) -o $(name).elf $(name).c
	
$(name).hex: $(name).elf
	$(objcp) $(ohex) $(name).elf $(name).hex

$(name).elf: $(name).c
	$(CC) $(CFLAGS) -o $(name).elf $(name).c

clean:
	$(rem) -rf *.o *.hex *.elf

program: all
	$(dude) $(carduino) $(patemega) $(root) $(lol) -U flash:w:$(name).hex

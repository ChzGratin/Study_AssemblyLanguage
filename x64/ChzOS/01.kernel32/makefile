all: virtualOS.bin

virtualOS.bin: virtualOS.asm
	nasm -o virtualOS.bin virtualOS.asm

clean:
	rm -f virtualOS.bin
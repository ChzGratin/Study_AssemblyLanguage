#Windows: use GnuWin32
all: bootloader kernel32 disk.img

bootloader:
	@echo ======== Build bootloader ========
	
	make -C 00.bootloader
	
	@echo ======== Build Complete ==========
	
	
kernel32:
	@echo ======== Build kernel32 ========
	
	make -C 01.kernel32
	
	@echo ======== Build Complete ==========
	
disk.img: 00.bootloader/bootloader.bin
	@echo ======== Build disk.img ==========
	
	cat 00.bootloader/bootloader.bin 01.kernel32/virtualOS.bin > disk.img
	
	@echo ======== Build Complete ==========
	
	
clean:
	make -C 00.bootloader clean
	make -C 01.kernel32 clean
	rm -f disk.img
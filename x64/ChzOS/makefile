#Windows: use GnuWin32
all: bootloader disk.img

bootloader:
	@echo ======== Build Bootloader ========
	
	make -C 00.bootloader
	
	@echo ======== Build Complete ==========
	
	
disk.img: 00.bootloader/bootloader.bin
	@echo ======== Build disk.img ==========
	
	cp 00.bootloader/bootloader.bin disk.img
	
	@echo ======== Build Complete ==========
	
	
clean:
	make -C 00.bootloader clean
	rm -f disk.img
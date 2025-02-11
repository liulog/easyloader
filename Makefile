IMAGE=./Image
DTB=./virt.dtb
INITRD=./rootfs_nopasswd.cpio
ARCH=riscv64
CROSS_COMPILE?=riscv64-unknown-elf-
OPTIONS=-mcmodel=medany
TARGET=linux

DTB_LOAD_ADDR=0xBFE00000
INITRD_LOAD_ADDR=0x90000000
KERNEL_LOAD_ADDR=0x80400000

all: $(TARGET).bin

clean:
	-rm *.elf *.bin

.PHONY: all clean
	
$(TARGET).bin: $(TARGET).elf
	$(CROSS_COMPILE)objcopy -S -O binary $(TARGET).elf $(TARGET).bin

$(TARGET).elf: $(ARCH).S $(IMAGE) $(DTB) loader_$(ARCH).ld
	$(CROSS_COMPILE)gcc -Wl,-build-id=none -nostdlib -T loader_$(ARCH).ld\
		-o $(TARGET).elf $(OPTIONS) $(ARCH).S -I. \
		-DIMAGE=$(IMAGE) -DDTB=$(DTB) -DINITRD=$(INITRD)  \
		-DDTB_LOAD_ADDR=$(DTB_LOAD_ADDR) \
		-DINITRD_LOAD_ADDR=$(INITRD_LOAD_ADDR) \
		-DKERNEL_LOAD_ADDR=$(KERNEL_LOAD_ADDR)

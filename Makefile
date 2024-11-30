
IMAGE=/home/jingyu/hypervisor/xiangshan/riscv-linux-devel/arch/riscv/boot/Image
DTB=/home/jingyu/hypervisor/hvisor-1core/images/riscv64/devicetree/kmh_v2_1core.dtb
ARCH=riscv64
CROSS_COMPILE?=riscv64-unknown-elf-
OPTIONS=-mcmodel=medany
TARGET=linux

all: $(TARGET).bin

clean:
	-rm *.elf *.bin

.PHONY: all clean
	
$(TARGET).bin: $(TARGET).elf
	$(CROSS_COMPILE)objcopy -S -O binary $(TARGET).elf $(TARGET).bin

$(TARGET).elf: $(ARCH).S $(IMAGE) $(DTB) loader_$(ARCH).ld
	$(CROSS_COMPILE)gcc -Wl,-build-id=none -nostdlib -T loader_$(ARCH).ld\
		-o $(TARGET).elf $(OPTIONS) $(ARCH).S -I. -D IMAGE=$(IMAGE) -D DTB=$(DTB)
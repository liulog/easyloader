make all

export CROSS_COMPILE=riscv64-unknown-linux-gnu-

cd ~/hypervisor/opensbi-1.5.1
make clean
make -j8 ARCH=riscv PLATFORM=generic FW_PAYLOAD_PATH=/home/jingyu/hypervisor/linuxloader/linux.bin FW_FDT_PATH=/home/jingyu/hypervisor/hvisor-1core/images/riscv64/devicetree/kmh.dtb

/home/jingyu/hypervisor/xiangshan/qemu-devel/build/qemu-system-riscv64 -nographic \
    -M bosc-kmh -smp 1 -m 4G \
    -bios ~/hypervisor/opensbi-1.5.1/build/platform/generic/firmware/fw_payload.bin     -s -S                    # -d mmu,int -D qemu.log
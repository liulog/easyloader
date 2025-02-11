dtc virt.dts > virt.dtb
make clean
make all

export CROSS_COMPILE=riscv64-unknown-linux-gnu-

qemu-system-riscv64 -nographic \
    -M virt -smp 1 -m 4G \
    -kernel ./linux.bin
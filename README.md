# linuxloader
个人学习使用，针对 RISCV64，实现跳转到 linux，构造一个简易的 linux loader

如有需要，请参考 https://github.com/bao-project/bao-demos

对于 linux 的 initramfs.c broken padding / uncompression error 没有搞清楚,没查到什么有用的资料,需要根据
qemu 的 Image(内置gzip压缩的initramfs) 的 _start_linux 设为 0x82400000, 是试出来的 :(
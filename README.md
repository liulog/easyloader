# easyloader

针对 RISCV64，实现跳转到 image (eg:linux)，构造一个简易的 loader

内嵌 image、initrd、dtb, 初始验证时使用, 使用时小心, 简单但通用

并且启动时, 需要等待一段时间才会进入 Linux, 在本人电脑上大约 20s 才能进入 Linux
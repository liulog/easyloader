/* 将编译指定的宏参数转换为字符串常量, 搭配后续的 incbin 使用 */

#define STRINGIFY2(X) #X
#define STRINGIFY(X) STRINGIFY2(X)

.section .nloader, "a"
.global _start
_start:
    /* boot protocol */
    /* We are expecting hartid in a0 */
    la a1, __dtb_start
    la a2, __initrd_start
    la a3, __image_start

    /* Copy dtb to target address */
    li t0, DTB_LOAD_ADDR
    la t1, __dtb_end
    bge a1, t1, 1f
0:  ld t2, 0(a1)
    sd t2, 0(t0)
    addi a1, a1, 8
    addi t0, t0, 8
    bltu a1, t1, 0b
1:

    /* Copy initrd to target address */
    li t0, INITRD_LOAD_ADDR
    la t1, __initrd_end
    bge a2, t1, 1f
0:  ld t2, 0(a2)
    sd t2, 0(t0)
    addi a2, a2, 8
    addi t0, t0, 8
    bltu a2, t1, 0b
1:

    /* Copy Image to target address */
    li t0, KERNEL_LOAD_ADDR
    la t1, __image_end
    bge a3, t1, 1f
0:  ld t2, 0(a3)
    sd t2, 0(t0)
    addi a3, a3, 8
    addi t0, t0, 8
    bltu a3, t1, 0b
1:

    /* 要求 a1 必须指向 dtb 的地址 */
    li a1, DTB_LOAD_ADDR
    li a0,0
    li t0, KERNEL_LOAD_ADDR
    jalr t0
    j .

.section .image, "a"
    .global __image_start
__image_start:
    .incbin STRINGIFY(IMAGE)
__image_end:

.section .dtb, "a"
    .global __dtb_start
__dtb_start:
    .incbin STRINGIFY(DTB)
__dtb_end:

.section .initrd, "a"
    .global __initrd_start
__initrd_start:
    .incbin STRINGIFY(INITRD)
__initrd_end:

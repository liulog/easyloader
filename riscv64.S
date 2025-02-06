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
    la t0, DTB_LOAD_ADDR
    la t1, __dtb_end
1:  lb t2, 0(a1)
    sb t2, 0(t0)
    addi a1, a1, 1
    addi t0, t0, 1
    bne a1, t1, 1b

    /* Copy initrd to target address */
    la t0, INITRD_LOAD_ADDR
    la t1, __initrd_end
1:  lb t2, 0(a2)
    sb t2, 0(t0)
    addi a2, a2, 1
    addi t0, t0, 1
    bne a2, t1, 1b

    /* Copy Image to target address */
    la t0, KERNEL_LOAD_ADDR
    la t1, __linux_end
1:  lb t2, 0(a3)
    sb t2, 0(t0)
    addi a3, a3, 1
    addi t0, t0, 1
    bne a3, t1, 1b

    /* 要求 a0 必须指向 dtb 的地址 */
    la a0, DTB_LOAD_ADDR
    li a1,0
    la t0, KERNEL_LOAD_ADDR
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

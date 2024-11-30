#define STRINGIFY2(X) #X
#define STRINGIFY(X) STRINGIFY2(X)

.section .nloader, "a"
.global _start
_start:

    /* boot protocol */
    /* We are expecting hartid in a0 */
    la a1, __dtb_start
    
    /* jump to linux */
    la t0, __linux_start
    jalr t0
    j  .

.section .linux, "a"                    // 把 Image 加载到这里
    .incbin STRINGIFY(IMAGE)

.section .dtb, "a"                      // 把 dtb 加载到这里
    .incbin STRINGIFY(DTB)
 
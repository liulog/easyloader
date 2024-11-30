ENTRY(_start)

PROVIDE(_loader_start = 0x80200000);
PROVIDE(_linux_start = 0x82400000);

SECTIONS
{   
    . = _loader_start;

    /* 仅包含最小的 loader, 和 OpenSBI 占据的空间一样大, 2MB */
    .nloader : {
        KEEP(*(.nloader))
    }

    /* 发现只有 0x80400000 这个 2MB 对齐地址不行, 为什么？  */ 
    /* 个人实践, 这个 linux 需要  */
    . = _linux_start;
    /* 按照 2MB 进行对齐 */
    .linux : ALIGN(0x200000) { 
        __linux_start = .;
        KEEP(*(.linux)) 
        __linux_end = .;
    }  

    /* 按照 2MB 进行对齐 */
    .dtb : ALIGN(0x200000) { 
        __dtb_start = .;
        KEEP(*(.dtb)) 
        __dtb_end = .;
    }  
}
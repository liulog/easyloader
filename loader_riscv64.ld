ENTRY(_start)

PROVIDE(_loader_start = 0x80200000);

SECTIONS
{   
    . = _loader_start;

    /* easyloader's code */
    .nloader : {
        KEEP(*(.nloader))
    }

    /* image、initrd、dtb */
    .image : ALIGN(0x200000) { 
        __image_start = .;
        KEEP(*(.image)) 
        __image_end = .;
    }

    .initrd : ALIGN(0x1000) { 
        __initrd_start = .;
        KEEP(*(.initrd)) 
        __initrd_end = .;
    }
    .dtb : ALIGN(0x1000) { 
        __dtb_start = .;
        KEEP(*(.dtb)) 
        __dtb_end = .;
    }  
}
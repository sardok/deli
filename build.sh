cc -c grub.s -o grub.o
cc -c start.s -o start.o
cc -c kernel_ops.c -o kernel_ops.o
cc -c stdio.c -o stdio.o
cc -c stdlib.c -o stdlib.o
ld -T link.ld grub.o start.o kernel_ops.o stdio.o stdlib.o -o kernel.elf

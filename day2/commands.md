as --32 -o main.o main.s
as --32 -o fun.o fun.s

ld main.o fun.o -m elf_i386 -lc -dynamic-linker /lib/ld-linux.so.2 -e main -o output_run

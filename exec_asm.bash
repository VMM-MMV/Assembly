#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [-d] <filename_without_extension>"
    exit 1
fi

python3 remover.py
nasm -f elf64 -g "int_to_string.asm" -o "int_to_string.o"
# Check if debug flag is provided
if [ "$1" = "-d" ]; then
    # Debug flag is provided, shift the arguments
    shift
    # Assemble the assembly code
    nasm -f elf64 -g "$1.asm" -o "$1.o"

    # Link the object file
    gcc -g -no-pie -nostartfiles "$1.o" -o "$1"

    # Debug the executable with GDB
    gdb "./$1"
elif [ "$1" = "-m" ]; then
    shift
    # Assemble the assembly code
    nasm -f elf64 -g "$1.asm" -o "$1.o"
    nasm -f elf64 -g "concat.asm" -o "concat.o"
    nasm -f elf64 -g "len_of_input.asm" -o "len_of_input.o"
    nasm -f elf64 -g "remove_space.asm" -o "remove_space.o"
    # Link the object files
    gcc -g -no-pie -nostartfiles "$1.o" concat.o len_of_input.o remove_space.o -o "$1"
    ./"$1"
else
    # Assemble the assembly code
    nasm -f elf64 -g "$1.asm" -o "$1.o"

    # Link the object file
    gcc -g -no-pie -nostartfiles "$1.o" int_to_string.o -o "$1"

    # Run the executable
    ./"$1"
fi


# nasm -felf64 test.asm && gcc test.o -pie -no-pie && ./a.out
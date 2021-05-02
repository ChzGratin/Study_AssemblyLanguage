#1. entry point:
_asm_main -> _main

#2. assemble .asm file:
nasm -f win32 Source.asm
nasm -f win32 Library.asm

#3. link .obj file:
gcc Source.obj Library.obj -o Application
(Use MinGW.)

#4. result:
Application.exe

+alpha) The -l Option: Generating a Listing File
nasm -f elf myfile.asm -l myfile.lst
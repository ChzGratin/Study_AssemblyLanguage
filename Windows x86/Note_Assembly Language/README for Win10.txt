i) entry point:
_asm_main -> _main

ii) assemble .asm file:
nasm -f win32 Source.asm
nasm -f win32 Library.asm

iii) link .obj file:
gcc Source.obj Library.obj -o Application
(Use MinGW.)

iv) result:
Application.exe

+alpha) The -l Option: Generating a Listing File
nasm -f elf myfile.asm -l myfile.lst
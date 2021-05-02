Reference:
https://karfn84.tistory.com/entry/%EC%96%B4%EC%85%88%EB%B8%94%EB%A6%AC-%EB%A0%88%EC%A7%80%EC%8A%A4%ED%84%B0%EC%9D%98-%EA%B8%B0%EB%8A%A5

#1. 80x86 CPU:
8088,8086 -> 80286 -> 80386 -> 80486/Pentium/Pentium Pro -> Pentium MMX -> Pentium II

i) 8086 CPU: 16-bit registers
AX, BX, CX, DX - General Purpose Register
		 AX(16 bits) = AH(High 8 bits) + AL(Low 8 bits)
		 primary 'A'ccumulator, 'B'ase, 'C'ount, 'D'ata

SI, DI         - Index Register (Pointer/General Purpose)
		 Not-separable
		 'S'ource, 'D'estination

IP, BP, SP     - Pointer Register
		 'I'nstruction, 'B'ase, 'S'tack

CS, DS, SS, ES - Segment Register
		 'C'ode, 'D'ata, 'S'tack, 'E'xtra

FLAGS	       - Flag Register
		 FLAGS = OF, DF, IF, TF, SF, ZF, AF, PF, CF

ii) 80386 CPU: 32-bit registers
Extended       - EAX, EBX, ECX, EDX
		 ESI, EDI
		 EIP, EBP, ESP
		 EFLAGS
		 ex) EAX = AX(high 16bits) + AX(low 16bits)
		 Tip) Segment Registers were NOT extended!

FS, GS	       - New Segment Register
		 Used as ES (Extra)

1 word = 2 bytes = 16 bytes (The size of word was NOT redefined!)
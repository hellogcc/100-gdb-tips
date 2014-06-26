# 将源程序和汇编指令映射起来

## 例子

	#include <stdio.h>

	typedef struct
	{
	        int a;
	        int b;
	        int c;
	        int d;
	}ex_st;
	
	int main(void) {
	        ex_st st = {1, 2, 3, 4};
	        printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	        return 0;
	}

## 技巧一

可以用“disas /m fun”（disas是disassemble命令缩写）命令将函数代码和汇编指令映射起来，以上面代码为例：

	(gdb) disas /m main
	Dump of assembler code for function main:
	11      int main(void) {
	   0x00000000004004c4 <+0>:     push   %rbp
	   0x00000000004004c5 <+1>:     mov    %rsp,%rbp
	   0x00000000004004c8 <+4>:     push   %rbx
	   0x00000000004004c9 <+5>:     sub    $0x18,%rsp
	
	12              ex_st st = {1, 2, 3, 4};
	   0x00000000004004cd <+9>:     movl   $0x1,-0x20(%rbp)
	   0x00000000004004d4 <+16>:    movl   $0x2,-0x1c(%rbp)
	   0x00000000004004db <+23>:    movl   $0x3,-0x18(%rbp)
	   0x00000000004004e2 <+30>:    movl   $0x4,-0x14(%rbp)
	
	13              printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	   0x00000000004004e9 <+37>:    mov    -0x14(%rbp),%esi
	   0x00000000004004ec <+40>:    mov    -0x18(%rbp),%ecx
	   0x00000000004004ef <+43>:    mov    -0x1c(%rbp),%edx
	   0x00000000004004f2 <+46>:    mov    -0x20(%rbp),%ebx
	   0x00000000004004f5 <+49>:    mov    $0x400618,%eax
	   0x00000000004004fa <+54>:    mov    %esi,%r8d
	   0x00000000004004fd <+57>:    mov    %ebx,%esi
	   0x00000000004004ff <+59>:    mov    %rax,%rdi
	   0x0000000000400502 <+62>:    mov    $0x0,%eax
	   0x0000000000400507 <+67>:    callq  0x4003b8 <printf@plt>
	
	14              return 0;
	   0x000000000040050c <+72>:    mov    $0x0,%eax
	
	15      }
	   0x0000000000400511 <+77>:    add    $0x18,%rsp
	   0x0000000000400515 <+81>:    pop    %rbx
	   0x0000000000400516 <+82>:    leaveq
	   0x0000000000400517 <+83>:    retq
	
	End of assembler dump.

可以看到每一条C语句下面是对应的汇编代码。

## 技巧二

如果只想查看某一行所对应的地址范围，可以：

	(gdb) i line 13
	Line 13 of "foo.c" starts at address 0x4004e9 <main+37> and ends at 0x40050c <main+72>.	


如果只想查看这一条语句对应的汇编代码，可以使用“`disassemble [Start],[End]`”命令：  

	(gdb) disassemble 0x4004e9, 0x40050c
	Dump of assembler code from 0x4004e9 to 0x40050c:
	   0x00000000004004e9 <main+37>:        mov    -0x14(%rbp),%esi
	   0x00000000004004ec <main+40>:        mov    -0x18(%rbp),%ecx
	   0x00000000004004ef <main+43>:        mov    -0x1c(%rbp),%edx
	   0x00000000004004f2 <main+46>:        mov    -0x20(%rbp),%ebx
	   0x00000000004004f5 <main+49>:        mov    $0x400618,%eax
	   0x00000000004004fa <main+54>:        mov    %esi,%r8d
	   0x00000000004004fd <main+57>:        mov    %ebx,%esi
	   0x00000000004004ff <main+59>:        mov    %rax,%rdi
	   0x0000000000400502 <main+62>:        mov    $0x0,%eax
	   0x0000000000400507 <main+67>:        callq  0x4003b8 <printf@plt>
	End of assembler dump.

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Machine-Code.html)

## 贡献者

nanxiao

xmj


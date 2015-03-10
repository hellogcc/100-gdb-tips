# 显示程序原始机器码 

## 例子

	#include <stdio.h>

	int main(void)
	{
	        printf("Hello, world\n");
	        return 0;
	}



## 技巧

使用“disassemble /r”命令可以用16进制形式显示程序的原始机器码。以上面程序为例：

	(gdb) disassemble /r main
	Dump of assembler code for function main:
	   0x0000000000400530 <+0>:     55      push   %rbp
	   0x0000000000400531 <+1>:     48 89 e5        mov    %rsp,%rbp
	   0x0000000000400534 <+4>:     bf e0 05 40 00  mov    $0x4005e0,%edi
	   0x0000000000400539 <+9>:     e8 d2 fe ff ff  callq  0x400410 <puts@plt>
	   0x000000000040053e <+14>:    b8 00 00 00 00  mov    $0x0,%eax
	   0x0000000000400543 <+19>:    5d      pop    %rbp
	   0x0000000000400544 <+20>:    c3      retq
	End of assembler dump.
	(gdb) disassemble /r 0x0000000000400534,+4
	Dump of assembler code from 0x400534 to 0x400538:
	   0x0000000000400534 <main+4>: bf e0 05 40 00  mov    $0x4005e0,%edi
	End of assembler dump.
	

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Machine-Code.html)

## 贡献者

nanxiao




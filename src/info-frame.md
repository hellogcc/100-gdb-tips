# 打印函数堆栈帧信息
## 例子
	#include <stdio.h>
	int func(int a, int b)
	{
		int c = a * b;
		printf("c is %d\n", c);
	}
	
	int main(void) 
	{
		func(1, 2);
		return 0;
	}



## 技巧
使用gdb调试程序时，可以使用“`i frame`”命令（`i`是`info`命令缩写）显示函数堆栈帧信息。以上面程序为例：  
 
	Breakpoint 1, func (a=1, b=2) at a.c:5
	5               printf("c is %d\n", c);
	(gdb) i frame
	Stack level 0, frame at 0x7fffffffe590:
	 rip = 0x40054e in func (a.c:5); saved rip = 0x400577
	 called by frame at 0x7fffffffe5a0
	 source language c.
	 Arglist at 0x7fffffffe580, args: a=1, b=2
	 Locals at 0x7fffffffe580, Previous frame's sp is 0x7fffffffe590
	 Saved registers:
	  rbp at 0x7fffffffe580, rip at 0x7fffffffe588
	(gdb) i registers
	rax            0x2      2
	rbx            0x0      0
	rcx            0x0      0
	rdx            0x7fffffffe688   140737488348808
	rsi            0x2      2
	rdi            0x1      1
	rbp            0x7fffffffe580   0x7fffffffe580
	rsp            0x7fffffffe560   0x7fffffffe560
	r8             0x7ffff7dd4e80   140737351863936
	r9             0x7ffff7dea560   140737351951712
	r10            0x7fffffffe420   140737488348192
	r11            0x7ffff7a35dd0   140737348066768
	r12            0x400440 4195392
	r13            0x7fffffffe670   140737488348784
	r14            0x0      0
	r15            0x0      0
	rip            0x40054e 0x40054e <func+24>
	eflags         0x202    [ IF ]
	cs             0x33     51
	ss             0x2b     43
	ds             0x0      0
	es             0x0      0
	fs             0x0      0
	gs             0x0      0
	(gdb) disassemble func
	Dump of assembler code for function func:
	   0x0000000000400536 <+0>:     push   %rbp
	   0x0000000000400537 <+1>:     mov    %rsp,%rbp
	   0x000000000040053a <+4>:     sub    $0x20,%rsp
	   0x000000000040053e <+8>:     mov    %edi,-0x14(%rbp)
	   0x0000000000400541 <+11>:    mov    %esi,-0x18(%rbp)
	   0x0000000000400544 <+14>:    mov    -0x14(%rbp),%eax
	   0x0000000000400547 <+17>:    imul   -0x18(%rbp),%eax
	   0x000000000040054b <+21>:    mov    %eax,-0x4(%rbp)
	=> 0x000000000040054e <+24>:    mov    -0x4(%rbp),%eax
	   0x0000000000400551 <+27>:    mov    %eax,%esi
	   0x0000000000400553 <+29>:    mov    $0x400604,%edi
	   0x0000000000400558 <+34>:    mov    $0x0,%eax
	   0x000000000040055d <+39>:    callq  0x400410 <printf@plt>
	   0x0000000000400562 <+44>:    leaveq
	   0x0000000000400563 <+45>:    retq
	End of assembler dump.

可以看到执行“`i frame`”命令后，输出了当前函数堆栈帧的地址，指令寄存器的值，局部变量地址及值等信息，可以对照当前寄存器的值和函数的汇编指令看一下。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Frame-Info.html).

## 贡献者

nanxiao

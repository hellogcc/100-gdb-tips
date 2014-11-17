# 打印尾调用堆栈帧信息
## 例子
	#include<stdio.h>
	void a(void)
	{
	        printf("Tail call frame\n");
	}
	
	void b(void)
	{
	        a();
	}
	
	void c(void)
	{
	        b();
	}
	
	int main(void)
	{
	        c();
	        return 0;
	}

## 技巧
当一个函数最后一条指令是调用另外一个函数时，开启优化选项的编译器常常以最后被调用的函数返回值作为调用者的返回值，这称之为“尾调用（Tail call）”。以上面程序为例，编译程序（使用‘-O’）：  

    gcc -g -O -o test test.c
查看`main`函数汇编代码：

	(gdb) disassemble main
    Dump of assembler code for function main:
    0x0000000000400565 <+0>:     sub    $0x8,%rsp
    0x0000000000400569 <+4>:     callq  0x400536 <a>
    0x000000000040056e <+9>:     mov    $0x0,%eax
    0x0000000000400573 <+14>:    add    $0x8,%rsp
    0x0000000000400577 <+18>:    retq
可以看到`main`函数直接调用了函数`a`，根本看不到函数`b`和函数`c`的影子。
  
在函数`a`入口处打上断点，程序停止后，打印堆栈帧信息：  

	(gdb) i frame
	Stack level 0, frame at 0x7fffffffe590:
	 rip = 0x400536 in a (test.c:4); saved rip = 0x40056e
	 called by frame at 0x7fffffffe5a0
	 source language c.
	 Arglist at 0x7fffffffe580, args:
	 Locals at 0x7fffffffe580, Previous frame's sp is 0x7fffffffe590
	 Saved registers:
	  rip at 0x7fffffffe588
看不到尾调用的相关信息。  

可以设置“`debug entry-values`”选项为非0的值，这样除了输出正常的函数堆栈帧信息以外，还可以输出尾调用的相关信息：  

	(gdb) set debug entry-values 1
	(gdb) b test.c:4
	Breakpoint 1 at 0x400536: file test.c, line 4.
	(gdb) r
	Starting program: /home/nanxiao/test
	
	Breakpoint 1, a () at test.c:4
	4       {
	(gdb) i frame
	tailcall: initial:
	Stack level 0, frame at 0x7fffffffe590:
	 rip = 0x400536 in a (test.c:4); saved rip = 0x40056e
	 called by frame at 0x7fffffffe5a0
	 source language c.
	 Arglist at 0x7fffffffe580, args:
	 Locals at 0x7fffffffe580, Previous frame's sp is 0x7fffffffe590
	 Saved registers:
	  rip at 0x7fffffffe588

可以看到输出了“`tailcall: initial:`”信息。  

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Tail-Call-Frames.html).

## 贡献者

nanxiao

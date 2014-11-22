# 选择函数堆栈帧
## 例子
	#include <stdio.h>

	int func1(int a)
	{
	        return 2 * a;
	}
	
	int func2(int a)
	{
	        int c = 0;
	        c = 2 * func1(a);
	        return c;
	}
	
	int func3(int a)
	{
	        int c = 0;
	        c = 2 * func2(a);
	        return c;
	}
	
	int main(void)
	{
	        printf("%d\n", func3(10));
	        return 0;
	}

## 技巧
用gdb调试程序时，当程序暂停后，可以用“`frame n`”命令选择函数堆栈帧，其中`n`是层数。以上面程序为例：  

    (gdb) b test.c:5
	Breakpoint 1 at 0x40053d: file test.c, line 5.
	(gdb) r
	Starting program: /home/nanxiao/test
	
	Breakpoint 1, func1 (a=10) at test.c:5
	5               return 2 * a;
	(gdb) bt
	#0  func1 (a=10) at test.c:5
	#1  0x0000000000400560 in func2 (a=10) at test.c:11
	#2  0x0000000000400586 in func3 (a=10) at test.c:18
	#3  0x000000000040059e in main () at test.c:24
	(gdb) frame 2
	#2  0x0000000000400586 in func3 (a=10) at test.c:18
	18              c = 2 * func2(a);

可以看到程序断住后，最内层的函数帧为第`0`帧。执行`frame 2`命令后，当前的堆栈帧变成了`fun3`的函数帧。

也可以用“`frame addr`”命令选择函数堆栈帧，其中`addr`是堆栈地址。仍以上面程序为例：  

    (gdb) frame 2
	#2  0x0000000000400586 in func3 (a=10) at test.c:18
	18              c = 2 * func2(a);
	(gdb) i frame
	Stack level 2, frame at 0x7fffffffe590:
	 rip = 0x400586 in func3 (test.c:18); saved rip = 0x40059e
	 called by frame at 0x7fffffffe5a0, caller of frame at 0x7fffffffe568
	 source language c.
	 Arglist at 0x7fffffffe580, args: a=10
	 Locals at 0x7fffffffe580, Previous frame's sp is 0x7fffffffe590
	 Saved registers:
	  rbp at 0x7fffffffe580, rip at 0x7fffffffe588
	(gdb) frame 0x7fffffffe568
	#1  0x0000000000400560 in func2 (a=10) at test.c:11
	11              c = 2 * func1(a);
使用“`i frame`”命令可以知道`0x7fffffffe568`是`func2`的函数堆栈帧地址，使用“`frame 0x7fffffffe568`”可以切换到`func2`的函数堆栈帧。

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Selection.html#Selection).

## 贡献者

nanxiao

# 向上或向下切换函数堆栈帧
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
用gdb调试程序时，当程序暂停后，可以用“`up n`”或“`down n`”命令向上或向下选择函数堆栈帧，其中`n`是层数。以上面程序为例：  

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
	(gdb) up 1
	#3  0x000000000040059e in main () at test.c:24
	24              printf("%d\n", func3(10));
	(gdb) down 2
	#1  0x0000000000400560 in func2 (a=10) at test.c:11
	11              c = 2 * func1(a);


可以看到程序断住后，先执行“`frame 2`”命令，切换到`fun3`函数。接着执行“`up 1`”命令，此时会切换到`main`函数，也就是会往外层的堆栈帧移动一层。反之，当执行“`down 2`”命令后，又会向内层堆栈帧移动二层。如果不指定`n`，则`n`默认为`1`.

还有“`up-silently n`”和“`down-silently n`”这两个命令，与“`up n`”和“`down n`”命令区别在于，切换堆栈帧后，不会打印信息，仍以上面程序为例：  

    (gdb) up
	#2  0x0000000000400586 in func3 (a=10) at test.c:18
	18              c = 2 * func2(a);
	(gdb) bt
	#0  func1 (a=10) at test.c:5
	#1  0x0000000000400560 in func2 (a=10) at test.c:11
	#2  0x0000000000400586 in func3 (a=10) at test.c:18
	#3  0x000000000040059e in main () at test.c:24
	(gdb) up-silently
	(gdb) i frame
	Stack level 3, frame at 0x7fffffffe5a0:
	 rip = 0x40059e in main (test.c:24); saved rip = 0x7ffff7a35ec5
	 caller of frame at 0x7fffffffe590
	 source language c.
	 Arglist at 0x7fffffffe590, args:
	 Locals at 0x7fffffffe590, Previous frame's sp is 0x7fffffffe5a0
	 Saved registers:
	  rbp at 0x7fffffffe590, rip at 0x7fffffffe598

可以看到从`func3`切换到`main`函数堆栈帧时，并没有打印出相关信息。

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Selection.html#Selection).

## 贡献者

nanxiao

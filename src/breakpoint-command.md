# 使用断点命令改变程序的执行

## 例子

	#include <stdio.h>
	#include <stdlib.h>
	
	void drawing (int n)
	{
	  if (n != 0)
	    puts ("Try again?\nAll you need is a dollar, and a dream.");
	  else
	    puts ("You win $3000!");
	}
	
	int main (void)
	{
	  int n;
	
	  srand (time (0));
	  n = rand () % 10;
	  printf ("Your number is %d\n", n);
	  drawing (n);
	
	  return 0;
	}

## 技巧

这个例子程序可能不太好，只是可以用来演示下断点命令的用法：

	(gdb) b drawing
	Breakpoint 1 at 0x40064d: file win.c, line 6.
	(gdb) command 1
	Type commands for breakpoint(s) 1, one per line.
	End with a line saying just "end".
	>silent
	>set variable n = 0
	>continue
	>end
	(gdb) r
	Starting program: /home/xmj/tmp/a.out 
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
	Your number is 6
	You win $3000!
	[Inferior 1 (process 4134) exited normally]

可以看到，当程序运行到断点处，会自动把变量n的值修改为0，然后继续执行。

如果你在调试一个大程序，重新编译一次会花费很长时间，比如调试编译器的bug，那么你可以用这种方式在gdb中先实验性的修改下试试，而不需要修改源码，重新编译。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Break-Commands.html#Break-Commands)

## 贡献者

xmj


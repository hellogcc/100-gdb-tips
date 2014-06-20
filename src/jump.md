# 跳转到指定位置执行 

## 例子

	#include <stdio.h>
	
	void fun (int x)
	{
	  if (x < 0)
	    puts ("error");
	}
	
	int main (void)
	{
	  int i = 1;
	
	  fun (i--);
	  fun (i--);
	  fun (i--);
	
	  return 0;
	}

## 技巧

当调试程序时，你可能不小心走过了出错的地方：

	(gdb) n
	13	  fun (i--);
	(gdb) 
	14	  fun (i--);
	(gdb) 
	15	  fun (i--);
	(gdb) 
	error
	17	  return 0;

看起来是在15行，调用fun的时候出错了。常见的办法是在15行设置个断点，然后从头`run`一次。

如果你的环境支持反向执行，那么更好了。

如果不支持，你也可以直接`jump`到15行，再执行一次：

	(gdb) b 15
	Breakpoint 2 at 0x40056a: file jump.c, line 15.
	(gdb) j 15
	Continuing at 0x40056a.
	
	Breakpoint 2, main () at jump.c:15
	15	  fun (i--);
	(gdb) s
	fun (x=-2) at jump.c:5
	5	  if (x < 0)
	(gdb) n
	6	    puts ("error");

需要注意的是：

1. `jump`命令只改变pc的值，所以改变程序执行可能会出现不同的结果，比如变量i的值
2. 通过（临时）断点的配合，可以让你的程序跳到指定的位置，并停下来

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Jumping.html#Jumping)

## 贡献者

xmj


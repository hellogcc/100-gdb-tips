# 一个gdb会话中同时调试多个程序
## 例子
	a.c:
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


	b.c:
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
gdb支持在一个会话中同时调试多个程序。以上面程序为例，首先调试`a`程序：  

	root@bash:~$ gdb a
	GNU gdb (Ubuntu 7.7-0ubuntu3) 7.7
	Copyright (C) 2014 Free Software Foundation, Inc.
	License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
	This is free software: you are free to change and redistribute it.
	There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
	and "show warranty" for details.
	This GDB was configured as "x86_64-linux-gnu".
	Type "show configuration" for configuration details.
	For bug reporting instructions, please see:
	<http://www.gnu.org/software/gdb/bugs/>.
	Find the GDB manual and other documentation resources online at:
	<http://www.gnu.org/software/gdb/documentation/>.
	For help, type "help".
	Type "apropos word" to search for commands related to "word"...
	Reading symbols from a...done.
	(gdb) start
	Temporary breakpoint 1 at 0x400568: file a.c, line 10.
	Starting program: /home/nanxiao/a

接着使用“`add-inferior [ -copies n ] [ -exec executable ]`”命令加载可执行文件`b`。其中`n`默认为1：  

	(gdb) add-inferior -copies 2 -exec b
	Added inferior 2
	Reading symbols from b...done.
	Added inferior 3
	Reading symbols from b...done.
	(gdb) i inferiors
	  Num  Description       Executable
	  3    <null>            /home/nanxiao/b
	  2    <null>            /home/nanxiao/b
	* 1    process 1586      /home/nanxiao/a
	(gdb) inferior 2
	[Switching to inferior 2 [<null>] (/home/nanxiao/b)]
	(gdb) start
	Temporary breakpoint 2 at 0x400568: main. (3 locations)
	Starting program: /home/nanxiao/b
	
	Temporary breakpoint 2, main () at b.c:24
	24              printf("%d\n", func3(10));
	(gdb) i inferiors
	  Num  Description       Executable
	  3    <null>            /home/nanxiao/b
	* 2    process 1590      /home/nanxiao/b
	  1    process 1586      /home/nanxiao/a
可以看到可以调试`b`程序了。

另外也可用“`clone-inferior [ -copies n ] [ infno ]`”克隆现有的`inferior`，其中`n`默认为1，`infno`默认为当前的`inferior`：  

	(gdb) i inferiors
	  Num  Description       Executable
	  3    <null>            /home/nanxiao/b
	* 2    process 1590      /home/nanxiao/b
	  1    process 1586      /home/nanxiao/a
	(gdb) clone-inferior -copies 1
	Added inferior 4.
	(gdb) i inferiors
	  Num  Description       Executable
	  4    <null>            /home/nanxiao/b
	  3    <null>            /home/nanxiao/b
	* 2    process 1590      /home/nanxiao/b
	  1    process 1586      /home/nanxiao/a
可以看到又多了一个`b`程序。

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-and-Programs.html).

## 贡献者

nanxiao

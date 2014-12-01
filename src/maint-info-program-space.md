# 打印程序进程空间信息
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
使用gdb调试多个进程时，可以使用“`maint info program-spaces`”打印当前所有被调试的进程信息。以上面程序为例：  

	[root@localhost nan]# gdb a
	GNU gdb (GDB) 7.8.1
	......
	Reading symbols from a...done.
	(gdb) start
	Temporary breakpoint 1 at 0x4004f9: file a.c, line 10.
	Starting program: /home/nan/a 
	
	Temporary breakpoint 1, main () at a.c:10
	10              func(1, 2);
	(gdb) add-inferior -exec b
	Added inferior 2
	Reading symbols from b...done.
	(gdb) i inferiors b
	Args must be numbers or '$' variables.
	(gdb) i inferiors
	  Num  Description       Executable        
	  2    <null>            /home/nan/b       
	* 1    process 15753     /home/nan/a       
	(gdb) inferior 2
	[Switching to inferior 2 [<null>] (/home/nan/b)]
	(gdb) start
	Temporary breakpoint 2 at 0x4004f9: main. (2 locations)
	Starting program: /home/nan/b 
	
	Temporary breakpoint 2, main () at b.c:24
	24              printf("%d\n", func3(10));
	(gdb) i inferiors
	  Num  Description       Executable        
	* 2    process 15902     /home/nan/b       
	  1    process 15753     /home/nan/a       
	(gdb) clone-inferior -copies 2
	Added inferior 3.
	Added inferior 4.
	(gdb) i inferiors
	  Num  Description       Executable        
	  4    <null>            /home/nan/b       
	  3    <null>            /home/nan/b       
	* 2    process 15902     /home/nan/b       
	  1    process 15753     /home/nan/a       
	(gdb) maint info program-spaces
	  Id   Executable        
	  4    /home/nan/b       
	        Bound inferiors: ID 4 (process 0)
	  3    /home/nan/b       
	        Bound inferiors: ID 3 (process 0)
	* 2    /home/nan/b       
	        Bound inferiors: ID 2 (process 15902)
	  1    /home/nan/a       
	        Bound inferiors: ID 1 (process 15753)
可以看到执行“`maint info program-spaces`”命令后，打印出当前有4个`program-spaces`（编号从1到4）。另外还有每个`program-spaces`对应的程序，`inferior`编号及进程号。

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-and-Programs.html).

## 贡献者

nanxiao

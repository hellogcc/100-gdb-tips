# 退出正在调试的函数

## 例子

	#include <stdio.h>

	int func(void)
	{
	    int i = 0;
	
	    i += 2;
	    i *= 10;
	
	    return i;
	}
	
	int main(void)
	{
	    int a = 0;
	
	    a = func();
	    printf("%d\n", a);
	    return 0;
	}



## 技巧

当单步调试一个函数时，如果不想继续跟踪下去了，可以有两种方式退出。

第一种用“`finish`”命令，这样函数会继续执行完，并且打印返回值，然后等待输入接下来的命令。以上面代码为例：

	(gdb) n
	17          a = func();
	(gdb) s
	func () at a.c:5
	5               int i = 0;
	(gdb) n
	7               i += 2;
	(gdb) fin
	find    finish
	(gdb) finish
	Run till exit from #0  func () at a.c:7
	0x08050978 in main () at a.c:17
	17          a = func();
	Value returned is $1 = 20

	
可以看到当不想再继续跟踪`func`函数时，执行完“`finish`”命令，gdb会打印结果：“`20`”，然后停在那里。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Continuing-and-Stepping.html)

第二种用“`return`”命令，这样函数不会继续执行下面的语句，而是直接返回。也可以用“`return expression`”命令指定函数的返回值。仍以上面代码为例：

	(gdb) n
	17          a = func();
	(gdb) s
	func () at a.c:5
	5               int i = 0;
	(gdb) n
	7               i += 2;
	(gdb) n
	8               i *= 10;
	(gdb) re
	record              remove-inferiors    return              reverse-next        reverse-step
	refresh             remove-symbol-file  reverse-continue    reverse-nexti       reverse-stepi
	remote              restore             reverse-finish      reverse-search
	(gdb) return 40
	Make func return now? (y or n) y
	#0  0x08050978 in main () at a.c:17
	17          a = func();
	(gdb) n
	18          printf("%d\n", a);
	(gdb)
	40
	19          return 0;



可以看到“`return`”命令退出了函数并且修改了函数的返回值。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Returning.html#Returning)

## 贡献者

nanxiao




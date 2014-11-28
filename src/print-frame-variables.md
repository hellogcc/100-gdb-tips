# 打印调用栈帧中变量的值 

## 例子

	#include <stdio.h>
	
	int func1(int a)
	{
	  int b = 1;
	  return b * a;
	}
	
	int func2(int a)
	{
	  int b = 2;
	  return b * func1(a);
	}
	
	int func3(int a)
	{
	  int b = 3;
	  return b * func2(a);
	}
	
	int main(void)
	{
	  printf("%d\n", func3(10));
	  return 0;
	}

## 技巧

在gdb中，如果想查看调用栈帧中的变量，可以先切换到该栈帧中，然后打印：

	(gdb) b func1
	(gdb) r
	(gdb) bt
	#0  func1 (a=10) at frame.c:5
	#1  0x0000000000400560 in func2 (a=10) at frame.c:12
	#2  0x0000000000400582 in func3 (a=10) at frame.c:18
	#3  0x0000000000400596 in main () at frame.c:23
	(gdb) f 1
	(gdb) p b
	(gdb) f 2
	(gdb) p b

也可以不进行切换，直接打印：

	(gdb) p func2::b
	$1 = 2
	(gdb) p func3::b
	$2 = 3

同样，对于C++的函数名，需要使用单引号括起来，比如：

	(gdb) p '(anonymous namespace)::SSAA::handleStore'::n->pi->inst->dump()

详情参见[gdb手册](https://sourceware.org/gdb/current/onlinedocs/gdb/Variables.html#Variables)

## 贡献者

xmj


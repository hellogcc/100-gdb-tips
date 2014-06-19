# 是否进入带调试信息的函数

## 例子

	#include <stdio.h>

	int func(void)
	{
		return 3;
	}
	
	int main(void)
	{
		int a = 0;
		
		a = func();
		printf("%d\n", a);
		return 0;
	}



## 技巧

使用gdb调试遇到函数时，使用step命令（缩写为s）可以进入函数（函数必须有调试信息）。以上面代码为例：

	(gdb) n
	12              a = func();
	(gdb) s
	func () at a.c:5
	5               return 3;
	(gdb) n
	6       }
	(gdb)
	main () at a.c:13
	13              printf("%d\n", a);

	
可以看到gdb进入了func函数。

可以使用next命令（缩写为n）不进入函数，gdb会等函数执行完，再显示下一行要执行的程序代码：

	(gdb) n
	12              a = func();
	(gdb) n
	13              printf("%d\n", a);
	(gdb) n
	3
	14              return 0;



可以看到gdb没有进入func函数。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Continuing-and-Stepping.html)

## 贡献者

nanxiao




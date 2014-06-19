# 打印函数局部变量的值 

## 例子

	#include <stdio.h>

	void fun_a(void)
	{
		int a = 0;
		printf("%d\n", a);
	}
	
	void fun_b(void)
	{
		int b = 1;
		fun_a();
		printf("%d\n", b);
	}
	
	void fun_c(void)
	{
		int c = 2;
		fun_b();
		printf("%d\n", c);
	}
	
	void fun_d(void)
	{
		int d = 3;
		fun_c();
		printf("%d\n", d);
	}
	
	int main(void)
	{
		int var = -1;
		fun_d();
		return 0;
	}

## 技巧一

如果要打印函数局部变量的值，可以使用“bt full”命令（bt是backtrace的缩写）。首先我们在函数fun_a里打上断点，当程序断住时，显示调用栈信息：

	(gdb) bt
	#0  fun_a () at a.c:6
	#1  0x000109b0 in fun_b () at a.c:12
	#2  0x000109e4 in fun_c () at a.c:19
	#3  0x00010a18 in fun_d () at a.c:26
	#4  0x00010a4c in main () at a.c:33


接下来，用“bt full”命令显示各个函数的局部变量值：

	(gdb) bt full
	#0  fun_a () at a.c:6
	        a = 0
	#1  0x000109b0 in fun_b () at a.c:12
	        b = 1
	#2  0x000109e4 in fun_c () at a.c:19
	        c = 2
	#3  0x00010a18 in fun_d () at a.c:26
	        d = 3
	#4  0x00010a4c in main () at a.c:33
	        var = -1


也可以使用如下“bt full n”，意思是从内向外显示n个栈桢，及其局部变量，例如：

	(gdb) bt full 2
	#0  fun_a () at a.c:6
	        a = 0
	#1  0x000109b0 in fun_b () at a.c:12
	        b = 1
	(More stack frames follow...)


而“bt full -n”，意思是从外向内显示n个栈桢，及其局部变量，例如：

	(gdb) bt full -2
	#3  0x00010a18 in fun_d () at a.c:26
	        d = 3
	#4  0x00010a4c in main () at a.c:33
	        var = -1


详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Backtrace.html)

## 技巧二

如果只是想打印当前函数局部变量的值，可以使用如下命令：

	(gdb) info locals
	a = 0

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Frame-Info.html#index-info-locals)

## 贡献者

nanxiao

xmj


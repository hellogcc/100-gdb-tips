# 设置变量的值

## 例子

	#include <stdio.h>

    int func(void)
    {
        int i = 2;

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

在gdb中，可以用“`set var variable=expr`”命令设置变量的值，以上面代码为例：


	Breakpoint 2, func () at a.c:5
	5                   int i = 2;
	(gdb) n
	7                   return i;
	(gdb) set var i = 8
	(gdb) p i
	$4 = 8


	
可以看到在`func`函数里用`set`命令把`i`的值修改成为`8`。  

也可以用“`set {type}address=expr`”的方式，含义是给存储地址在`address`，变量类型为`type`的变量赋值，仍以上面代码为例：  

	Breakpoint 2, func () at a.c:5
	5                   int i = 2;
	(gdb) n
	7                   return i;
	(gdb) p &i
	$5 = (int *) 0x8047a54
	(gdb) set {int}0x8047a54 = 8
	(gdb) p i
	$6 = 8

可以看到`i`的值被修改成为`8`。

另外寄存器也可以作为变量，因此同样可以修改寄存器的值：

	Breakpoint 2, func () at a.c:5
	5                   int i = 2;
	(gdb)
	(gdb) n
	7                   return i;
	(gdb)
	8               }
	(gdb) set var $eax = 8
	(gdb) n
	main () at a.c:15
	15                  printf("%d\n", a);
	(gdb)
	8
	16                  return 0;

可以看到因为eax寄存器存储着函数的返回值，所以当把eax寄存器的值改为`8`后，函数的返回值也变成了`8`。  

详情参见[gdb手册](https://sourceware.org/gdb/current/onlinedocs/gdb/Assignment.html#Assignment)



## 贡献者

nanxiao




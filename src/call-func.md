# 直接执行函数
## 例子
	#include <stdio.h>

	int global = 1;
	
	int func(void) 
	{
		return (++global);
	}
	
	int main(void)
	{
		printf("%d\n", global);
		return 0;
	}



## 技巧
使用gdb调试程序时，可以使用“`call`”或“`print`”命令直接调用函数执行。以上面程序为例：  
 
	(gdb) start
	Temporary breakpoint 1 at 0x4004e3: file a.c, line 12.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:12
	12              printf("%d\n", global);
	(gdb) call func()
	$1 = 2
	(gdb) print func()
	$2 = 3
	(gdb) n
	3
	13              return 0;

可以看到执行两次`func`函数后，`global`的值变成`3`。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Calling.html).

## 贡献者

nanxiao

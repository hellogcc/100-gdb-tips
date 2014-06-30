# 忽略断点 

## 例子

	#include <stdio.h>
		
	int main(void)
	{
	        int i = 0;
			int sum = 0;

			for (i = 1; i <= 200; i++)
			{
				sum += i;
			}
		
			printf("%d\n", sum);
	        return 0;
	}



## 技巧

在设置断点以后，可以忽略断点，命令是“`ignore bnum count`”：意思是接下来`count`次编号为`bnum`的断点触发都不会让程序中断，只有第`count + 1`次断点触发才会让程序中断。以上面程序为例：

	(gdb) b 10
	Breakpoint 1 at 0x4004e3: file a.c, line 10.
	(gdb) ignore 1 5
	Will ignore next 5 crossings of breakpoint 1.
	(gdb) r
	Starting program: /data2/home/nanxiao/a
	
	Breakpoint 1, main () at a.c:10
	10                                      sum += i;
	(gdb) p i
	$1 = 6


可以看到设定忽略断点前`5`次触发后，第一次断点断住时，打印`i`的值是`6`。如果想让断点下次就生效，可以将`count`置为`0`：“`ignore 1 0`”。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Conditions.html)

## 贡献者

nanxiao




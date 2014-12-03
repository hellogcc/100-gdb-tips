# 改变字符串的值
## 例子
	#include <stdio.h>

	int main(void)
	{
		char p1[] = "Sam";
		char *p2 = "Bob";
		
		printf("p1 is %s, p2 is %s\n", p1, p2);
		return 0;
	}



## 技巧
使用gdb调试程序时，可以用“`set`”命令改变字符串的值，以上面程序为例：  

	(gdb) start
	Temporary breakpoint 1 at 0x8050af0: file a.c, line 5.
	Starting program: /data1/nan/a 
	[Thread debugging using libthread_db enabled]
	[New Thread 1 (LWP 1)]
	[Switching to Thread 1 (LWP 1)]
	
	Temporary breakpoint 1, main () at a.c:5
	5               char p1[] = "Sam";
	(gdb) n
	6               char *p2 = "Bob";
	(gdb) 
	8               printf("p1 is %s, p2 is %s\n", p1, p2);
	(gdb) set main::p1="Jil"
	(gdb) set main::p2="Bill"
	(gdb) n
	p1 is Jil, p2 is Bill
	9               return 0;
可以看到执行`p1`和`p2`的字符串都发生了变化。也可以通过访问内存地址的方法改变字符串的值：  

	Starting program: /data1/nan/a 
	[Thread debugging using libthread_db enabled]
	[New Thread 1 (LWP 1)]
	[Switching to Thread 1 (LWP 1)]
	
	Temporary breakpoint 2, main () at a.c:5
	5               char p1[] = "Sam";
	(gdb) n
	6               char *p2 = "Bob";
	(gdb) p p1
	$1 = "Sam"
	(gdb) p &p1
	$2 = (char (*)[4]) 0x80477a4
	(gdb) set {char [4]} 0x80477a4 = "Ace"
	(gdb) n
	8               printf("p1 is %s, p2 is %s\n", p1, p2);
	(gdb) 
	p1 is Ace, p2 is Bob
	9               return 0;

在改变字符串的值时候，一定要注意内存越界的问题。  
参见[stackoverflow](http://stackoverflow.com/questions/19503057/in-gdb-how-can-i-write-a-string-to-memory).

## 贡献者

nanxiao

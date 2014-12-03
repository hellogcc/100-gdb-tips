# 为fork调用设置catchpoint
## 例子
	#include <stdio.h>
	#include <stdlib.h>
	#include <sys/types.h>
	#include <unistd.h>
	
	int main(void) {
	    pid_t pid;
	
	    pid = fork();
	    if (pid < 0)
	    {
	        exit(1);
	    }
	    else if (pid > 0)
	    {
	        exit(0);
	    }
	    printf("hello world\n");
	    return 0;
	}



## 技巧
使用gdb调试程序时，可以用“`catch fork`”命令为`fork`调用设置`catchpoint`，以上面程序为例：  

	(gdb) catch fork
	Catchpoint 1 (fork)
	(gdb) r
	Starting program: /home/nan/a 
	
	Catchpoint 1 (forked process 33499), 0x00000034e42acdbd in fork () from /lib64/libc.so.6
	(gdb) bt
	#0  0x00000034e42acdbd in fork () from /lib64/libc.so.6
	#1  0x0000000000400561 in main () at a.c:9
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

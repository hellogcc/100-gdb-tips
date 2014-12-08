# 让catchpoint只触发一次
## 例子
	#include <stdio.h>
	#include <stdlib.h>
	#include <sys/types.h>
	#include <unistd.h>
	
	int main(void) {
	    pid_t pid;
	    int i = 0;
	
	    for (i = 0; i < 2; i++)
	    {
		    pid = fork();
		    if (pid < 0)
		    {
		        exit(1);
		    }
		    else if (pid == 0)
		    {
		        exit(0);
		    }
	    }
	    printf("hello world\n");
	    return 0;
	}

## 技巧
使用gdb调试程序时，可以用“`tcatch`”命令设置`catchpoint`只触发一次，以上面程序为例：  

	(gdb) tcatch fork
	Catchpoint 1 (fork)
	(gdb) r
	Starting program: /home/nan/a
	
	Temporary catchpoint 1 (forked process 27377), 0x00000034e42acdbd in fork () from /lib64/libc.so.6
	(gdb) c
	Continuing.
	hello world
	[Inferior 1 (process 27373) exited normally]
	(gdb) q

可以看到当程序只在第一次调用`fork`时暂停。  

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Set-Catchpoints.html).

## 贡献者

nanxiao

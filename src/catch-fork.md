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
可以看到当`fork`调用发生后，gdb会暂停程序的运行。  
注意：目前只有HP-UX和GNU/Linux支持这个功能。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Set-Catchpoints.html).

## 贡献者

nanxiao

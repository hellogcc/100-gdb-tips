# 同时调试父进程和子进程 

## 例子

	#include <stdio.h>
	#include <stdlib.h>
	
	int main(void) {
	    pid_t pid;
	
	    pid = fork();
	    if (pid < 0)
	    {
	        exit(1);
	    }
	    else if (pid > 0)
	    {
	        printf("Parent\n");
	        exit(0);
	    }
	    printf("Child\n");
	    return 0;
	}



## 技巧

在调试多进程程序时，gdb默认只会追踪父进程的运行，而子进程会独立运行，gdb不会控制。以上面程序为例：

	(gdb) start
	Temporary breakpoint 1 at 0x40055c: file a.c, line 7.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:7
	7           pid = fork();
	(gdb) n
	8           if (pid < 0)
	(gdb) Child
	
	12          else if (pid > 0)
	(gdb)
	14              printf("Parent\n");
	(gdb)
	Parent
	15              exit(0);

可以看到当单步执行到第8行时，程序打印出“Child” ，证明子进程已经开始独立运行。

如果要同时调试父进程和子进程，可以使用“`set detach-on-fork off`”（默认`detach-on-fork`是`on`）命令，这样gdb就能同时调试父子进程，并且在调试一个进程时，另外一个进程处于挂起状态。仍以上面程序为例：

	(gdb) set detach-on-fork off
	(gdb) start
	Temporary breakpoint 1 at 0x40055c: file a.c, line 7.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:7
	7           pid = fork();
	(gdb) n
	[New process 1050]
	8           if (pid < 0)
	(gdb)
	12          else if (pid > 0)
	(gdb) i inferior
	  Num  Description       Executable
	  2    process 1050      /data2/home/nanxiao/a
	* 1    process 1046      /data2/home/nanxiao/a
	(gdb) n
	14              printf("Parent\n");
	(gdb) n
	Parent
	15              exit(0);
	(gdb)
	[Inferior 1 (process 1046) exited normally]
	(gdb)
	The program is not being run.
	(gdb) i inferiors
	  Num  Description       Executable
	  2    process 1050      /data2/home/nanxiao/a
	* 1    <null>            /data2/home/nanxiao/a
	(gdb) inferior 2
	[Switching to inferior 2 [process 1050] (/data2/home/nanxiao/a)]
	[Switching to thread 2 (process 1050)]
	#0  0x00007ffff7af6cad in fork () from /lib64/libc.so.6
	(gdb) bt
	#0  0x00007ffff7af6cad in fork () from /lib64/libc.so.6
	#1  0x0000000000400561 in main () at a.c:7
	(gdb) n
	Single stepping until exit from function fork,
	which has no line number information.
	main () at a.c:8
	8           if (pid < 0)
	(gdb)
	12          else if (pid > 0)
	(gdb)
	17          printf("Child\n");
	(gdb)
	Child
	18          return 0;
	(gdb)



在使用“`set detach-on-fork off`”命令后，用“`i inferiors`”（`i`是`info`命令缩写）查看进程状态，可以看到父子进程都在被gdb调试的状态，前面显示“*”是正在调试的进程。当父进程退出后，用“`inferior infno`”切换到子进程去调试。

这个命令目前Linux支持，其它很多操作系统都不支持，使用时请注意。参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Forks.html)  

此外，如果想让父子进程都同时运行，可以使用“`set schedule-multiple on`”（默认`schedule-multiple`是`off`）命令，仍以上述代码为例：  

	(gdb) set detach-on-fork off
	(gdb) set schedule-multiple on
	(gdb) start
	Temporary breakpoint 1 at 0x40059c: file a.c, line 7.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:7
	7           pid = fork();
	(gdb) n
	[New process 26597]
	Child
可以看到打印出了“Child”，证明子进程也在运行了。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/All_002dStop-Mode.html#All_002dStop-Mode)
## 贡献者

nanxiao




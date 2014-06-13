# 调试子进程 

## 例子

	#include <stdio.h>
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

在调试多进程程序时，gdb默认会追踪父进程。例如：

	(gdb) start
	Temporary breakpoint 1 at 0x40055c: file a.c, line 8.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:8
	8               pid = fork();
	(gdb) n
	9               if (pid < 0)
	(gdb) hello world
	
	13              else if (pid > 0)
	(gdb)
	15                      exit(0);
	(gdb)
	[Inferior 1 (process 12786) exited normally]


	


可以看到程序执行到第15行：父进程退出。 

如果要调试子进程，要使用如下命令：“set follow-fork-mode child”，例如：

	(gdb) set follow-fork-mode child
	(gdb) start
	Temporary breakpoint 1 at 0x40055c: file a.c, line 8.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:8
	8               pid = fork();
	(gdb) n
	[New process 12241]
	[Switching to process 12241]
	9               if (pid < 0)
	(gdb)
	13              else if (pid > 0)
	(gdb)
	17              printf("hello world\n");
	(gdb)
	hello world
	18              return 0;


可以看到程序执行到第17行：子进程打印“hello world”。 

这个命令目前Linux支持，其它很多操作系统都不支持，使用时请注意。参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Forks.html)

## 贡献者

nanxiao




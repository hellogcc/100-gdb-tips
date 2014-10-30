# 查看信号处理信息
## 例子
	#include <stdio.h>
	#include <signal.h>
	
	void handler(int sig);
	
	void handler(int sig)
	{
	        signal(sig, handler);
	        printf("Receive signal: %d\n", sig);
	}
	
	int main(void) {
	        signal(SIGINT, handler);
	        signal(SIGALRM, handler);
	        
	        while (1)
	        {
	                sleep(1);
	        }
	        return 0;
	}

## 技巧
用gdb调试程序时，可以用“`i signals`”命令（或者“`i handle`”命令，`i`是`info`命令缩写）查看gdb如何处理进程收到的信号:  

	(gdb) i signals 
	Signal        Stop      Print   Pass to program Description
	
	SIGHUP        Yes       Yes     Yes             Hangup
	SIGINT        Yes       Yes     No              Interrupt
	SIGQUIT       Yes       Yes     Yes             Quit
	......
	SIGALRM       No        No      Yes             Alarm clock
	......

第一项（`Signal`）：标示每个信号。  
第二项（`Stop`）：表示被调试的程序有对应的信号发生时，gdb是否会暂停程序。  
第三项（`Print`）：表示被调试的程序有对应的信号发生时，gdb是否会打印相关信息。  
第四项（`Pass to program`）：gdb是否会把这个信号发给被调试的程序。  
第五项（`Description`）：信号的描述信息。

从上面的输出可以看到，当`SIGINT`信号发生时，gdb会暂停被调试的程序，并打印相关信息，但不会把这个信号发给被调试的程序。而当`SIGALRM`信号发生时，gdb不会暂停被调试的程序，也不打印相关信息，但会把这个信号发给被调试的程序。  

启动gdb调试上面的程序，同时另起一个终端，先后发送`SIGINT`和`SIGALRM`信号给被调试的进程，输出如下：  

	Program received signal SIGINT, Interrupt.
	0xfeeeae55 in ___nanosleep () from /lib/libc.so.1
	(gdb) c
	Continuing.
	Receive signal: 14

可以看到收到`SIGINT`时，程序暂停了，也输出了信号信息，但并没有把`SIGINT`信号交由进程处理（程序没有输出）。而收到`SIGALRM`信号时，程序没有暂停，也没有输出信号信息，但把`SIGALRM`信号交由进程处理了（程序打印了输出）。


参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Signals.html).

## 贡献者

nanxiao

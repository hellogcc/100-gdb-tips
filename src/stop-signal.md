# 信号发生时是否暂停程序
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
	        signal(SIGHUP, handler);
	        
	        while (1)
	        {
	                sleep(1);
	        }
	        return 0;
	}

## 技巧
用gdb调试程序时，可以用“`handle signal stop/nostop`”命令设置当信号发生时，是否暂停程序的执行，以上面程序为例:  

	(gdb) i signals 
	Signal        Stop      Print   Pass to program Description
	
	SIGHUP        Yes       Yes     Yes             Hangup
	......

	(gdb) r
	Starting program: /data1/nan/test 
	[Thread debugging using libthread_db enabled]
	[New Thread 1 (LWP 1)]
	
	Program received signal SIGHUP, Hangup.
	[Switching to Thread 1 (LWP 1)]
	0xfeeeae55 in ___nanosleep () from /lib/libc.so.1
	(gdb) c
	Continuing.
	Receive signal: 1

可以看到，默认情况下，发生`SIGHUP`信号时，gdb会暂停程序的执行，并打印收到信号的信息。此时需要执行`continue`命令继续程序的执行。

接下来用“`handle SIGHUP nostop`”命令设置当`SIGHUP`信号发生时,gdb不暂停程序，执行如下：

	(gdb) handle SIGHUP nostop
	Signal        Stop      Print   Pass to program Description
	SIGHUP        No        Yes     Yes             Hangup
	(gdb) c
	Continuing.
	
	Program received signal SIGHUP, Hangup.
	Receive signal: 1
可以看到，程序收到`SIGHUP`信号发生时，没有暂停，而是继续执行。

如果想恢复之前的行为，用“`handle SIGHUP stop`”命令即可。

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Signals.html).

## 贡献者

nanxiao

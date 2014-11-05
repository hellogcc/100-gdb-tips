# 信号发生时是否把信号丢给程序处理
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
用gdb调试程序时，可以用“`handle signal pass(noignore)/nopass(ignore)`”命令设置当信号发生时，是否把信号丢给程序处理.其中`pass`和`noignore`含义相同，`nopass`和`ignore`含义相同。以上面程序为例:  

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

可以看到，默认情况下，发生`SIGHUP`信号时，gdb会把信号丢给程序处理。

接下来用“`handle SIGHUP nopass`”命令设置当`SIGHUP`信号发生时，gdb不把信号丢给程序处理，执行如下：

	(gdb) handle SIGHUP nopass
	Signal        Stop      Print   Pass to program Description
	SIGHUP        Yes       Yes     No              Hangup
	(gdb) c
	Continuing.
	
	Program received signal SIGHUP, Hangup.
	0xfeeeae55 in ___nanosleep () from /lib/libc.so.1
	(gdb) c
	Continuing.
可以看到，`SIGHUP`信号发生时，程序没有打印“Receive signal: 1”，说明gdb没有把信号丢给程序处理。

如果想恢复之前的行为，用“`handle SIGHUP pass`”命令即可。

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Signals.html).

## 贡献者

nanxiao

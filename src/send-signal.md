# 给程序发送信号
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
用gdb调试程序的过程中，当被调试程序停止后，可以用“`signal signal_name`”命令让程序继续运行，但会立即给程序发送信号。以上面程序为例:  

	(gdb) r
	`/data1/nan/test' has changed; re-reading symbols.
	Starting program: /data1/nan/test 
	[Thread debugging using libthread_db enabled]
	^C[New Thread 1 (LWP 1)]
	
	Program received signal SIGINT, Interrupt.
	[Switching to Thread 1 (LWP 1)]
	0xfeeeae55 in ___nanosleep () from /lib/libc.so.1
	(gdb) signal SIGHUP
	Continuing with signal SIGHUP.
	Receive signal: 1

可以看到，当程序暂停后，执行`signal SIGHUP`命令，gdb会发送信号给程序处理。

可以使用“`signal 0`”命令使程序重新运行，但不发送任何信号给进程。仍以上面程序为例：

	Program received signal SIGHUP, Hangup.
	0xfeeeae55 in ___nanosleep () from /lib/libc.so.1
	(gdb) signal 0
	Continuing with no signal.

可以看到，`SIGHUP`信号发生时，gdb停住了程序，但是由于执行了“`signal 0`”命令，所以程序重新运行后，并没有收到`SIGHUP`信号。

使用`signal`命令和在shell环境使用`kill`命令给程序发送信号的区别在于：在shell环境使用`kill`命令给程序发送信号，gdb会根据当前的设置决定是否把信号发送给进程，而使用`signal`命令则直接把信号发给进程。

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Signaling.html#Signaling).

## 贡献者

nanxiao

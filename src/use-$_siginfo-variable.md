# 使用“$_siginfo”变量
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
在某些平台上（比如Linux）使用gdb调试程序，当有信号发生时，gdb在把信号丢给程序之前，可以通过`$_siginfo`变量读取一些额外的有关当前信号的信息，这些信息是`kernel`传给信号处理函数的。以上面程序为例:  

	Program received signal SIGHUP, Hangup.
	0x00000034e42accc0 in __nanosleep_nocancel () from /lib64/libc.so.6
	Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.132.el6.x86_64
	(gdb) ptype $_siginfo
	type = struct {
	    int si_signo;
	    int si_errno;
	    int si_code;
	    union {
	        int _pad[28];
	        struct {...} _kill;
	        struct {...} _timer;
	        struct {...} _rt;
	        struct {...} _sigchld;
	        struct {...} _sigfault;
	        struct {...} _sigpoll;
	    } _sifields;
	}
	(gdb) ptype $_siginfo._sifields._sigfault
	type = struct {
	    void *si_addr;
	}
	(gdb) p $_siginfo._sifields._sigfault.si_addr
	$1 = (void *) 0x850e

我们可以了解`$_siginfo`变量里每个成员的类型，并且可以读到成员的值。


参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Signaling.html#Signaling).

## 贡献者

nanxiao

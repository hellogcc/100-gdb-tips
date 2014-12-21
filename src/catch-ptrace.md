# 通过为ptrace调用设置catchpoint破解anti-debugging的程序
## 例子
	#include <sys/ptrace.h>
	#include <stdio.h>
	 
	int main()                                                                      
	{
	        if (ptrace(PTRACE_TRACEME, 0, 0, 0) < 0 ) {
	                printf("Gdb is debugging me, exit.\n");
	                return 1;
	        }
	        printf("No debugger, continuing\n");
	        return 0;
	}



## 技巧
有些程序不想被gdb调试，它们就会在程序中调用“`ptrace`”函数，一旦返回失败，就证明程序正在被gdb等类似的程序追踪，所以就直接退出。以上面程序为例：  

	(gdb) start
	Temporary breakpoint 1 at 0x400508: file a.c, line 6.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:6
	6                       if (ptrace(PTRACE_TRACEME, 0, 0, 0) < 0 ) {
	(gdb) n
	7                               printf("Gdb is debugging me, exit.\n");
	(gdb)
	Gdb is debugging me, exit.
	8                               return 1;



破解这类程序的办法就是为`ptrace`调用设置`catchpoint`，通过修改`ptrace`的返回值，达到目的。仍以上面程序为例：  

	(gdb) catch syscall ptrace
	Catchpoint 2 (syscall 'ptrace' [101])
	(gdb) r
	Starting program: /data2/home/nanxiao/a
	
	Catchpoint 2 (call to syscall ptrace), 0x00007ffff7b2be9c in ptrace () from /lib64/libc.so.6
	(gdb) c
	Continuing.
	
	Catchpoint 2 (returned from syscall ptrace), 0x00007ffff7b2be9c in ptrace () from /lib64/libc.so.6
	(gdb) set $rax = 0
	(gdb) c
	Continuing.
	No debugger, continuing
	[Inferior 1 (process 11491) exited normally]

可以看到，通过修改`rax`寄存器的值，达到修改返回值的目的，从而让gdb可以继续调试程序（打印“`No debugger, continuing`”）。  
详细过程，可以参见这篇文章[避開 PTRACE_TRACME 反追蹤技巧](http://blog.linux.org.tw/~jserv/archives/2011_08.html).

## 贡献者

nanxiao

# 只允许一个线程运行
## 例子
	#include <stdio.h>
	#include <pthread.h>
	int a = 0;
	int b = 0;
	void *thread1_func(void *p_arg)
	{
	        while (1)
	        {
	                a++;
	                sleep(1);
	        }
	}
	
	void *thread2_func(void *p_arg)
	{
	        while (1)
	        {
	                b++;
	                sleep(1);
	        }
	}
	
	int main(void)
	{
	        pthread_t t1, t2;
	
	        pthread_create(&t1, NULL, thread1_func, "Thread 1");
	        pthread_create(&t2, NULL, thread2_func, "Thread 2");
	
	        sleep(1000);
	        return;
	}


## 技巧
用gdb调试多线程程序时，一旦程序断住，所有的线程都处于暂停状态。此时当你调试其中一个线程时（比如执行“`step`”，“`next`”命令），所有的线程都会同时执行。以上面程序为例:  

	(gdb) b a.c:9
	Breakpoint 1 at 0x400580: file a.c, line 9.
	(gdb) r
	Starting program: /data2/home/nanxiao/a
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".
	[New Thread 0x7ffff782c700 (LWP 17368)]
	[Switching to Thread 0x7ffff782c700 (LWP 17368)]
	
	Breakpoint 1, thread1_func (p_arg=0x400718) at a.c:9
	9                       a++;
	(gdb) p b
	$1 = 0
	(gdb) s
	10                      sleep(1);
	(gdb) s
	[New Thread 0x7ffff6e2b700 (LWP 17369)]
	11              }
	(gdb)
	
	Breakpoint 1, thread1_func (p_arg=0x400718) at a.c:9
	9                       a++;
	(gdb)
	10                      sleep(1);
	(gdb) p b
	$2 = 3

`thread1_func`更新全局变量`a`的值，`thread2_func`更新全局变量`b`的值。我在`thread1_func`里`a++`语句打上断点，当断点第一次命中时，打印`b`的值是`0`，在单步调试`thread1_func`几次后，`b`的值变成`3`，证明在单步调试`thread1_func`时，`thread2_func`也在执行。  
如果想在调试一个线程时，让其它线程暂停执行，可以使用“`set scheduler-locking on`”命令：

    (gdb) b a.c:9
	Breakpoint 1 at 0x400580: file a.c, line 9.
	(gdb) r
	Starting program: /data2/home/nanxiao/a
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".
	[New Thread 0x7ffff782c700 (LWP 19783)]
	[Switching to Thread 0x7ffff782c700 (LWP 19783)]
	
	Breakpoint 1, thread1_func (p_arg=0x400718) at a.c:9
	9                       a++;
	(gdb) set scheduler-locking on
	(gdb) p b
	$1 = 0
	(gdb) s
	10                      sleep(1);
	(gdb)
	11              }
	(gdb)
	
	Breakpoint 1, thread1_func (p_arg=0x400718) at a.c:9
	9                       a++;
	(gdb)
	10                      sleep(1);
	(gdb)
	11              }
	(gdb) p b
	$2 = 0

可以看到在单步调试`thread1_func`几次后，`b`的值仍然为`0`，证明在在单步调试`thread1_func`时，`thread2_func`没有执行。

此外，“`set scheduler-locking`”命令除了支持`off`和`on`模式外（默认是`off`），还有一个`step`模式。含义是：当用"`step`"命令调试线程时，其它线程不会执行，但是用其它命令（比如"`next`"）调试线程时，其它线程也许会执行。

这个命令依赖于具体操作系统的调度策略，使用时需注意。参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/All_002dStop-Mode.html#All_002dStop-Mode).

## 贡献者

nanxiao

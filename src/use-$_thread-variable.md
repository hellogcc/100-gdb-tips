# 使用“$_thread”变量
## 例子
	#include <stdio.h>
	#include <pthread.h>
	
	int a = 0;
	
	void *thread1_func(void *p_arg)
	{
	        while (1)
	        {
	                a++;
	                sleep(10);
	        }
	}
	
	void *thread2_func(void *p_arg)
	{
	        while (1)
	        {
	                a++;
	                sleep(10);
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
gdb从7.2版本引入了`$_thread`这个“`convenience variable`”，用来保存当前正在调试的线程号。这个变量在写断点命令或是命令脚本时会很有用。以上面程序为例:
	
	(gdb) wa a
	Hardware watchpoint 2: a
	(gdb) command 2
	Type commands for breakpoint(s) 2, one per line.
	End with a line saying just "end".
	>printf "thread id=%d\n", $_thread
	>end

首先设置了观察点：“wa a”（`wa`是`watch`命令缩写），也就是当`a`的值发生变化时，程序会暂停，接下来在`commands`语句中打印线程号。  
然后继续执行程序：

	(gdb) c
	Continuing.
	[New Thread 0x7ffff782c700 (LWP 20928)]
	[Switching to Thread 0x7ffff782c700 (LWP 20928)]
	Hardware watchpoint 2: a
	
	Old value = 0
	New value = 1
	thread1_func (p_arg=0x400718) at a.c:11
	11                      sleep(10);
	thread id=2
	(gdb) c
	Continuing.
	[New Thread 0x7ffff6e2b700 (LWP 20929)]
	[Switching to Thread 0x7ffff6e2b700 (LWP 20929)]
	Hardware watchpoint 2: a
	
	Old value = 1
	New value = 2
	thread2_func (p_arg=0x400721) at a.c:20
	20                      sleep(10);
	thread id=3

可以看到程序暂停时，会打印线程号：“`thread id=2`”或者“`thread id=3`”。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Threads.html).

## 贡献者

nanxiao

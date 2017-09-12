# 设置观察点
## 例子
	#include <stdio.h>
	#include <pthread.h>
	#include <unistd.h>
	int a = 0;

	void *thread1_func(void *p_arg)
	{
	        while (1)
	        {
	                a++;
	                sleep(10);
	        }
	}

	int main(int argc, char* argv[])
	{
	        pthread_t t1;
	        pthread_create(&t1, NULL, thread1_func, NULL);

	        sleep(1000);
	        return 0;
	}

## 技巧
gdb可以使用“`watch`”命令设置观察点，也就是当一个变量值发生变化时，程序会停下来。以上面程序为例:

	(gdb) start
	Temporary breakpoint 1 at 0x4005a8: file a.c, line 19.
	Starting program: /data2/home/nanxiao/a
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".

	Temporary breakpoint 1, main () at a.c:19
	19              pthread_create(&t1, NULL, thread1_func, "Thread 1");
	(gdb) watch a
	Hardware watchpoint 2: a
	(gdb) r
	Starting program: /data2/home/nanxiao/a
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".
	[New Thread 0x7ffff782c700 (LWP 8813)]
	[Switching to Thread 0x7ffff782c700 (LWP 8813)]
	Hardware watchpoint 2: a

	Old value = 0
	New value = 1
	thread1_func (p_arg=0x4006d8) at a.c:11
	11                      sleep(10);
	(gdb) c
	Continuing.
	Hardware watchpoint 2: a

	Old value = 1
	New value = 2
	thread1_func (p_arg=0x4006d8) at a.c:11
	11                      sleep(10);

可以看到，使用“`watch a`”命令以后，当`a`的值变化：由`0`变成`1`，由`1`变成`2`，程序都会停下来。
此外也可以使用“`watch *(data type*)address`”这样的命令，仍以上面程序为例:

	(gdb) p &a
	$1 = (int *) 0x6009c8 <a>
	(gdb) watch *(int*)0x6009c8
	Hardware watchpoint 2: *(int*)0x6009c8
	(gdb) r
	Starting program: /data2/home/nanxiao/a
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".
	[New Thread 0x7ffff782c700 (LWP 15431)]
	[Switching to Thread 0x7ffff782c700 (LWP 15431)]
	Hardware watchpoint 2: *(int*)0x6009c8

	Old value = 0
	New value = 1
	thread1_func (p_arg=0x4006d8) at a.c:11
	11                      sleep(10);
	(gdb) c
	Continuing.
	Hardware watchpoint 2: *(int*)0x6009c8

	Old value = 1
	New value = 2
	thread1_func (p_arg=0x4006d8) at a.c:11
	11                      sleep(10);

先得到`a`的地址：`0x6009c8`，接着用“`watch *(int*)0x6009c8`”设置观察点，可以看到同“`watch a`”命令效果一样。
观察点可以通过软件或硬件的方式实现，取决于具体的系统。但是软件实现的观察点会导致程序运行很慢，使用时需注意。参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Set-Watchpoints.html).

如果系统支持硬件观测的话，当设置观测点是会打印如下信息：
	Hardware watchpoint num: expr

 如果不想用硬件观测点的话可如下设置：
    set can-use-hw-watchpoints

## 查看断点
列出当前所设置了的所有观察点：
info watchpoints

watch 所设置的断点也可以用控制断点的命令来控制。如 disable、enable、delete等

## 贡献者

nanxiao

# 查看线程信息
## 例子
	#include <stdio.h>
	#include <pthread.h>
	void *thread_func(void *p_arg)
	{
	        while (1)
	        {
	                printf("%s\n", (char*)p_arg);
	                sleep(10);
	        }
	}
	int main(void)
	{
	        pthread_t t1, t2;
	
	        pthread_create(&t1, NULL, thread_func, "Thread 1");
	        pthread_create(&t2, NULL, thread_func, "Thread 2");
	
	        sleep(1000);
	        return;
	}

## 技巧
用gdb调试多线程程序，可以用“i threads”命令（i是info命令缩写）查看所有线程的信息，以上面程序为例（运行平台为Linux，CPU为X86_64）:  

	  (gdb) i threads
	  Id   Target Id         Frame
	  3    Thread 0x7ffff6e2b700 (LWP 31773) 0x00007ffff7915911 in clone () from /lib64/libc.so.6
	  2    Thread 0x7ffff782c700 (LWP 31744) 0x00007ffff78d9bcd in nanosleep () from /lib64/libc.so.6
	* 1    Thread 0x7ffff7fe9700 (LWP 31738) main () at a.c:18

第一项（Id）：是gdb标示每个线程的唯一ID：1，2等等。  
第二项（Target Id）：是具体系统平台用来标示每个线程的ID，不同平台信息可能会不同。 像当前Linux平台显示的就是： Thread 0x7ffff6e2b700 (LWP 31773)。  
第三项（Frame）：显示的是线程执行到哪个函数。  
前面带“*”表示的是“current thread”，可以理解为gdb调试多线程程序时，选择的一个“默认线程”。

再以Solaris平台（CPU为X86_64）为例，可以看到显示信息会略有不同：

    (gdb) i threads
    [New Thread 2 (LWP 2)]
    [New Thread 3 (LWP 3)]
      Id   Target Id         Frame
      6    Thread 3 (LWP 3)  0xfeec870d in _thr_setup () from /usr/lib/libc.so.1
      5    Thread 2 (LWP 2)  0xfefc9661 in elf_find_sym () from /usr/lib/ld.so.1
      4    LWP    3          0xfeec870d in _thr_setup () from /usr/lib/libc.so.1
      3    LWP    2          0xfefc9661 in elf_find_sym () from /usr/lib/ld.so.1
    * 2    Thread 1 (LWP 1)  main () at a.c:18
      1    LWP    1          main () at a.c:18


也可以用“i threads [Id...]”指定打印某些线程的信息，例如：

	  (gdb) i threads 1 2
	  Id   Target Id         Frame
	  2    Thread 0x7ffff782c700 (LWP 12248) 0x00007ffff78d9bcd in nanosleep () from /lib64/libc.so.6
	* 1    Thread 0x7ffff7fe9700 (LWP 12244) main () at a.c:18

使用"thread thread-id"实现不同线程之间的切换，查看指定线程的堆栈信息

```
(gdb) thread 2
[Switching to thread 2 (Thread 0x7ffff782c700 (LWP 12248))]...
```

使用"thread apply [thread-id-list] [all] args"可以在多个线程上执行命令，例如：`thread apply all bt`可以查看所有线程的堆栈信息。

```
(gdb) thread apply all bt
```

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Threads.html).

## 贡献者

nanxiao, shanbaoyin

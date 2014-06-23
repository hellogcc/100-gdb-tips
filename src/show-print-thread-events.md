# 不显示线程启动和退出信息
## 例子
	#include <stdio.h>
	#include <pthread.h>
	
	void *thread_func(void *p_arg)
	{
	       sleep(10);
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
默认情况下，gdb检测到有线程产生和退出时，会打印提示信息，以上面程序为例:  

	(gdb) r
	Starting program: /data/nan/a
	[Thread debugging using libthread_db enabled]
	[New Thread 1 (LWP 1)]
	[New LWP    2        ]
	[New LWP    3        ]
	[LWP    2         exited]
	[New Thread 2        ]
	[LWP    3         exited]
	[New Thread 3        ]


如果不想显示这些信息，可以使用“`set print thread-events off`”命令，这样当有线程产生和退出时，就不会打印提示信息：

    (gdb) set print thread-events off
	(gdb) r
	Starting program: /data/nan/a
	[Thread debugging using libthread_db enabled]



可以看到不再打印相关信息。

这个命令有些平台不支持，使用时需注意。参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Threads.html).

## 贡献者

nanxiao

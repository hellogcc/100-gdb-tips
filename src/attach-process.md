# 调试已经运行的进程

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

调试已经运行的进程有两种方法：一种是gdb启动时，指定进程的ID：gdb program processID（也可以用-p或者--pid指定进程ID，例如：gdb program -p=10210）。以上面代码为例，用“ps”命令已经获得进程ID为10210：

	bash-3.2# gdb -q a 10210
	Reading symbols from /data/nan/a...done.
	Attaching to program `/data/nan/a', process 10210
	[New process 10210]
	Retry #1:
	Retry #2:
	Retry #3:
	Retry #4:
	Reading symbols from /usr/lib/libc.so.1...(no debugging symbols found)...done.
	[Thread debugging using libthread_db enabled]
	[New LWP    3        ]
	[New LWP    2        ]
	[New Thread 1 (LWP 1)]
	[New Thread 2 (LWP 2)]
	[New Thread 3 (LWP 3)]
	Loaded symbols for /usr/lib/libc.so.1
	Reading symbols from /lib/ld.so.1...(no debugging symbols found)...done.
	Loaded symbols for /lib/ld.so.1
	[Switching to Thread 1 (LWP 1)]
	0xfeeeae55 in ___nanosleep () from /usr/lib/libc.so.1
	(gdb) bt
	#0  0xfeeeae55 in ___nanosleep () from /usr/lib/libc.so.1
	#1  0xfeedcae4 in sleep () from /usr/lib/libc.so.1
	#2  0x080509ef in main () at a.c:17

如果嫌每次ps查看进程号比较麻烦，请尝试如下脚本

```shell
# 保存为xgdb.sh（添加可执行权限）
# 用法 xgdb.sh a 
prog_bin=$1
running_name=$(basename $prog_bin)
pid=$(/sbin/pidof $running_name)
gdb attach $pid
```

	
另一种是先启动gdb，然后用“attach”命令“附着”在进程上：

	bash-3.2# gdb -q a
	Reading symbols from /data/nan/a...done.
	(gdb) attach 10210
	Attaching to program `/data/nan/a', process 10210
	[New process 10210]
	Retry #1:
	Retry #2:
	Retry #3:
	Retry #4:
	Reading symbols from /usr/lib/libc.so.1...(no debugging symbols found)...done.
	[Thread debugging using libthread_db enabled]
	[New LWP    3        ]
	[New LWP    2        ]
	[New Thread 1 (LWP 1)]
	[New Thread 2 (LWP 2)]
	[New Thread 3 (LWP 3)]
	Loaded symbols for /usr/lib/libc.so.1
	Reading symbols from /lib/ld.so.1...(no debugging symbols found)...done.
	Loaded symbols for /lib/ld.so.1
	[Switching to Thread 1 (LWP 1)]
	0xfeeeae55 in ___nanosleep () from /usr/lib/libc.so.1
	(gdb) bt
	#0  0xfeeeae55 in ___nanosleep () from /usr/lib/libc.so.1
	#1  0xfeedcae4 in sleep () from /usr/lib/libc.so.1
	#2  0x080509ef in main () at a.c:17



如果不想继续调试了，可以用“detach”命令“脱离”进程：

	(gdb) detach
	Detaching from program: /data/nan/a, process 10210
	(gdb) bt
	No stack.


详情参见[gdb手册](https://sourceware.org/gdb/current/onlinedocs/gdb/Attach.html#index-attach)

## 贡献者

nanxiao




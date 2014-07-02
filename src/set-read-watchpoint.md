# 设置读观察点
## 例子
	#include <stdio.h>
	#include <pthread.h>
	
	int a = 0;
	
	void *thread1_func(void *p_arg)
	{
	        while (1)
	        {
	                printf("%d\n", a);
	                sleep(10);
	        }
	}
	
	int main(void)
	{
	        pthread_t t1;
	
	        pthread_create(&t1, NULL, thread1_func, "Thread 1");
	
	        sleep(1000);
	        return;
	}


## 技巧
gdb可以使用“`rwatch`”命令设置读观察点，也就是当发生读取变量行为时，程序就会暂停住。以上面程序为例:  

	(gdb) start
	Temporary breakpoint 1 at 0x4005f3: file a.c, line 19.
	Starting program: /data2/home/nanxiao/a
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".
	
	Temporary breakpoint 1, main () at a.c:19
	19              pthread_create(&t1, NULL, thread1_func, "Thread 1");
	(gdb) rw a
	Hardware read watchpoint 2: a
	(gdb) c
	Continuing.
	[New Thread 0x7ffff782c700 (LWP 5540)]
	[Switching to Thread 0x7ffff782c700 (LWP 5540)]
	Hardware read watchpoint 2: a
	
	Value = 0
	0x00000000004005c6 in thread1_func (p_arg=0x40071c) at a.c:10
	10                      printf("%d\n", a);
	(gdb) c
	Continuing.
	0
	Hardware read watchpoint 2: a
	
	Value = 0
	0x00000000004005c6 in thread1_func (p_arg=0x40071c) at a.c:10
	10                      printf("%d\n", a);
	(gdb) c
	Continuing.
	0
	Hardware read watchpoint 2: a
	
	Value = 0
	0x00000000004005c6 in thread1_func (p_arg=0x40071c) at a.c:10
	10                      printf("%d\n", a);



可以看到，使用“`rw a`”命令（`rw`是`rwatch`命令的缩写）以后，每次访问`a`的值都会让程序停下来。  
需要注意的是`rwatch`命令只对硬件观察点才生效，参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Set-Watchpoints.html).

## 贡献者

nanxiao

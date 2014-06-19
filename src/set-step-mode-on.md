# 进入不带调试信息的函数

## 例子

	#include <stdio.h>
	#include <pthread.h>
	
	typedef struct
	{
	        int a;
	        int b;
	        int c;
	        int d;
	        pthread_mutex_t mutex;
	}ex_st;
	
	int main(void) {
	        ex_st st = {1, 2, 3, 4, PTHREAD_MUTEX_INITIALIZER};
	        printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	        return 0;
	}



## 技巧

默认情况下，gdb不会进入不带调试信息的函数。以上面代码为例：

	(gdb) n
	15              printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	(gdb) s
	1,2,3,4
	16              return 0;

	
可以看到由于printf函数不带调试信息，所以“s”命令（s是“step”缩写）无法进入printf函数。

可以执行“set step-mode on”命令，这样gdb就不会跳过没有调试信息的函数：

	(gdb) set step-mode on
	(gdb) n
	15              printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	(gdb) s
	0x00007ffff7a993b0 in printf () from /lib64/libc.so.6
	(gdb) s
	0x00007ffff7a993b7 in printf () from /lib64/libc.so.6


可以看到gdb进入了printf函数，接下来可以使用调试汇编程序的办法去调试函数。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Continuing-and-Stepping.html)

## 贡献者

nanxiao




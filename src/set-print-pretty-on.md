# 每行打印一个结构体成员 

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

默认情况下，gdb以一种“紧凑”的方式打印结构体。以上面代码为例：

	(gdb) n
	15              printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	(gdb) p st
	$1 = {a = 1, b = 2, c = 3, d = 4, mutex = {__data = {__lock = 0, __count = 0, __owner = 0, __nusers = 0, __kind = 0,
	      __spins = 0, __list = {__prev = 0x0, __next = 0x0}}, __size = '\000' <repeats 39 times>, __align = 0}}


	


可以看到结构体的显示很混乱，尤其是结构体里还嵌套着其它结构体时。

可以执行“set print pretty on”命令，这样每行只会显示结构体的一名成员，而且还会根据成员的定义层次进行缩进：

	(gdb) set print pretty on
	(gdb) p st
	$2 = {
	  a = 1,
	  b = 2,
	  c = 3,
	  d = 4,
	  mutex = {
	    __data = {
	      __lock = 0,
	      __count = 0,
	      __owner = 0,
	      __nusers = 0,
	      __kind = 0,
	      __spins = 0,
	      __list = {
	        __prev = 0x0,
	        __next = 0x0
	      }
	    },
	    __size = '\000' <repeats 39 times>,
	    __align = 0
	  }
	}




详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Print-Settings.html#index-print-settings)

## 贡献者

nanxiao




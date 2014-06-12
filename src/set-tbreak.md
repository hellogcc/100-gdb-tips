# 设置临时断点 

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

在使用gdb时，如果想让断点只生效一次，可以使用“tbreak”命令（缩写为：tb）。以上面程序为例：

	(gdb) tb a.c:15
	Temporary breakpoint 1 at 0x400500: file a.c, line 15.
	(gdb) i b
	Num     Type           Disp Enb Address            What
	1       breakpoint     del  y   0x0000000000400500 in main at a.c:15
	(gdb) r
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:15
	15              printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	(gdb) i b
	No breakpoints or watchpoints.

	


首先在文件的第15行设置临时断点，当程序断住后，用“i b”（"info breakpoints"缩写）命令查看断点，发现断点没有了。也就是断点命中一次后，就被删掉了。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Set-Breaks.html)

## 贡献者

nanxiao




# 打印一个结构体成员的偏移量

## 例子
``` C
	#include <stdio.h>
	#include <pthread.h>
	
	typedef struct
	{
	        long a;
	        int b;
	        int c;
	        int d;
	        pthread_mutex_t mutex;
	}ex_st;
	
	typedef struct
	{
	        int a;
	        long b;
	        int c;
	        int d;
	        pthread_mutex_t mutex;
	}ex_st2;
	
	int main(void) {
	        ex_st st = {1, 2, 3, 4, PTHREAD_MUTEX_INITIALIZER};
	        ex_st2 st2 = {1, 2, 3, 4, PTHREAD_MUTEX_INITIALIZER};
	        printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	        return 0;
	}
```


## 技巧
想要知道结构体成员的偏移量,查看内存空洞可以使用该命令。

``` gdb
(gdb) ptype /o st
type = struct {
/*    0      |     8 */    long a;
/*    8      |     4 */    int b;
/*   12      |     4 */    int c;
/*   16      |     4 */    int d;
/* XXX  4-byte hole  */
/*   24      |    40 */    pthread_mutex_t mutex;

                           /* total size (bytes):   64 */
                         }
(gdb) ptype /o st2
type = struct {
/*    0      |     4 */    int a;
/* XXX  4-byte hole  */
/*    8      |     8 */    long b;
/*   16      |     4 */    int c;
/*   20      |     4 */    int d;
/*   24      |    40 */    pthread_mutex_t mutex;

                           /* total size (bytes):   64 */
                         }
```



详情参见[gdb手册](https://sourceware.org/gdb/current/onlinedocs/gdb/Symbols.html)

## 贡献者

zhuizhuhaomeng




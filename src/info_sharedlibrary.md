# 显示共享链接库信息
## 例子
	#include <hiredis/hiredis.h>

	int main(void)
	{
	        char a[1026] = {0};
	        redisContext *c = NULL;
	        void *reply = NULL;
	
	        memset(a, 'a', (sizeof(a) - 1));
	        c = redisConnect("127.0.0.1", 6379);
	        if (NULL != c)
	        {
	              reply = redisCommand(c, "set 1 %s", a);
	              freeReplyObject(reply);
	
	              reply = redisCommand(c, "get 1");
	              freeReplyObject(reply);
	
	              redisFree(c);
	        }
	        return 0;
	}


## 技巧
使用"`info sharedlibrary regex`"命令可以显示程序加载的共享链接库信息，其中`regex`可以是正则表达式，意为显示名字符合`regex`的共享链接库。如果没有`regex`，则列出所有的库。以上面程序为例:
	
	(gdb) start
	Temporary breakpoint 1 at 0x109f0: file a.c, line 5.
	Starting program: /export/home/nan/a
	[Thread debugging using libthread_db enabled]
	[New Thread 1 (LWP 1)]
	[Switching to Thread 1 (LWP 1)]
	
	Temporary breakpoint 1, main () at a.c:5
	5                       char a[1026] = {0};
	(gdb) info sharedlibrary
	From        To          Syms Read   Shared Object Library
	0xff3b44a0  0xff3e3490  Yes (*)     /usr/lib/ld.so.1
	0xff3325f0  0xff33d4b4  Yes         /usr/local/lib/libhiredis.so.0.11
	0xff3137f0  0xff31a9f4  Yes (*)     /lib/libsocket.so.1
	0xff215fd4  0xff28545c  Yes (*)     /lib/libnsl.so.1
	0xff0a3a20  0xff14fedc  Yes (*)     /lib/libc.so.1
	0xff320400  0xff3234c8  Yes (*)     /platform/SUNW,UltraAX-i2/lib/libc_psr.so.1
	(*): Shared library is missing debugging information.

可以看到列出所有加载的共享链接库信息，带“`*`”表示库缺少调试信息。  

另外也可以使用正则表达式：

	(gdb) i sharedlibrary hiredi*
	From        To          Syms Read   Shared Object Library
	0xff3325f0  0xff33d4b4  Yes         /usr/local/lib/libhiredis.so.0.11

可以看到只列出了一个库信息。  
参见[gdb手册](https://sourceware.org/gdb/current/onlinedocs/gdb/Files.html#index-shared-libraries).

## 贡献者

nanxiao

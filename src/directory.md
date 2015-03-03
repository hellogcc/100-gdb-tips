# 设置源文件查找路径
## 例子
	#include <stdio.h>
	#include <time.h>
	
	int main(void) {
	        time_t now = time(NULL);
	        struct tm local = {0};
	        struct tm gmt = {0};
	
	        localtime_r(&now, &local);
	        gmtime_r(&now, &gmt);
	
	        return 0;
	}




## 技巧
有时gdb不能准确地定位到源文件的位置（比如文件被移走了，等等），此时可以用`directory`命令设置查找源文件的路径。以上面程序为例：  

	(gdb) start
	Temporary breakpoint 1 at 0x400560: file a.c, line 5.
	Starting program: /home/nan/a
	
	Temporary breakpoint 1, main () at a.c:5
	5       a.c: No such file or directory.
	(gdb) directory ../ki/
	Source directories searched: /home/nan/../ki:$cdir:$cwd
	(gdb) n
	6               struct tm local = {0};
	(gdb)
	7               struct tm gmt = {0};
	(gdb)
	9               localtime_r(&now, &local);
	(gdb)
	10              gmtime_r(&now, &gmt);
	(gdb) q

可以看到，使用`directory`（或`dir`)命令设置源文件的查找目录后，gdb就可以正常地解析源代码了。  

如果希望在gdb启动时，加载code的位置，避免每次在gdb中再次输入命令，可以使用gdb的`-d` 参数
```shell
gdb -q a.out -d /search/code/some 
```

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Source-Path.html).

## 贡献者

nanxiao

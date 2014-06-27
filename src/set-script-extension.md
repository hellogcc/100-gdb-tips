# 按何种方式解析脚本文件 

## 例子

	#include <stdio.h>

	typedef struct
	{
	        int a;
	        int b;
	        int c;
	        int d;
	}ex_st;
	
	int main(void) {
	        ex_st st = {1, 2, 3, 4};
	        printf("%d,%d,%d,%d\n", st.a, st.b, st.c, st.d);
	        return 0;
	}



## 技巧

gdb支持的脚本文件分为两种：一种是只包含gdb自身命令的脚本，例如“.gdbinit”文件，当gdb在启动时，就会执行“.gdbinit”文件中的命令；此外，gdb还支持其它一些语言写的脚本文件（比如python）。  
gdb用“`set script-extension`”命令来决定按何种格式来解析脚本文件。它可以取3个值：  
a）`off`：所有的脚本文件都解析成gdb的命令脚本；  
b）`soft`：根据脚本文件扩展名决定如何解析脚本。如果gdb支持解析这种脚本语言（比如python），就按这种语言解析，否则就按命令脚本解析；  
c）`strict`：根据脚本文件扩展名决定如何解析脚本。如果gdb支持解析这种脚本语言（比如python），就按这种语言解析，否则不解析；  
以上面程序为例，进行调试：

	(gdb) start
	Temporary breakpoint 1 at 0x4004cd: file a.c, line 12.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:12
	12              ex_st st = {1, 2, 3, 4};
	(gdb) q
	A debugging session is active.
	
	        Inferior 1 [process 24249] will be killed.
	
	Quit anyway? (y or n) y


可以看到gdb退出时，默认行为会提示用户是否退出。

下面写一个脚本文件（gdb.py），但内容是一个gdb命令，不是真正的python脚本。用途是退出gdb时不提示：

	set confirm off
再次开始调试：  

	(gdb) start
	Temporary breakpoint 1 at 0x4004cd: file a.c, line 12.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:12
	12              ex_st st = {1, 2, 3, 4};
	(gdb) show script-extension
	Script filename extension recognition is "soft".
	(gdb) source gdb.py
	  File "gdb.py", line 1
	    set confirm off
	              ^
	SyntaxError: invalid syntax


可以看到“`script-extension`”默认值是`soft`，接下来执行“`source gdb.py`”,会按照pyhton语言解析gdb.py文件，但是由于这个文件实质上是一个gdb命令脚本，所以解析出错。  
再执行一次：  

	(gdb) start
	Temporary breakpoint 1 at 0x4004cd: file a.c, line 12.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:12
	12              ex_st st = {1, 2, 3, 4};
	(gdb) set script-extension off
	(gdb) source gdb.py
	(gdb) q
	[root@linux:~]$
这次把“`script-extension`”值改为`off`，所以脚本会按gdb命令脚本去解析，可以看到这次脚本命令生效了。
  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Extending-GDB.html)
## 贡献者

nanxiao




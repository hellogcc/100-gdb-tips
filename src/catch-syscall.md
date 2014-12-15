# 为系统调用设置catchpoint
## 例子
	#include <stdio.h>

	int main(void)
	{
	    char p1[] = "Sam";
	    char *p2 = "Bob";
	
	    printf("p1 is %s, p2 is %s\n", p1, p2);
	    return 0;
	}



## 技巧
使用gdb调试程序时，可以使用`catch syscall [name | number]`为关注的系统调用设置`catchpoint`，以上面程序为例：  

	(gdb) catch syscall mmap
	Catchpoint 1 (syscall 'mmap' [9])
	(gdb) r
	Starting program: /home/nan/a
	
	Catchpoint 1 (call to syscall mmap), 0x00000034e3a16f7a in mmap64 ()
	   from /lib64/ld-linux-x86-64.so.2
	(gdb) c
	Continuing.
	
	Catchpoint 1 (returned from syscall mmap), 0x00000034e3a16f7a in mmap64 ()
	   from /lib64/ld-linux-x86-64.so.2


可以看到当`mmap`调用发生后，gdb会暂停程序的运行。  
也可以使用系统调用的编号设置`catchpoint`，仍以上面程序为例：  

	(gdb) catch syscall 9
	Catchpoint 1 (syscall 'mmap' [9])
	(gdb) r
	Starting program: /home/nan/a
	
	Catchpoint 1 (call to syscall mmap), 0x00000034e3a16f7a in mmap64 ()
	   from /lib64/ld-linux-x86-64.so.2
	(gdb) c
	Continuing.
	
	Catchpoint 1 (returned from syscall mmap), 0x00000034e3a16f7a in mmap64 ()
	   from /lib64/ld-linux-x86-64.so.2
	(gdb) c
	Continuing.
	
	Catchpoint 1 (call to syscall mmap), 0x00000034e3a16f7a in mmap64 ()
	   from /lib64/ld-linux-x86-64.so.2
可以看到和使用`catch syscall mmap`效果是一样的。（系统调用和编号的映射参考具体的`xml`文件，以我的系统为例，就是在`/usr/local/share/gdb/syscalls`文件夹下的`amd64-linux.xml`。）

如果不指定具体的系统调用，则会为所有的系统调用设置`catchpoint`，仍以上面程序为例：  

	(gdb) catch syscall
	Catchpoint 1 (any syscall)
	(gdb) r
	Starting program: /home/nan/a
	
	Catchpoint 1 (call to syscall brk), 0x00000034e3a1618a in brk ()
	   from /lib64/ld-linux-x86-64.so.2
	(gdb) c
	Continuing.
	
	Catchpoint 1 (returned from syscall brk), 0x00000034e3a1618a in brk ()
	   from /lib64/ld-linux-x86-64.so.2
	(gdb)
	Continuing.
	
	Catchpoint 1 (call to syscall mmap), 0x00000034e3a16f7a in mmap64 ()
	   from /lib64/ld-linux-x86-64.so.2



参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Set-Catchpoints.html).

## 贡献者

nanxiao

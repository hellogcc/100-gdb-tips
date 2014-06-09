# 为调试进程产生core dump文件


# 技巧
在用gdb调试程序时，我们有时想让被调试的进程产生core dump文件，记录现在进程的状态，以供以后分析。可以用“generate-core-file”命令来产生core dump文件：

	(gdb) help generate-core-file
	Save a core file with the current state of the debugged process.
	Argument is optional filename.  Default filename is 'core.<process_id>'.
 
	(gdb) start
	Temporary breakpoint 1 at 0x8050c12: file a.c, line 9.
	Starting program: /data1/nan/a
	[Thread debugging using libthread_db enabled]
	[New Thread 1 (LWP 1)]
	[Switching to Thread 1 (LWP 1)]
	
	Temporary breakpoint 1, main () at a.c:9
	9           change_var();
	(gdb) generate-core-file
	Saved corefile core.12955

也可使用“gcore”命令：  

	(gdb) help gcore
	Save a core file with the current state of the debugged process.
	Argument is optional filename.  Default filename is 'core.<process_id>'.
	(gdb) gcore
	Saved corefile core.13256

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Core-File-Generation.html)

## 贡献者

nanxiao


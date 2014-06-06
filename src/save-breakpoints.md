# 保存已经设置的断点

## 例子

	$ gdb -q `which gdb`
	Reading symbols from /home/xmj/install/binutils-trunk/bin/gdb...done.
	(gdb) b gdb_main
	Breakpoint 1 at 0x5a7af0: file /home/xmj/project/binutils-trunk/gdb/main.c, line 1061.
	(gdb) b captured_main
	Breakpoint 2 at 0x5a6bd0: file /home/xmj/project/binutils-trunk/gdb/main.c, line 310.
	(gdb) b captured_command_loop
	Breakpoint 3 at 0x5a68b0: file /home/xmj/project/binutils-trunk/gdb/main.c, line 261.

## 技巧

在gdb中，可以使用如下命令将设置的断点保存下来：

<pre><code>(gdb) save breakpoints <i>file-name-to-save</i></code></pre>

下此调试时，可以使用如下命令批量设置保存的断点：

<pre><code>(gdb) source <i>file-name-to-save</i></code></pre>

	(gdb) info breakpoints 
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x00000000005a7af0 in gdb_main at /home/xmj/project/binutils-trunk/gdb/main.c:1061
	2       breakpoint     keep y   0x00000000005a6bd0 in captured_main at /home/xmj/project/binutils-trunk/gdb/main.c:310
	3       breakpoint     keep y   0x00000000005a68b0 in captured_command_loop at /home/xmj/project/binutils-trunk/gdb/main.c:261

详情参见[gdb手册](https://sourceware.org/gdb/download/onlinedocs/gdb/Save-Breakpoints.html#Save-Breakpoints)

## 贡献者

xmj


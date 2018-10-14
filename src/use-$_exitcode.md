# 使用“$_exitcode”变量
## 例子
	int main(void)
	{
	    return 0;
	}


## 技巧
当被调试的程序正常退出时，gdb会使用`$_exitcode`这个“`convenience variable`”记录程序退出时的“`exit code`”。以调试上面程序为例:
	
	[root@localhost nan]# gdb -q a
	Reading symbols from a...done.
	(gdb) start
	Temporary breakpoint 1 at 0x400478: file a.c, line 3.
	Starting program: /home/nan/a
	
	Temporary breakpoint 1, main () at a.c:3
	3               return 0;
	(gdb) n
	4       }
	(gdb)
	0x00000034e421ed1d in __libc_start_main () from /lib64/libc.so.6
	(gdb)
	Single stepping until exit from function __libc_start_main,
	which has no line number information.
	[Inferior 1 (process 1185) exited normally]
	(gdb) p $_exitcode
	$1 = 0

可以看到打印的`$_exitcode`的值为`0`。  
改变程序，返回值改为`1`：

	int main(void)
	{
	    return 1;
	}
接着调试：  

	[root@localhost nan]# gdb -q a
	Reading symbols from a...done.
	(gdb) start
	Temporary breakpoint 1 at 0x400478: file a.c, line 3.
	Starting program: /home/nan/a
	
	Temporary breakpoint 1, main () at a.c:3
	3               return 1;
	(gdb)
	(gdb) n
	4       }
	(gdb)
	0x00000034e421ed1d in __libc_start_main () from /lib64/libc.so.6
	(gdb)
	Single stepping until exit from function __libc_start_main,
	which has no line number information.
	[Inferior 1 (process 2603) exited with code 01]
	(gdb) p $_exitcode
	$1 = 1

可以看到打印的`$_exitcode`的值变为`1`。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Convenience-Vars.html).

## 贡献者

nanxiao

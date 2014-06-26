# 设置被调试程序的环境变量

## 例子

	(gdb) u 309
	Warning: couldn't activate thread debugging using libthread_db: Cannot find new threads: generic error
	Warning: couldn't activate thread debugging using libthread_db: Cannot find new threads: generic error
	warning: Unable to find libthread_db matching inferior's thread library, thread debugging will not be available.

## 技巧

在gdb中，可以通过命令`set env varname=value`来设置被调试程序的环境变量。对于上面的例子，网上可以搜到一些解决方法，其中一种方法就是设置LD_PRELOAD环境变量：

	set env LD_PRELOAD=/lib/x86_64-linux-gnu/libpthread.so.0

注意，这个实际路径在不同的机器环境下可能不一样。把这个命令加到~/.gdbinit文件中，就可以了。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Environment.html#Environment)

## 贡献者

xmj


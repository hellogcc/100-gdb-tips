# 设置被调试程序的参数

## 技巧

可以在gdb启动时，通过选项指定被调试程序的参数，例如：

	$ gdb -args ./a.out a b c

也可以在gdb中，通过命令来设置，例如：

	(gdb) set args a b c
	(gdb) show args
	Argument list to give program being debugged when it is started is "a b c".

也可以在运行程序时，直接指定：

	(gdb) r a b
	Starting program: /home/xmj/tmp/a.out a b
	(gdb) show args
	Argument list to give program being debugged when it is started is "a b".
	(gdb) r
	Starting program: /home/xmj/tmp/a.out a b 

可以看出，参数已经被保存了，下次运行时直接运行`run`命令，即可。

有意的是，如果我接下来，想让参数为空，该怎么办？是的，直接：

	(gdb) set args

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Arguments.html#Arguments)

## 贡献者

xmj


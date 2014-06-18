# 在gdb中执行shell命令和make

## 技巧

你可以不离开gdb，直接执行shell命令，比如：

	(gdb) shell ls

或

	(gdb) !ls

这里，"!"和命令之间不需要有空格（即，有也成）。

特别是当你在构建环境(build目录)下调试程序的时候，可以直接运行make：

	(gdb) make CFLAGS="-g -O0"

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Shell-Commands.html#Shell-Commands)

## 贡献者

xmj


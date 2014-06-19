# 命令行选项的格式

## 技巧

gdb的帮助信息和在线文档对于长选项的形式使用了不同的风格。你可能有点迷惑，gdb的长选项究竟应该是“-”，还是“--”？

是的，这两种方式都可以。例如：

	$ gdb -help
	$ gdb --help

	$ gdb -args ./a.out a b c
	$ gdb --args ./a.out a b c

好吧，使用短的。

## 贡献者

xmj


# 在gdb中执行cd和pwd命令

## 技巧

是的，gdb确实支持这两个命令，虽然我没有想到它们有什么特别的用处。

也许，当你启动gdb之后，发现需要切换工作目录，但又不想退出gdb的时候：

	(gdb) pwd
	Working directory /home/xmj.
	(gdb) cd tmp
	Working directory /home/xmj/tmp.

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Working-Directory.html#Working-Directory)

## 贡献者

xmj


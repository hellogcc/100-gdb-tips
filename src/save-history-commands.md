# 保存历史命令

## 技巧

在gdb中，缺省是不保存历史命令的。你可以通过如下命令来设置成保存历史命令：

	(gdb) set history save on

但是，历史命令是缺省保存在了当前目录下的.gdb_history文件中。可以通过如下命令来设置要保存的文件名和路径：

	(gdb) set history filename fname

现在，我们把这两个命令放到$HOME/.gdbinit文件中：

	set history filename ~/.gdb_history
	set history save on

好了，下次启动gdb时，你就可以直接查找使用之前的历史命令了。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Command-History.html#Command-History)

## 贡献者

xmj


# 设置命令提示符 

## 例子

	$ gdb -q `which gdb`
	Reading symbols from /home/xmj/install/binutils-gdb-git/bin/gdb...done.
	(gdb) r -q
	Starting program: /home/xmj/install/binutils-gdb-git/bin/gdb -q
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
	(gdb)

## 技巧

当你用gdb来调试gdb的时候，通过设置命令提示符，可以帮助你区分这两个gdb：

	$ gdb -q `which gdb`
	Reading symbols from /home/xmj/install/binutils-gdb-git/bin/gdb...done.
	(gdb) set prompt (main gdb) 
	(main gdb) r -q
	Starting program: /home/xmj/install/binutils-gdb-git/bin/gdb -q
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
	(gdb) 

注意，这里`set prompt (main gdb) `结尾处是有一个空格的。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Prompt.html#Prompt)

## 贡献者

xmj


# 使用命令的缩写形式

## 技巧

在gdb中，你不用必须输入完整的命令，只需命令的（前）几个字母即可。规则是，只要这个缩写不会和其它命令有歧义（注，是否有歧义，这个规则从文档上看不出，看起来需要查看gdb的源代码，或者在实际使用中进行总结）。也可以使用tab键进行命令补全。

其中许多常用命令只使用第一个字母就可以，比如：

	b -> break
	c -> continue
	d -> delete
	f -> frame
	i -> info
	j -> jump
	l -> list
	n -> next
	p -> print
	r -> run
	s -> step
	u -> until

也有使用两个或几个字母的，比如：  

	aw -> awatch
	bt -> backtrace
	dir -> directory
	disas -> disassemble
	fin -> finish
	ig -> ignore
	ni -> nexti
	rw -> rwatch
	si -> stepi
	tb -> tbreak
	wa -> watch
	win -> winheight
	
另外，如果直接按回车键，会重复执行上一次的命令。

## 贡献者

xmj

nanxiao


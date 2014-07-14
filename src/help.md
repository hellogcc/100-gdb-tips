# 得到命令的帮助信息

## 技巧

使用`help`命令可以得到gdb的命令帮助信息：  

（1）`help`命令不加任何参数会得到命令的分类：

	(gdb) help
	List of classes of commands:
	
	aliases -- Aliases of other commands
	breakpoints -- Making program stop at certain points
	data -- Examining data
	files -- Specifying and examining files
	internals -- Maintenance commands
	obscure -- Obscure features
	running -- Running the program
	stack -- Examining the stack
	status -- Status inquiries
	support -- Support facilities
	tracepoints -- Tracing of program execution without stopping the program
	user-defined -- User-defined commands
	
	Type "help" followed by a class name for a list of commands in that class.
	Type "help all" for the list of all commands.
	Type "help" followed by command name for full documentation.
	Type "apropos word" to search for commands related to "word".
	Command name abbreviations are allowed if unambiguous.
（2）当输入`help class`命令时，可以得到这个类别下所有命令的列表和命令功能：  

	(gdb) help data
	Examining data.
	
	List of commands:
	
	append -- Append target code/data to a local file
	append binary -- Append target code/data to a raw binary file
	append binary memory -- Append contents of memory to a raw binary file
	append binary value -- Append the value of an expression to a raw binary file
	append memory -- Append contents of memory to a raw binary file
	append value -- Append the value of an expression to a raw binary file
	call -- Call a function in the program
	disassemble -- Disassemble a specified section of memory
	display -- Print value of expression EXP each time the program stops
	dump -- Dump target code/data to a local file
	dump binary -- Write target code/data to a raw binary file
	dump binary memory -- Write contents of memory to a raw binary file
	dump binary value -- Write the value of an expression to a raw binary file
	......
（3）也可以用`help command`命令得到某一个具体命令的用法：  

	(gdb) help mem
	Define attributes for memory region or reset memory region handling totarget-based.
	Usage: mem auto
       mem <lo addr> <hi addr> [<mode> <width> <cache>],
	where <mode>  may be rw (read/write), ro (read-only) or wo (write-only),
      <width> may be 8, 16, 32, or 64, and
      <cache> may be cache or nocache

（4）用`apropos regexp`命令查找所有符合`regexp`正则表达式的命令信息：  

	(gdb) apropos set
	awatch -- Set a watchpoint for an expression
	b -- Set breakpoint at specified line or function
	br -- Set breakpoint at specified line or function
	bre -- Set breakpoint at specified line or function
	brea -- Set breakpoint at specified line or function
	......

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Help.html)

## 贡献者

nanxiao




# 支持预处理器宏信息

## 例子

	#include <stdio.h>
	
	#define NAME "Joe"
	
	int main()
	{
	  printf ("Hello %s\n", NAME);
	  return 0;
	}

## 技巧

使用`gcc -g`编译生成的程序，是不包含预处理器宏信息的：

	(gdb) p NAME
	No symbol "NAME" in current context.

如果想在gdb中查看宏信息，可以使用`gcc -g3`进行编译：

	(gdb) p NAME
	$1 = "Joe"

关于预处理器宏的命令，参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Macros.html#Macros)

## 贡献者

xmj


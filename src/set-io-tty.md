# 指定程序的输入输出设备

## 例子

	#include <stdio.h>
	
	int main(void)
	{
	  int i;
	
	  for (i = 0; i < 100; i++)
	    {
	      printf("i = %d\n", i);
	    }
	
	  return 0;
	}

## 技巧

在gdb中，缺省情况下程序的输入输出是和gdb使用同一个终端。你也可以为程序指定一个单独的输入输出终端。

首先，打开一个新终端，使用如下命令获得设备文件名：

	$ tty
	/dev/pts/2

然后，通过命令行选项指定程序的输入输出设备：

	$ gdb -tty /dev/pts/2 ./a.out
	(gdb) r

或者，在gdb中，使用命令进行设置：

	(gdb) tty /dev/pts/2

详情参见[gdb手册](https://sourceware.org/gdb/current/onlinedocs/gdb/Input_002fOutput.html#index-tty)

## 贡献者

xmj


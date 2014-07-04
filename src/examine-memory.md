# 打印内存的值
## 例子
	#include <stdio.h>

	int main(void)
	{
	        int i = 0;
	        char a[100];
	
	        for (i = 0; i < sizeof(a); i++)
	        {
	                a[i] = i;
	        }
	
	        return 0;
	}


## 技巧
gdb中使用“`x`”命令来打印内存的值，格式为“`x/nfu addr`”。含义为以`f`格式打印从`addr`开始的`n`个长度单元为`u`的内存值。参数具体含义如下：  
a）n：输出单元的个数。  
b）f：是输出格式。比如`x`是以16进制形式输出，`o`是以8进制形式输出,等等。  
c）u：标明一个单元的长度。`b`是一个`byte`，`h`是两个`byte`（halfword），`w`是四个`byte`（word），`g`是八个`byte`（giant word）。  

以上面程序为例：  
（1） 以16进制格式打印数组前`a`16个byte的值：  

	(gdb) x/16xb a
	0x7fffffffe4a0: 0x00    0x01    0x02    0x03    0x04    0x05    0x06    0x07
	0x7fffffffe4a8: 0x08    0x09    0x0a    0x0b    0x0c    0x0d    0x0e    0x0f
（2） 以无符号10进制格式打印数组`a`前16个byte的值：  

	(gdb) x/16ub a
	0x7fffffffe4a0: 0       1       2       3       4       5       6       7
	0x7fffffffe4a8: 8       9       10      11      12      13      14      15
（3） 以2进制格式打印数组前16个`a`byte的值：  

	(gdb) x/16tb a
	0x7fffffffe4a0: 00000000        00000001        00000010        00000011        00000100        00000101        00000110        00000111
	0x7fffffffe4a8: 00001000        00001001        00001010        00001011        00001100        00001101        00001110        00001111
（4）  以16进制格式打印数组`a`前16个word（4个byte）的值：  

	(gdb) x/16xw a
	0x7fffffffe4a0: 0x03020100      0x07060504      0x0b0a0908      0x0f0e0d0c
	0x7fffffffe4b0: 0x13121110      0x17161514      0x1b1a1918      0x1f1e1d1c
	0x7fffffffe4c0: 0x23222120      0x27262524      0x2b2a2928      0x2f2e2d2c
	0x7fffffffe4d0: 0x33323130      0x37363534      0x3b3a3938      0x3f3e3d3c



参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Memory.html).

## 贡献者

nanxiao

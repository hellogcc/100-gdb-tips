# 打印ASCII和宽字符字符串
## 例子
	#include <stdio.h>
	#include <wchar.h>
	
	int main(void)
	{
	        char str1[] = "abcd";
	        wchar_t str2[] = L"abcd";
	        
	        return 0;
	}

## 技巧
用gdb调试程序时，可以使用“`x/s`”命令打印ASCII字符串。以上面程序为例：  

    Temporary breakpoint 1, main () at a.c:6
	6               char str1[] = "abcd";
	(gdb) n
	7               wchar_t str2[] = L"abcd";
	(gdb) 
	9               return 0;
	(gdb) x/s str1
	0x804779f:      "abcd"

可以看到打印出了`str1`字符串的值。

打印宽字符字符串时，要根据宽字符的长度决定如何打印。仍以上面程序为例： 

    Temporary breakpoint 1, main () at a.c:6
	6               char str1[] = "abcd";
	(gdb) n
	7               wchar_t str2[] = L"abcd";
	(gdb) 
	9               return 0;
	(gdb) p sizeof(wchar_t)
	$1 = 4
	(gdb) x/ws str2
	0x8047788:      U"abcd"
由于当前平台宽字符的长度为4个字节，则用“`x/ws`”命令。如果是2个字节，则用“`x/hs`”命令。

参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Memory.html).

## 贡献者

nanxiao

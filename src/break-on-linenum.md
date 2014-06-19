# 在文件行号上打断点

## 例子

	/* a/file.c */
	#include <stdio.h>
	
	void print_a (void)
	{
	  puts ("a");
	}
	
	/* b/file.c */
	#include <stdio.h>
	
	void print_b (void)
	{
	  puts ("b");
	}
	
	/* main.c */
	extern void print_a(void);
	extern void print_b(void);
	
	int main(void)
	{
	  print_a();
	  print_b();
	  return 0;
	}

## 技巧

这个比较简单，如果要在当前文件中的某一行打断点，直接`b linenum`即可，例如：

	(gdb) b 7

也可以显式指定文件，`b file:linenum`例如：

	(gdb) b file.c:6
	Breakpoint 1 at 0x40053b: file.c:6. (2 locations)
	(gdb) i breakpoints 
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   <MULTIPLE>         
	1.1                         y     0x000000000040053b in print_a at a/file.c:6
	1.2                         y     0x000000000040054b in print_b at b/file.c:6

可以看出，gdb会对所有匹配的文件设置断点。你可以通过指定（部分）路径，来区分相同的文件名：

	(gdb) b a/file.c:6

注意：通过行号进行设置断点的一个弊端是，如果你更改了源程序，那么之前设置的断点就可能不是你想要的了。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Specify-Location.html#Specify-Location)

## 贡献者

xmj


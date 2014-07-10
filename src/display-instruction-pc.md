# 显示将要执行的汇编指令 

## 例子

	#include <stdio.h>
	int global_var;
	
	void change_var(){
	    global_var=100;
	}
	
	int main(void){
	    change_var();
	    return 0;
	}


## 技巧

使用gdb调试汇编程序时，可以用“`display /i $pc`”命令显示当程序停止时，将要执行的汇编指令。以上面程序为例：

	(gdb) start
	Temporary breakpoint 1 at 0x400488: file a.c, line 9.
	Starting program: /data2/home/nanxiao/a
	
	Temporary breakpoint 1, main () at a.c:9
	9           change_var();
	(gdb) display /i $pc
	1: x/i $pc
	=> 0x400488 <main+4>:   mov    $0x0,%eax
	(gdb) si
	0x000000000040048d      9           change_var();
	1: x/i $pc
	=> 0x40048d <main+9>:   callq  0x400474 <change_var>
	(gdb)
	change_var () at a.c:4
	4       void change_var(){
	1: x/i $pc
	=> 0x400474 <change_var>:       push   %rbp

可以看到打印出了将要执行的汇编指令。此外也可以一次显示多条指令：

	(gdb) display /3i $pc
	2: x/3i $pc
	=> 0x400474 <change_var>:       push   %rbp
	   0x400475 <change_var+1>:     mov    %rsp,%rbp
	   0x400478 <change_var+4>:     movl   $0x64,0x2003de(%rip)        # 0x600860 <global_var>
可以看到一次显示了`3`条指令。

取消显示可以用`undisplay`命令。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Auto-Display.html)

## 贡献者

nanxiao




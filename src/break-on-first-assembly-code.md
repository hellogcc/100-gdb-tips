# 在函数的第一条汇编指令打断点 

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

通常给函数打断点的命令：“b func”（b是break命令的缩写），不会把断点设置在汇编指令层次函数的开头，例如：

	(gdb) b main
	Breakpoint 1 at 0x8050c12: file a.c, line 9.
	(gdb) r
	Starting program: /data1/nan/a
	[Thread debugging using libthread_db enabled]
	[New Thread 1 (LWP 1)]
	[Switching to Thread 1 (LWP 1)]
	
	Breakpoint 1, main () at a.c:9
	9           change_var();
	(gdb) disassemble
	Dump of assembler code for function main:
	   0x08050c0f <+0>:     push   %ebp
	   0x08050c10 <+1>:     mov    %esp,%ebp
	=> 0x08050c12 <+3>:     call   0x8050c00 <change_var>
	   0x08050c17 <+8>:     mov    $0x0,%eax
	   0x08050c1c <+13>:    pop    %ebp
	   0x08050c1d <+14>:    ret
	End of assembler dump.

	


可以看到程序停在了第三条汇编指令（箭头所指位置）。如果要把断点设置在汇编指令层次函数的开头，要使用如下命令：“b *func”，例如：

	(gdb) b *main
	Breakpoint 1 at 0x8050c0f: file a.c, line 8.
	(gdb) r
	Starting program: /data1/nan/a
	[Thread debugging using libthread_db enabled]
	[New Thread 1 (LWP 1)]
	[Switching to Thread 1 (LWP 1)]
	
	Breakpoint 1, main () at a.c:8
	8       int main(void){
	(gdb) disassemble
	Dump of assembler code for function main:
	=> 0x08050c0f <+0>:     push   %ebp
	   0x08050c10 <+1>:     mov    %esp,%ebp
	   0x08050c12 <+3>:     call   0x8050c00 <change_var>
	   0x08050c17 <+8>:     mov    $0x0,%eax
	   0x08050c1c <+13>:    pop    %ebp
	   0x08050c1d <+14>:    ret
	End of assembler dump.

可以看到程序停在了第一条汇编指令（箭头所指位置）。


## 贡献者

nanxiao


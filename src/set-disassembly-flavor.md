# 设置汇编指令格式 

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

在Intel x86处理器上，gdb默认显示汇编指令格式是AT&T格式。例如：

	(gdb) disassemble main
	Dump of assembler code for function main:
	   0x08050c0f <+0>:     push   %ebp
	   0x08050c10 <+1>:     mov    %esp,%ebp
	   0x08050c12 <+3>:     call   0x8050c00 <change_var>
	   0x08050c17 <+8>:     mov    $0x0,%eax
	   0x08050c1c <+13>:    pop    %ebp
	   0x08050c1d <+14>:    ret
	End of assembler dump.
	


可以用“set disassembly-flavor”命令将格式改为intel格式：

	(gdb) set disassembly-flavor intel
	(gdb) disassemble main
	Dump of assembler code for function main:
	   0x08050c0f <+0>:     push   ebp
	   0x08050c10 <+1>:     mov    ebp,esp
	   0x08050c12 <+3>:     call   0x8050c00 <change_var>
	   0x08050c17 <+8>:     mov    eax,0x0
	   0x08050c1c <+13>:    pop    ebp
	   0x08050c1d <+14>:    ret
	End of assembler dump.



目前“set disassembly-flavor”命令只能用在Intel x86处理器上，并且取值只有“intel”和“att”。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Machine-Code.html)

## 贡献者

nanxiao




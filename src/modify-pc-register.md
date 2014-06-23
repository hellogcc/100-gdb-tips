# 修改PC寄存器的值
## 例子
	#include <stdio.h>
	int main(void)
	{       
	        int a =0;               
	
	        a++;    
	        a++;    
	        printf("%d\n", a);      
	        return 0;
	}


## 技巧
PC寄存器会存储程序下一条要执行的指令，通过修改这个寄存器的值，可以达到改变程序执行流程的目的。  
上面的程序会输出“`a=2`”，下面介绍一下如何通过修改PC寄存器的值，改变程序执行流程。  

	4               int a =0;
	(gdb) disassemble main
	Dump of assembler code for function main:
	0x08050921 <main+0>:    push   %ebp
	0x08050922 <main+1>:    mov    %esp,%ebp
	0x08050924 <main+3>:    sub    $0x8,%esp
	0x08050927 <main+6>:    and    $0xfffffff0,%esp
	0x0805092a <main+9>:    mov    $0x0,%eax
	0x0805092f <main+14>:   add    $0xf,%eax
	0x08050932 <main+17>:   add    $0xf,%eax
	0x08050935 <main+20>:   shr    $0x4,%eax
	0x08050938 <main+23>:   shl    $0x4,%eax
	0x0805093b <main+26>:   sub    %eax,%esp
	0x0805093d <main+28>:   movl   $0x0,-0x4(%ebp)
	0x08050944 <main+35>:   lea    -0x4(%ebp),%eax
	0x08050947 <main+38>:   incl   (%eax)
	0x08050949 <main+40>:   lea    -0x4(%ebp),%eax
	0x0805094c <main+43>:   incl   (%eax)
	0x0805094e <main+45>:   sub    $0x8,%esp
	0x08050951 <main+48>:   pushl  -0x4(%ebp)
	0x08050954 <main+51>:   push   $0x80509b4
	0x08050959 <main+56>:   call   0x80507cc <printf@plt>
	0x0805095e <main+61>:   add    $0x10,%esp
	0x08050961 <main+64>:   mov    $0x0,%eax
	0x08050966 <main+69>:   leave
	0x08050967 <main+70>:   ret
	End of assembler dump.
	(gdb) info line 6
	Line 6 of "a.c" starts at address 0x8050944 <main+35> and ends at 0x8050949 <main+40>.
	(gdb) info line 7
	Line 7 of "a.c" starts at address 0x8050949 <main+40> and ends at 0x805094e <main+45>.

通过“`info line 6`”和“`info line 7`”命令可以知道两条“`a++;`”语句的汇编指令起始地址分别是`0x8050944`和`0x8050949`。

    (gdb) n
	6               a++;
	(gdb) p $pc
	$3 = (void (*)()) 0x8050944 <main+35>
	(gdb) set var $pc=0x08050949
当程序要执行第一条“`a++;`”语句时，打印`pc`寄存器的值，看到`pc`寄存器的值为`0x8050944`，与“`info line 6`”命令得到的一致。接下来，把`pc`寄存器的值改为`0x8050949`，也就是通过“`info line 7`”命令得到的第二条“`a++;`”语句的起始地址。

	(gdb) n
	8               printf("a=%d\n", a);
	(gdb)
	a=1
	9               return 0;

接下来执行，可以看到程序输出“`a=1`”，也就是跳过了第一条“`a++;`”语句。


## 贡献者

nanxiao

# 在程序地址上打断点 

## 例子

	0000000000400522 <main>:
	  400522:       55                      push   %rbp
	  400523:       48 89 e5                mov    %rsp,%rbp
	  400526:       8b 05 00 1b 00 00       mov    0x1b00(%rip),%eax        # 40202c <he+0xc>
	  40052c:       85 c0                   test   %eax,%eax
	  40052e:       75 07                   jne    400537 <main+0x15>
	  400530:       b8 7c 06 40 00          mov    $0x40067c,%eax
	  400535:       eb 05                   jmp    40053c <main+0x1a>

## 技巧

当调试汇编程序，或者没有调试信息的程序时，经常需要在程序地址上打断点，方法为`b *address`。例如：

	(gdb) b *0x400522

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Specify-Location.html#Specify-Location)

## 贡献者

xmj


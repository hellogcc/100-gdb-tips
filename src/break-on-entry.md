# 在程序入口处打断点 

## 例子

	$ strip a.out
	$ readelf -h a.out 
	ELF Header:
	  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
	  Class:                             ELF64
	  Data:                              2's complement, little endian
	  Version:                           1 (current)
	  OS/ABI:                            UNIX - System V
	  ABI Version:                       0
	  Type:                              EXEC (Executable file)
	  Machine:                           Advanced Micro Devices X86-64
	  Version:                           0x1
	  Entry point address:               0x400440
	  Start of program headers:          64 (bytes into file)
	  Start of section headers:          4496 (bytes into file)
	  Flags:                             0x0
	  Size of this header:               64 (bytes)
	  Size of program headers:           56 (bytes)
	  Number of program headers:         9
	  Size of section headers:           64 (bytes)
	  Number of section headers:         29
	  Section header string table index: 28

## 技巧

当调试没有调试信息的程序时，直接运行`start`命令是没有效果的：

	(gdb) start
	Function "main" not defined.

如果不知道main在何处，那么可以在程序入口处打断点。先通过`readelf`获得入口地址，然后：

	(gdb) b *0x400440
	(gdb) r

## 贡献者

xmj


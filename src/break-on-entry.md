# 在程序入口处打断点 

## 获取程序入口

### 方法一：

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

### 方法二：

    $ gdb a.out 
    >>> info files
    Symbols from "/home/me/a.out".
    Local exec file:
    	`/home/me/a.out', file type elf64-x86-64.
    	Entry point: 0x400440
    	0x0000000000400238 - 0x0000000000400254 is .interp
    	0x0000000000400254 - 0x0000000000400274 is .note.ABI-tag
    	0x0000000000400274 - 0x0000000000400298 is .note.gnu.build-id
    	0x0000000000400298 - 0x00000000004002b4 is .gnu.hash
    	0x00000000004002b8 - 0x0000000000400318 is .dynsym
    	0x0000000000400318 - 0x0000000000400355 is .dynstr
    	0x0000000000400356 - 0x000000000040035e is .gnu.version
    	0x0000000000400360 - 0x0000000000400380 is .gnu.version_r
    	0x0000000000400380 - 0x0000000000400398 is .rela.dyn
    	0x0000000000400398 - 0x00000000004003e0 is .rela.plt
    	0x00000000004003e0 - 0x00000000004003fa is .init
    	0x0000000000400400 - 0x0000000000400440 is .plt
    	0x0000000000400440 - 0x00000000004005c2 is .text
    	0x00000000004005c4 - 0x00000000004005cd is .fini
    	0x00000000004005d0 - 0x00000000004005e0 is .rodata
    	0x00000000004005e0 - 0x0000000000400614 is .eh_frame_hdr
    	0x0000000000400618 - 0x000000000040070c is .eh_frame
    	0x0000000000600e10 - 0x0000000000600e18 is .init_array
    	0x0000000000600e18 - 0x0000000000600e20 is .fini_array
    	0x0000000000600e20 - 0x0000000000600e28 is .jcr
    	0x0000000000600e28 - 0x0000000000600ff8 is .dynamic
    	0x0000000000600ff8 - 0x0000000000601000 is .got
    	0x0000000000601000 - 0x0000000000601030 is .got.plt
    	0x0000000000601030 - 0x0000000000601040 is .data
    	0x0000000000601040 - 0x0000000000601048 is .bss

## 技巧

当调试没有调试信息的程序时，直接运行`start`命令是没有效果的：

	(gdb) start
	Function "main" not defined.

如果不知道main在何处，那么可以在程序入口处打断点。先通过`readelf`或者进入gdb，执行`info files`获得入口地址，然后：

	(gdb) b *0x400440
	(gdb) r

## 贡献者

* xmj
* [weekface](https://github.com/weekface)

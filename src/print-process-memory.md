# 打印进程内存信息




## 技巧
用gdb调试程序时，如果想查看进程的内存映射信息，可以使用“i proc mappings”命令（i是info命令缩写），例如:  

	(gdb) i proc mappings
	process 27676 flags:
	PR_STOPPED Process (LWP) is stopped
	PR_ISTOP Stopped on an event of interest
	PR_RLC Run-on-last-close is in effect
	PR_MSACCT Microstate accounting enabled
	PR_PCOMPAT Micro-state accounting inherited on fork
	PR_FAULTED : Incurred a traced hardware fault FLTBPT: Breakpoint trap

	Mapped address spaces:

        Start Addr   End Addr       Size     Offset   Flags
         0x8046000  0x8047fff     0x2000 0xfffff000 -s--rwx
         0x8050000  0x8050fff     0x1000          0 ----r-x
         0x8060000  0x8060fff     0x1000          0 ----rwx
        0xfee40000 0xfef4efff   0x10f000          0 ----r-x
        0xfef50000 0xfef55fff     0x6000          0 ----rwx
        0xfef5f000 0xfef66fff     0x8000   0x10f000 ----rwx
        0xfef67000 0xfef68fff     0x2000          0 ----rwx
        0xfef70000 0xfef70fff     0x1000          0 ----rwx
        0xfef80000 0xfef80fff     0x1000          0 ---sr--
        0xfef90000 0xfef90fff     0x1000          0 ----rw-
        0xfefa0000 0xfefa0fff     0x1000          0 ----rw-
        0xfefb0000 0xfefb0fff     0x1000          0 ----rwx
        0xfefc0000 0xfefeafff    0x2b000          0 ----r-x
        0xfeff0000 0xfeff0fff     0x1000          0 ----rwx
        0xfeffb000 0xfeffcfff     0x2000    0x2b000 ----rwx
        0xfeffd000 0xfeffdfff     0x1000          0 ----rwx




首先输出了进程的flags，接着是进程的内存映射信息。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/SVR4-Process-Information.html#index-info-proc-exe).

此外，也可以用"i files"（还有一个同样作用的命令：“i target”）命令，它可以更详细地输出进程的内存信息，包括引用的动态链接库等等，例如：

	(gdb) i files
	Symbols from "/data1/nan/a".
	Unix /proc child process:
        Using the running image of child Thread 1 (LWP 1) via /proc.
        While running this, GDB does not access memory from...
	Local exec file:
        `/data1/nan/a', file type elf32-i386-sol2.
        Entry point: 0x8050950
        0x080500f4 - 0x08050105 is .interp
        0x08050108 - 0x08050114 is .eh_frame_hdr
        0x08050114 - 0x08050218 is .hash
        0x08050218 - 0x08050418 is .dynsym
        0x08050418 - 0x080507e6 is .dynstr
        0x080507e8 - 0x08050818 is .SUNW_version
        0x08050818 - 0x08050858 is .SUNW_versym
        0x08050858 - 0x08050890 is .SUNW_reloc
        0x08050890 - 0x080508c8 is .rel.plt
        0x080508c8 - 0x08050948 is .plt
        ......
		0xfef5fb58 - 0xfef5fc48 is .dynamic in /usr/lib/libc.so.1
        0xfef5fc80 - 0xfef650e2 is .data in /usr/lib/libc.so.1
        0xfef650e2 - 0xfef650e2 is .bssf in /usr/lib/libc.so.1
        0xfef650e8 - 0xfef65be0 is .picdata in /usr/lib/libc.so.1
        0xfef65be0 - 0xfef666a7 is .data1 in /usr/lib/libc.so.1
        0xfef666a8 - 0xfef680dc is .bss in /usr/lib/libc.so.1




参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Files.html)

## 贡献者

nanxiao


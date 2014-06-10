# 自动反汇编后面要执行的代码

## 例子
    (gdb) set disassemble-next-line on
    (gdb) start 
    The program being debugged has been started already.
    Start it from the beginning? (y or n) y
    Temporary breakpoint 3 at 0x400543: file 1.c, line 14.
    Starting program: /home/teawater/tmp/a.out 

    Temporary breakpoint 3, main (argc=1, argv=0x7fffffffdf38, envp=0x7fffffffdf48) at 1.c:14
    14      printf("1\n");
    => 0x0000000000400543 <main+19>:    bf f0 05 40 00  mov    $0x4005f0,%edi
       0x0000000000400548 <main+24>:    e8 c3 fe ff ff  callq  0x400410 <puts@plt>
    (gdb) si
    0x0000000000400548  14      printf("1\n");
    0x0000000000400543 <main+19>:    bf f0 05 40 00  mov    $0x4005f0,%edi
    => 0x0000000000400548 <main+24>:    e8 c3 fe ff ff  callq  0x400410 <puts@plt>
    (gdb) 
    0x0000000000400410 in puts@plt ()
    => 0x0000000000400410 <puts@plt+0>: ff 25 02 0c 20 00   jmpq   *0x200c02(%rip)        # 0x601018 <puts@got.plt>

    (gdb) set disassemble-next-line auto 
    (gdb) start 
    Temporary breakpoint 1 at 0x400543: file 1.c, line 14.
    Starting program: /home/teawater/tmp/a.out 

    Temporary breakpoint 1, main (argc=1, argv=0x7fffffffdf38, envp=0x7fffffffdf48) at 1.c:14
    14      printf("1\n");
    (gdb) si
    0x0000000000400548  14      printf("1\n");
    (gdb) 
    0x0000000000400410 in puts@plt ()
    => 0x0000000000400410 <puts@plt+0>: ff 25 02 0c 20 00   jmpq   *0x200c02(%rip)        # 0x601018 <puts@got.plt>
    (gdb) 
    0x0000000000400416 in puts@plt ()
    => 0x0000000000400416 <puts@plt+6>: 68 00 00 00 00  pushq  $0x0

## 技巧

如果要在任意情况下反汇编后面要执行的代码：

    (gdb) set disassemble-next-line on

如果要在后面的代码没有源码的情况下才反汇编后面要执行的代码：

    (gdb) set disassemble-next-line auto

关闭这个功能：

    (gdb) set disassemble-next-line off

## 贡献者

teawater
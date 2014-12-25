# 显示寄存器窗口
## 例子
	#include <stdio.h>
	
	void fun1(void)
	{
	        int i = 0;
	
	        i++;
	        i = i * 2;
	        printf("%d\n", i);
	}
	
	void fun2(void)
	{
	        int j = 0;
	
	        fun1();
	        j++;
	        j = j * 2;
	        printf("%d\n", j);
	}
	
	int main(void)
	{
	        fun2();
	        return 0;
	}


## 技巧
使用gdb图形化调试界面时，可以使用“`layout regs`”命令显示寄存器窗口。以调试上面程序为例：  

	┌──Register group: general─────────────────────────────────────────────────────────────────────────┐
	│rax            0x34e4590f60     227169341280     rbx            0x0      0                        │
	│rcx            0x0      0                        rdx            0x7fffffffe4b8   140737488348344  │
	│rsi            0x7fffffffe4a8   140737488348328  rdi            0x1      1                        │
	│rbp            0x7fffffffe3c0   0x7fffffffe3c0   rsp            0x7fffffffe3c0   0x7fffffffe3c0   │
	│r8             0x34e458f300     227169334016     r9             0x34e3a0e9f0     227157273072     │
	│r10            0x7fffffffe210   140737488347664  r11            0x34e421ec20     227165727776     │
	│r12            0x4003e0 4195296                  r13            0x7fffffffe4a0   140737488348320  │
	└──────────────────────────────────────────────────────────────────────────────────────────────────┘
	   │17              j++;                                                                           │
	   │18              j = j * 2;                                                                     │
	   │19              printf("%d\n", j);                                                             │
	   │20      }                                                                                      │
	   │21                                                                                             │
	   │22      int main(void)                                                                         │
	   │23      {                                                                                      │
	  >│24              fun2();                                                                        │
	   └───────────────────────────────────────────────────────────────────────────────────────────────┘
	native process 12552 In: main                                               Line: 24   PC: 0x40052b
	Reading symbols from a...done.
	(gdb) start
	Temporary breakpoint 1 at 0x40052b: file a.c, line 24.
	Starting program: /home/nan/a
	
	Temporary breakpoint 1, main () at a.c:24
	(gdb)

可以看到，显示了通用寄存器的内容。  
如果想查看浮点寄存器，可以使用“`tui reg float`”命令：  

	┌──Register group: float───────────────────────────────────────────────────────────────────────────┐
	│st0            0        (raw 0x00000000000000000000)                                              │
	│st1            0        (raw 0x00000000000000000000)                                              │
	│st2            0        (raw 0x00000000000000000000)                                              │
	│st3            0        (raw 0x00000000000000000000)                                              │
	│st4            0        (raw 0x00000000000000000000)                                              │
	│st5            0        (raw 0x00000000000000000000)                                              │
	│st6            0        (raw 0x00000000000000000000)                                              │
	└──────────────────────────────────────────────────────────────────────────────────────────────────┘
	   │16              fun1();                                                                        │
	   │17              j++;                                                                           │
	   │18              j = j * 2;                                                                     │
	   │19              printf("%d\n", j);                                                             │
	   │20      }                                                                                      │
	   │21                                                                                             │
	   │22      int main(void)                                                                         │
	   │23      {                                                                                      │
	   └───────────────────────────────────────────────────────────────────────────────────────────────┘
	native process 12552 In: main                                               Line: 24   PC: 0x40052b
	Temporary breakpoint 1 at 0x40052b: file a.c, line 24.
	Starting program: /home/nan/a
	
	Temporary breakpoint 1, main () at a.c:24
	(gdb) tui reg float

“`tui reg system`”命令显示系统寄存器：  

	┌──Register group: system──────────────────────────────────────────────────────────────────────────┐
	│orig_rax       0xffffffffffffffff       -1                                                        │
	│                                                                                                  │
	│                                                                                                  │
	│                                                                                                  │
	│                                                                                                  │
	│                                                                                                  │
	│                                                                                                  │
	└──────────────────────────────────────────────────────────────────────────────────────────────────┘
	   │16              fun1();                                                                        │
	   │17              j++;                                                                           │
	   │18              j = j * 2;                                                                     │
	   │19              printf("%d\n", j);                                                             │
	   │20      }                                                                                      │
	   │21                                                                                             │
	   │22      int main(void)                                                                         │
	   │23      {                                                                                      │
	   └───────────────────────────────────────────────────────────────────────────────────────────────┘
	native process 12552 In: main                                               Line: 24   PC: 0x40052b
	
	Temporary breakpoint 1, main () at a.c:24
	(gdb) tui reg system
	(gdb)
想切换回显示通用寄存器内容，可以使用“`tui reg general`”命令：  

	┌──Register group: general─────────────────────────────────────────────────────────────────────────┐
	│rax            0x34e4590f60     227169341280     rbx            0x0      0                        │
	│rcx            0x0      0                        rdx            0x7fffffffe4b8   140737488348344  │
	│rsi            0x7fffffffe4a8   140737488348328  rdi            0x1      1                        │
	│rbp            0x7fffffffe3c0   0x7fffffffe3c0   rsp            0x7fffffffe3c0   0x7fffffffe3c0   │
	│r8             0x34e458f300     227169334016     r9             0x34e3a0e9f0     227157273072     │
	│r10            0x7fffffffe210   140737488347664  r11            0x34e421ec20     227165727776     │
	│r12            0x4003e0 4195296                  r13            0x7fffffffe4a0   140737488348320  │
	└──────────────────────────────────────────────────────────────────────────────────────────────────┘
	   │16              fun1();                                                                        │
	   │17              j++;                                                                           │
	   │18              j = j * 2;                                                                     │
	   │19              printf("%d\n", j);                                                             │
	   │20      }                                                                                      │
	   │21                                                                                             │
	   │22      int main(void)                                                                         │
	   │23      {                                                                                      │
	   └───────────────────────────────────────────────────────────────────────────────────────────────┘
	native process 12552 In: main                                               Line: 24   PC: 0x40052b
	(gdb) tui reg general
	(gdb)
  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/TUI-Commands.html).

## 贡献者

nanxiao

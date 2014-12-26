# 调整窗口大小
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
使用gdb图形化调试界面时，可以使用“`winheight  <win_name> [+ | -]count`”命令调整窗口大小（`winheight`缩写为`win`。`win_name`可以是`src`、`cmd`、`asm`和`regs`）。以调试上面程序为例，这是原始的`src`窗口大小：  

	   ┌──a.c──────────────────────────────────────────────────────────────────────────────────────────┐
	   │17              j++;                                                                           │
	   │18              j = j * 2;                                                                     │
	   │19              printf("%d\n", j);                                                             │
	   │20      }                                                                                      │
	   │21      int main(void)                                                                        22
	   │23      {                                                                                      │
	   │24              fun2();                                                                        │
	B+>│25                                                                                             │
	   │                return 0;                                                                      │
	   │26      }                                                                                      │
	   │27                                                                                            32
	   │                                                                                               │
	   │                                                                                               │
	   │                                                                                               │
	   │                                                                                               │
	   │                                                                                               │
	   └───────────────────────────────────────────────────────────────────────────────────────────────┘
	native process 9667 In: main                                                Line: 24   PC: 0x40052b
	Usage: winheight <win_name> [+ | -] <#lines>
	(gdb) start
	Temporary breakpoint 1 at 0x40052b: file a.c, line 24.
	Starting program: /home/nan/a
	
	Temporary breakpoint 1, main () at a.c:24

执行“`winheight src -5`”命令后：

	   ┌──a.c──────────────────────────────────────────────────────────────────────────────────────────┐
	   │17              j++;                                                                           │
	   │18              j = j * 2;                                                                     │
	   │19              printf("%d\n", j);                                                             │
	   │20      }                                                                                      │
	   │21                                                                                             │
	   │22      int main(void)                                                                         │
	   │23      {                                                                                      │
	  >│24              fun2();                                                                        │
	   │25              return 0;                                                                      │
	   │26      }                                                                                      │
	   │27                                                                                             │
	   └───────────────────────────────────────────────────────────────────────────────────────────────┘
	native process 9667 In: main                                               Line: 24   PC: 0x40052b
	Usage: winheight <win_name> [+ | -] <#lines>
	(gdb)
可以看到窗口变小了。  
接着执行“`winheight src +5`”命令：  

	   ┌──a.c──────────────────────────────────────────────────────────────────────────────────────────┐
	   │17              j++;                                                                           │
	   │18              j = j * 2;                                                                     │
	   │19              printf("%d\n", j);                                                             │
	   │20      }                                                                                      │
	   │21                                                                                             │
	   │22      int main(void)                                                                         │
	   │23      {                                                                                      │
	  >│24              fun2();                                                                        │
	   │25              return 0;                                                                      │
	   │26      }                                                                                      │
	   │27                                                                                             │
	   │28                                                                                             │
	   │29                                                                                             │
	   │30                                                                                             │
	   │31                                                                                             │
	   │32                                                                                             │
	   └───────────────────────────────────────────────────────────────────────────────────────────────┘
	native process 9667 In: main                                               Line: 24   PC: 0x40052b
	Usage: winheight <win_name> [+ | -] <#lines>
	(gdb)
可以看到窗口恢复了原样。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/TUI-Commands.html).

## 贡献者

nanxiao

# 打印程序动态分配内存的信息
## 例子
	#include <stdio.h>
	#include <malloc.h>
	
	int main(void)
	{
	        char *p[10];
	        int i = 0;
	
	        for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	        {
	                p[i] = malloc(100000);
	        }
	        return 0;
	}

## 技巧
用gdb调试程序时，可以用下面的自定义命令，打印程序动态分配内存的信息：  

    define mallocinfo
      set $__f = fopen("/dev/tty", "w")
      call malloc_info(0, $__f)
      call fclose($__f)
    end

以上面程序为例：  

    Temporary breakpoint 5, main () at a.c:7
	7               int i = 0;
	(gdb) mallocinfo 
	<malloc version="1">
	<heap nr="0">
	<sizes>
	</sizes>
	<total type="fast" count="0" size="0"/>
	<total type="rest" count="0" size="0"/>
	<system type="current" size="135168"/>
	<system type="max" size="135168"/>
	<aspace type="total" size="135168"/>
	<aspace type="mprotect" size="135168"/>
	</heap>
	<total type="fast" count="0" size="0"/>
	<total type="rest" count="0" size="0"/>
	<system type="current" size="135168"/>
	<system type="max" size="135168"/>
	<aspace type="total" size="135168"/>
	<aspace type="mprotect" size="135168"/>
	</malloc>
	$20 = 0
	$21 = 0
	(gdb) n
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) mallocinfo 
	<malloc version="1">
	<heap nr="0">
	<sizes>
	</sizes>
	<total type="fast" count="0" size="0"/>
	<total type="rest" count="0" size="0"/>
	<system type="current" size="532480"/>
	<system type="max" size="532480"/>
	<aspace type="total" size="532480"/>
	<aspace type="mprotect" size="532480"/>
	</heap>
	<total type="fast" count="0" size="0"/>
	<total type="rest" count="0" size="0"/>
	<system type="current" size="532480"/>
	<system type="max" size="532480"/>
	<aspace type="total" size="532480"/>
	<aspace type="mprotect" size="532480"/>
	</malloc>
	$22 = 0
	$23 = 0
	(gdb) n
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) 
	11                      p[i] = malloc(100000);
	(gdb) 
	9               for (i = 0; i < sizeof(p)/sizeof(p[0]); i++)
	(gdb) mallocinfo 
	<malloc version="1">
	<heap nr="0">
	<sizes>
	</sizes>
	<total type="fast" count="0" size="0"/>
	<total type="rest" count="0" size="0"/>
	<system type="current" size="1134592"/>
	<system type="max" size="1134592"/>
	<aspace type="total" size="1134592"/>
	<aspace type="mprotect" size="1134592"/>
	</heap>
	<total type="fast" count="0" size="0"/>
	<total type="rest" count="0" size="0"/>
	<system type="current" size="1134592"/>
	<system type="max" size="1134592"/>
	<aspace type="total" size="1134592"/>
	<aspace type="mprotect" size="1134592"/>
	</malloc>
	$24 = 0
	$25 = 0

可以看到gdb输出了动态分配内存的变化信息。   
参见[stackoverflow](http://stackoverflow.com/questions/1471226/most-tricky-useful-commands-for-gdb-debugger).

## 贡献者

nanxiao

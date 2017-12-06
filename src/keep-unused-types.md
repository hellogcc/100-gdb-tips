# 保留未使用的类型

## 例子

	#include <stdio.h>
	
	union Type {
	  int a;
	  int *b;
	};
	
	int main()
	{
	  printf("sizeof(union Type) is %lu\n", sizeof(union Type));
	  return 0;
	}

## 技巧

使用`gcc -g`编译生成的程序，是不包含union Type的符号信息：

	(gdb) p sizeof(union Type)
	No union type named Type.

如果想让gcc保留这些没有被使用的类型信息（猜测应该是sizeof在编译时即被替换成常数，所以gcc认为union Type是未使用的类型），则可以使用`gcc -g -fno-eliminate-unused-debug-types`进行编译：

	(gdb) p sizeof(union Type)
	$1 = 8

参见[gcc手册](https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html#Debugging-Options)

## 贡献者

xmj


# 打印变量的类型和所在文件 

## 例子

	#include <stdio.h>
	
	struct child {
	  char name[10];
	  enum { boy, girl } gender;
	};
	
	struct child he = { "Tom", boy };
	
	int main (void)
	{
	  static struct child she = { "Jerry", girl };
	  printf ("Hello %s %s.\n", he.gender == boy ? "boy" : "girl", he.name);
	  printf ("Hello %s %s.\n", she.gender == boy ? "boy" : "girl", she.name);
	  return 0;
	}

## 技巧

在gdb中，可以使用如下命令查看变量的类型：

	(gdb) whatis he
	type = struct child

如果想查看详细的类型信息：

	(gdb) ptype he
	type = struct child {
	    char name[10];
	    enum {boy, girl} gender;
	}

如果想查看定义该变量的文件：

	(gdb) i variables he
	All variables matching regular expression "he":
	
	File variable.c:
	struct child he;
	
	Non-debugging symbols:
	0x0000000000402030  she
	0x00007ffff7dd3380  __check_rhosts_file

哦，gdb会显示所有包含（匹配）该表达式的变量。如果只想查看完全匹配给定名字的变量：

	(gdb) i variables ^he$
	All variables matching regular expression "^he$":
	
	File variable.c:
	struct child he;

注：`info variables`不会显示局部变量，即使是static的也没有太多的信息。

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Symbols.html)

## 贡献者

xmj


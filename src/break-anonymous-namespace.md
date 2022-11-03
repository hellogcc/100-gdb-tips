# 在匿名空间设置断点

## 例子
	namespace Foo
	{
	  void foo()
	  {
	  }
	}

	namespace
	{
	  void bar()
	  {
	  }
	}

## 技巧

可以先使用查看所有函数信息，这样便于理解，使用如下命令：

	(gdb) info functions                                                                                                                   
	All defined functions:                                                                                                                 

	File test.cpp:
	3:      void Foo::foo();
	10:     static void (anonymous namespace)::bar();

在gdb中，如果要对namespace Foo中的foo函数设置断点，可以使用如下命令：

	(gdb) b Foo::foo

如果要对匿名空间中的bar函数设置断点，可以使用如下命令：

	(gdb) b (anonymous namespace)::bar

## 贡献者

xmj, Franklin-Qi


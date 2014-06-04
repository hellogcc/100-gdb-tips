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

在gdb中，如果要对namespace Foo中的foo函数设置断点，可以使用如下命令：

	(gdb) b Foo::foo

如果要对匿名空间中的bar函数设置断点，可以使用如下命令：

	(gdb) b (anonymous namespace)::bar

## 贡献者

xmj


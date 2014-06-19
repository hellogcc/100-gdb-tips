# 配置gdb init文件 

## 技巧

当gdb启动时，会读取HOME目录和当前目录下的的配置文件，执行里面的命令。这个文件通常为“.gdbinit”。

这里给出了本文档中介绍过的，可以放在“.gdbinit”中的一些配置：

	# 打印STL容器中的内容
	python
	import sys
	sys.path.insert(0, "/home/xmj/project/gcc-trunk/libstdc++-v3/python")
	from libstdcxx.v6.printers import register_libstdcxx_printers
	register_libstdcxx_printers (None)
	end
	
	# 保存历史命令
	set history filename ~/.gdb_history
	set history save on
	
	# 退出时不显示提示信息
	set confirm off
	
	# 按照派生类型打印对象
	set print object on
	
	# 打印数组的索引下标
	set print array-indexes on
	
	# 每行打印一个结构体成员
	set print pretty on

欢迎补充。

## 贡献者

xmj


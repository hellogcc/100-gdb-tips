# 打印STL容器中的内容 

## 例子

	#include <iostream>
	#include <vector>
	
	using namespace std;
	
	int main ()
	{
	  vector<int> vec(10); // 10 zero-initialized elements
	
	  for (int i = 0; i < vec.size(); i++)
	    vec[i] = i;
	
	  cout << "vec contains:";
	  for (int i = 0; i < vec.size(); i++)
	    cout << ' ' << vec[i];
	  cout << '\n';
	
	  return 0;
	}

## 技巧一

在gdb中，如果要打印C++ STL容器的内容，缺省的显示结果可读性很差：

	(gdb) p vec
	$1 = {<std::_Vector_base<int, std::allocator<int> >> = {
	    _M_impl = {<std::allocator<int>> = {<__gnu_cxx::new_allocator<int>> = {<No data fields>}, <No data fields>}, _M_start = 0x404010, _M_finish = 0x404038, 
              _M_end_of_storage = 0x404038}}, <No data fields>}

gdb 7.0之后，可以使用gcc提供的python脚本，来改善显示结果：

	(gdb) p vec
	$1 = std::vector of length 10, capacity 10 = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}

方法如下:

1. 获得最新的python脚本

		svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python

2. 将如下代码添加到.gdbinit文件中（假设python脚本位于 /home/maude/gdb_printers/ 下）

		python
		import sys
		sys.path.insert(0, '/home/maude/gdb_printers/python')
		from libstdcxx.v6.printers import register_libstdcxx_printers
		register_libstdcxx_printers (None)
		end

## 技巧二

`p vec`的输出无法阅读，但能给我们提示，从而得到无需脚本支持的本技巧：

  (gdb) p *(vec._M_impl._M_start)@vec.size()
  $2 = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}

## 贡献者

xmj（源自https://sourceware.org/gdb/wiki/STLSupport）
xanpeng



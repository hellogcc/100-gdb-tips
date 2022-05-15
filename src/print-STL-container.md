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

某些发行版(Fedora 11+)，不需要额外的设置工作。可在gdb命令行下验证（若没有显示，可按下文的方法进行设置）。

		(gdb) info pretty-printer

方法如下:

1. 获得python脚本，建议使用gcc默认安装的

		sudo find / -name "*libstdcxx*"
2. 若本机查找不到python脚本，建议下载gcc对应版本源码包

    gcc git 仓库地址：https://github.com/gcc-mirror/gcc

    python 脚本位于 libstdc++-v3/python 目录下
3. 将如下代码添加到.gdbinit文件中（假设python脚本位于 /home/maude/gdb_printers/ 下）

		python
		import sys
		sys.path.insert(0, '/home/maude/gdb_printers/python')
		from libstdcxx.v6.printers import register_libstdcxx_printers
		register_libstdcxx_printers (None)
		end

（源自https://sourceware.org/gdb/wiki/STLSupport）

## 技巧二

`p vec`的输出无法阅读，但能给我们提示，从而得到无需脚本支持的技巧：

	(gdb) p *(vec._M_impl._M_start)@vec.size()
	$2 = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
	
## 技巧三

将 [dbinit_stl_views](http://www.yolinux.com/TUTORIALS/src/dbinit_stl_views-1.03.txt ) 下载下来,，执行命令
```shell
cat dbinit_stl_views-1.03.txt >> ~/.gdbinit
```
即可
一些常用的容器及其对应的命令关系
```shell
std::vector<T>  pvector stl_variable 
std::list<T>  plist stl_variable T 
std::map<T,T>  pmap stl_variable 
std::multimap<T,T>  pmap stl_variable 
std::set<T>  pset stl_variable T 
std::multiset<T>  pset stl_variable 
std::deque<T>  pdequeue stl_variable 
std::stack<T>  pstack stl_variable 
std::queue<T>  pqueue stl_variable 
std::priority_queue<T>  ppqueue stl_variable 
std::bitset<n><td>  pbitset stl_variable 
std::string  pstring stl_variable 
std::widestring  pwstring stl_variable  
```
更多详情，参考配置中的帮助


## 贡献者

xmj

xanpeng

enjolras

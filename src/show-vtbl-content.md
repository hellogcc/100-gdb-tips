# 显示C++ vtable以及相应的内容

## 例子
	#include <iostream>
 
        struct Base {
          virtual void f(){
            std::cout << "base\n";
          }
        };
 
        struct Derived : Base {
          void f() override // 'override' is optional
          {
            std::cout << "derived\n";
          }
        };
 
        int main() {
          Base b;
          Derived d;
 
          // virtual function call through reference
          Base& br = b; // the type of br is Base&
          Base& dr = d; // the type of dr is Base& as well
        }

## 技巧
  为了观察一个对象的虚表和相应虚表的内容，可以在启动gdb后设置如下命令
  `set print asm-demangle on`
  `set print demangle on`
  已下面程序为例子
    
     (gdb) l
	    int main() {
	    Base b;
	    Derived d;

	    // virtual function call through reference
	    Base& br = b; // the type of br is Base&
	    Base& dr = d; // the type of dr is Base& as well
    (gdb) n
    	The program is not being run.
    (gdb) r
    	Starting program: /home/qinliansong/pblearn/main
    	[Thread debugging using libthread_db enabled]
    	Using host libthread_db library "/lib64/libthread_db.so.1".

	Breakpoint 1, main () at main.cc:21
	    Base b;
	Missing separate debuginfos, use: debuginfo-install libgcc-4.8.5-39.el7.x86_64 libstdc++-4.8.5-39.el7.x86_64
    (gdb) n
	    Derived d;
    (gdb) n
	    Base& br = b; // the type of br is Base&
  
  此时设置如下两个命令，几个命令，更友好的观察vtbl
  
  `set print vtbl on`
  `set print object on`
  `set print pretty on`
  
    (gdb) set print vtbl on
    (gdb) p d
	$1 = {<Base> = {_vptr.Base = 0x4009c0 <vtable for Derived+16>}, <No data fields>}
    (gdb) set print object on
    (gdb) set print pretty on
    (gdb) p d
	$2 = (Derived) {
  		<Base> = {
   		 _vptr.Base = 0x4009c0 <vtable for Derived+16>
  	}, <No data fields>}

  通过`info vtbl [expr]`观察对象的虚函数
   
    (gdb) info vtbl d
    	vtable for 'Derived' @ 0x4009c0 (subobject @ 0x7fffffffde00):
	    [0]: 0x4008f2 <Derived::f()>

    (gdb) set print demangle on
    (gdb) set print asm-demangle on
    (gdb) x/28x 0x4009c0
    	0x4009c0 <vtable for Derived+16>:	0x004008f2	0x00000000	0x00000000	0x00000000
	    0x4009d0 <vtable for Base+8>:	0x00400a08	0x00000000	0x004008d4	0x00000000
    	0x4009e0 <typeinfo for Derived>:	0x00600d90	0x00000000	0x004009f8	0x00000000
    	0x4009f0 <typeinfo for Derived+16>:	0x00400a08	0x00000000	0x72654437	0x64657669
    	0x400a00 <typeinfo name for Derived+8>:	0x00000000	0x00000000	0x00600d30	0x00000000
	    0x400a10 <typeinfo for Base+8>:	0x00400a18	0x00000000	0x73614234	0x00000065
	    0x400a20:	0x3b031b01	0x00000054	0x00000009	0xfffffc80


    (gdb) info variables vtable for Derived
	    All variables matching regular expression "vtable for Derived":

	    Non-debugging symbols:
    	0x00000000004009b0  vtable for Derived
    (gdb) x /4a 0x00000000004009b0
	    0x4009b0 <vtable for Derived>:	0x0	0x4009e0 <typeinfo for Derived>
	    0x4009c0 <vtable for Derived+16>:	0x4008f2 <Derived::f()>	0x0
    (gdb) x /10a 0x4009c0
    	0x4009c0 <vtable for Derived+16>:	0x4008f2 <Derived::f()>	0x0
	    0x4009d0 <vtable for Base+8>:	0x400a08 <typeinfo for Base>	0x4008d4 <Base::f()>
	    0x4009e0 <typeinfo for Derived>:	0x600d90 <vtable for __cxxabiv1::__si_class_type_info@@CXXABI_1.3+16>	0x4009f8 <typeinfo name for Derived>
	    0x4009f0 <typeinfo for Derived+16>:	0x400a08 <typeinfo for Base>	0x6465766972654437
	    0x400a00 <typeinfo name for Derived+8>:	0x0	0x600d30 <vtable for __cxxabiv1::__class_type_info@@CXXABI_1.3+16>

## 参考
  [gdb手册](https://docs.adacore.com/live/wave/gdb-10/html/gdb/gdb.html)
  [vtable-part1](https://shaharmike.com/cpp/vtable-part1/)
  
## 贡献者

qls152
# 按照派生类型打印对象

## 例子

	#include <iostream>
	using namespace std;
	
	class Shape {
	 public:
	  virtual void draw () {}
	};
	
	class Circle : public Shape {
	 int radius;
	 public:
	  Circle () { radius = 1; }
	  void draw () { cout << "drawing a circle...\n"; }
	};
	
	class Square : public Shape {
	 int height;
	 public:
	  Square () { height = 2; }
	  void draw () { cout << "drawing a square...\n"; }
	};
	
	void drawShape (class Shape &p)
	{
	  p.draw ();
	}
	
	int main (void)
	{
	  Circle a;
	  Square b;
	  drawShape (a);
	  drawShape (b);
	  return 0;
	}

## 技巧

在gdb中，当打印一个对象时，缺省是按照声明的类型进行打印：

	(gdb) frame
	#0  drawShape (p=...) at object.cxx:25
	25	  p.draw ();
	(gdb) p p
	$1 = (Shape &) @0x7fffffffde90: {_vptr.Shape = 0x400a80 <vtable for Circle+16>}

在这个例子中，p虽然声明为class Shape，但它实际的派生类型可能为class Circle和Square。如果要缺省按照派生类型进行打印，则可以通过如下命令进行设置：

	(gdb) set print object on

	(gdb) p p
	$2 = (Circle &) @0x7fffffffde90: {<Shape> = {_vptr.Shape = 0x400a80 <vtable for Circle+16>}, radius = 1}

当打印对象类型信息时，该设置也会起作用：

	(gdb) whatis p
	type = Shape &
	(gdb) ptype p
	type = class Shape {
	  public:
	    virtual void draw(void);
	} &

	(gdb) set print object on
	(gdb) whatis p
	type = /* real type = Circle & */
	Shape &
	(gdb) ptype p
	type = /* real type = Circle & */
	class Shape {
	  public:
	    virtual void draw(void);
	} &

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Print-Settings.html#index-set-print)

## 贡献者

xmj

xanpeng


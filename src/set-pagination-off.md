# 输出信息多时不会暂停输出

## 技巧
有时当gdb输出信息较多时，gdb会暂停输出，并会打印“`---Type <return> to continue, or q <return> to quit---`”这样的提示信息，如下面所示：  

	 81 process 2639102      0xff04af84 in __lwp_park () from /usr/lib/libc.so.1
	 80 process 2573566      0xff04af84 in __lwp_park () from /usr/lib/libc.so.1
	---Type <return> to continue, or q <return> to quit---Quit



解决办法是使用“`set pagination off`”或者“`set height 0`”命令。这样gdb就会全部输出，中间不会暂停。  
参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/Screen-Size.html).

## 贡献者

nanxiao

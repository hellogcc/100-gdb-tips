# gdb退出时不显示提示信息


## 技巧
gdb在退出时会提示:  

	A debugging session is active.

        Inferior 1 [process 29686    ] will be killed.

    Quit anyway? (y or n) n


如果不想显示这个信息，则可以在gdb中使用如下命令把提示信息关掉:

	(gdb) set confirm off

也可以把这个命令加到.gdbinit文件里。

## 贡献者

nanxiao


# 信息显示
* [显示gdb版本信息](show-version.md)
* [显示gdb版权相关信息](show-copying-warranty.md)
* [启动时不显示提示信息](start-gdb-silently.md)
* [退出时不显示提示信息](quit-gdb-silently.md)

# 变量
* [设置变量的值](set-var.md)

# 函数
* [列出函数的名字](info-function.md)
* [是否进入带调试信息的函数](step-and-next-function.md)
* [进入不带调试信息的函数](set-step-mode-on.md)
* [退出正在调试的函数](finish-and-return.md)

# 断点/观察点
* [在匿名空间设置断点](break-anonymous-namespace.md)
* [在程序地址上打断点](break-on-address.md)
* [在程序入口处打断点](break-on-entry.md)
* [在文件行号上打断点](break-on-linenum.md)
* [保存已经设置的断点](save-breakpoints.md)
* [设置临时断点](set-tbreak.md)
* [设置条件断点](set-condition-break.md)
* [忽略断点](ignore-break.md)
* [设置观察点](set-watchpoint.md)
* [设置观察点只针对特定线程生效](set-watchpoint-on-specified-thread.md)

# 打印
* [打印STL容器中的内容](print-STL-container.md)
* [打印大数组中的内容](print-large-array.md)
* [打印数组中任意连续元素值](print-consecutive-array-elements.md)
* [打印数组的索引下标](print-array-indexes.md)
* [打印函数局部变量的值](print-local-variables.md)
* [打印进程内存信息](print-process-memory.md)
* [打印静态变量的值](print-static-variables.md)
* [打印变量的类型和所在文件](print-variable-info.md)
* [每行打印一个结构体成员](set-print-pretty-on.md)
* [按照派生类型打印对象](print-derived-type.md)
* [指定程序的输入输出设备](set-io-tty.md)

# 多进程/线程
* [调试已经运行的进程](attach-process.md)
* [调试子进程](set-follow-fork-mode-child.md)
* [同时调试父进程和子进程](set-detach-on-fork.md)
* [查看线程信息](print-threads.md)
* [在Solaris上使用maintenance命令查看线程信息](maint-info-sol-threads.md)
* [不显示线程启动和退出信息](show-print-thread-events.md)
* [只允许一个线程运行](set-scheduler-locking-on.md)

# core dump文件
* [为调试进程产生core dump文件](generate-core-dump-file.md)
* [加载可执行程序和core dump文件](load-executable-and-coredump-file.md)

# 汇编
* [设置汇编指令格式](set-disassembly-flavor.md)
* [在函数的第一条汇编指令打断点](break-on-first-assembly-code.md)
* [自动反汇编后面要执行的代码](disassemble-next-line.md)
* [将源程序和汇编指令映射起来](map-source-code-and-assembly.md)
* [打印寄存器的值](print-registers.md)

# 改变程序的执行
* [跳转到指定位置执行](jump.md)
* [修改被调试程序的二进制文件](patch-program.md)
* [修改PC寄存器的值](modify-pc-register.md)

# 脚本
* [配置gdb init文件](config-gdbinit.md)
* [按何种方式解析脚本文件](set-script-extension.md)
* [保存历史命令](save-history-commands.md)

# 其它
* [命令行选项的格式](option-format.md)
* [支持预处理器宏信息](preprocessor-macro.md)
* [使用命令的缩写形式](use-short-command.md)
* [在gdb中执行shell命令和make](run-shell-command.md)
* [在gdb中执行cd和pwd命令](run-cd-pwd.md)
* [设置命令提示符](set-prompt.md)
* [设置被调试程序的参数](set-program-args.md)
* [设置被调试程序的环境变量](set-program-env.md)


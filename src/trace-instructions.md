# 从起始地址（$start_pc）跟踪指令至结束地址（$end_pc），并将输出保存在 'gdb.txt' 文件中

```
# set tracing points
set $start_pc=<trace-from-address>
set $end_pc=<trace-to-address>

# disable pagination
set pagination off

# log output to gdb.txt file instead of standard output
set logging on
set logging redirect on

# Warning: 'set logging on', an alias for the command 'set logging enabled', is deprecated. Use 'set logging enabled on'.

# run until $start_pc address hit
tbreak *$start_pc
run

# for each breakpoint hit print the instruction
display/i $pc
while $while_true
  si
  if $pc == $end_pc
    printf "Breakpoint reached\n"
    set $while_true=0
  end
end
```


## 贡献者

tin-z

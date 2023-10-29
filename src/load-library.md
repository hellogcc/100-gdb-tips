# 将库加载到被调试进程的内存空间中

```
################################################
# init
target remote 127.0.0.1:12345
set solib-search-path <path-to-local-replica-of-remote-library-target>

b main
c

### task: load a library inside the debuggee process memory space
# e.g. load 'libpino.so' and use its function 'ciao_pino' to retrieve the base address
call (void *) dlopen("libpino.so", 0)
set $handle=$1
call (void *) dlsym($handle, "ciao_pino")

# save base address where library was loaded by the loader
set $offset_ciao_pino=0x111
set $base_addr_libpino=$2 - $offset_ciao_pino

# save ciao_pino's return value
call (int) ciao_pino(1)
set $return_value=$3
```

详情参见[load_library_inject.gdb](https://github.com/tin-z/IoT_toolbox/blob/main/gdb/load_library_inject.gdb)

## 贡献者

tin-z

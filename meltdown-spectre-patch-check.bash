grep CONFIG_PAGE_TABLE_ISOLATION=y /boot/config-`uname -r` && echo "patched :)" || echo "unpatched :("
grep cpu_insecure /proc/cpuinfo && echo "patched :)" || echo "unpatched :("
dmesg | grep "Kernel/User page tables isolation: enabled" && echo "patched :)" || echo "unpatched :("

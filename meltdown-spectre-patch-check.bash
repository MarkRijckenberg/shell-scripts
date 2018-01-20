# Latest revision date: January 20, 2018:
sudo apt update
sudo apt install git wget xterm iucode-tool intel-microcode
/usr/sbin/iucode_tool -tb -lS /lib/firmware/intel-ucode/*

read -rsp $'Press any key to continue...\n' -n1 key

cd
rm -rf spectre-meltdown-checker
git clone https://github.com/speed47/spectre-meltdown-checker.git
cd spectre-meltdown-checker
chmod +x spectre-meltdown-checker.sh
sudo ./spectre-meltdown-checker.sh

read -rsp $'Press any key to continue...\n' -n1 key

grep CONFIG_PAGE_TABLE_ISOLATION=y /boot/config-`uname -r` && echo "CONFIG_PAGE_TABLE_ISOLATION patched :)" || echo "CONFIG_PAGE_TABLE_ISOLATION unpatched :("
grep cpu_insecure /proc/cpuinfo && echo "cpu_insecure /proc/cpuinfo -> patched :)" || echo "cpu_insecure /proc/cpuinfo -> unpatched :("
sudo dmesg | grep "Kernel/User page tables isolation: enabled" && echo "Kernel/User page tables isolation -> patched :)" || echo "Kernel/User page tables isolation -> unpatched :("
uname -a

read -rsp $'Press any key to continue...\n' -n1 key

#added on January 18, 2018:
cd
rm -rf Spectre-Meltdown-Checker-Automated
git clone https://github.com/linuxlite/Spectre-Meltdown-Checker-Automated
cd Spectre-Meltdown-Checker-Automated
chmod +x sm-*
./sm-start

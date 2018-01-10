#sudo apt update
#sudo apt install git
cd
rm -rf spectre-meltdown-checker
git clone https://github.com/speed47/spectre-meltdown-checker.git
cd spectre-meltdown-checker
chmod +x spectre-meltdown-checker.sh
sudo ./spectre-meltdown-checker.sh

grep CONFIG_PAGE_TABLE_ISOLATION=y /boot/config-`uname -r` && echo "patched :)" || echo "unpatched :("
grep cpu_insecure /proc/cpuinfo && echo "patched :)" || echo "unpatched :("
dmesg | grep "Kernel/User page tables isolation: enabled" && echo "patched :)" || echo "unpatched :("
uname -a

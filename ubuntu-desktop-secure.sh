#!/bin/sh
#
# Ubuntu Server Secure script v0.1 alpha by The Fan Club - May 2012
# 
# - Zenity GUI installer version
#
echo
echo "* Ubuntu Server Secure script v0.1 alpha by The Fan Club - May 2012"
echo 
echo "DISCLAIMER: Use with care. This script is provided purely for alpha testing and can harm your system if used incorrectly"
echo "NOTE: This is a GUI installer script that depends on zenity."
echo "NOTE: Run this script with  gksudo sh /path/to/script/ubuntu-server-secure.sh"
# Local Variables
TFCName="Ubuntu Server Secure"
TFCVersion="v0.1 alpha"
UserName=$(whoami)
LogDay=$(date '+%Y-%m-%d')
LogTime=$(date '+%Y-%m-%d %H:%M:%S')
LogFile=/var/log/uss_$LogDay.log
#
# Start of Zenity code 
#
selection=$(zenity  --list  --title "$TFCName $TFCVersion" --text "Select the security features you require" --checklist  --width 480 --height 550 \
--column "pick" --column "options" \
FALSE " 1. Install and configure Firewall - ufw" \
FALSE " 2. Secure shared memory - fstab" \
FALSE " 3. SSH - Disable root login and change port" \
FALSE " 4. Protect su by limiting access only to admin group" \
FALSE " 5. Harden network with sysctl settings" \
FALSE " 6. Disable Open DNS Recursion" \
FALSE " 7. Prevent IP Spoofing" \
FALSE " 8. Harden PHP for security" \
FALSE " 9. Install and configure ModSecurity" \
FALSE "10. Protect from DDOS attacks with ModEvasive" \
FALSE "11. Scan logs and ban suspicious hosts - DenyHosts" \
FALSE "12. Intrusion Detection - PSAD" \
FALSE "13. Check for RootKits - RKHunter" \
FALSE "14. Scan open Ports - Nmap" \
FALSE "15. Analyse system LOG files - LogWatch" \
FALSE "16. SELinux - Apparmor" \
FALSE "17. Audit your system security - Tiger" \
--separator=","); 


if [ ! "$selection" = "" ] 
  then
    # Start of Zenity Progress code 
    echo "$LogTime uss: [$UserName] * $TFCName $TFCVersion - Install Log Started" >> $LogFile
    (
    echo "5" ; sleep 0.1
    # 1. Install and configure Firewall
       option=$(echo $selection | grep -c "ufw")
       if [ "$option" -eq "1" ] 
         then
           echo "$LogTime uss: [$UserName] 1. Install and configure Firewall - ufw" >> $LogFile
           echo "# 1. Install and configure :Firewall - ufw"
           echo "# Check if ufw Firewall is installed..."
           echo "$LogTime uss: [$UserName] Check if ufw Firewall is installed..." >> $LogFile
           if [ -f /usr/sbin/ufw ]
             then
                echo "# ufw Firewall is already installed"
                echo "$LogTime uss: [$UserName] ufw Firewall is already installed" >> $LogFile
                #sudo ufw status verbose | zenity --title "Firewall Status - $TFCName $TFCVersion" --text-info --width 600 --height 400
           fi
           if [ ! -f /usr/sbin/ufw ]
             then
                echo "# ufw Firewall NOT installed, installing..."
                echo "$LogTime uss: [$UserName] ufw Firewall NOT installed, installing..." >> $LogFile
                sudo apt-get install -y ufw 
                sudo ufw enable
                echo "# ufw Firewall installed and enabled"
                echo "$LogTime uss: [$UserName] ufw Firewall installed and enabled" >> $LogFile               
                sudo ufw allow ssh
        	  		 sudo ufw allow http
        	 	    echo "# ufw Firewall ports for SSH and Http configured"
        			 echo "$LogTime uss: [$UserName] ufw Firewall ports for SSH and Http configured" >> $LogFile
      		fi
  		 fi
    echo "10" ; sleep 0.1
    # 2. secure shared memory
       option=$(echo $selection | grep -c "fstab")
       if [ "$option" -eq "1" ] 
         then
            echo "# 2. Secure shared memory."
            echo "$LogTime uss: [$UserName] 2. Secure shared memory." >> $LogFile
            echo "# Check if shared memory is secured"
        	   echo "$LogTime uss: [$UserName] Check if shared memory is secured" >> $LogFile           
            # Make sure fstab does not already contain a tmpfs reference
            fstab=$(grep -c "tmpfs" /etc/fstab)
            if [ ! "$fstab" -eq "0" ] 
              then
                 echo "# fstab already contains a tmpfs partition. Nothing to be done."
                 echo "$LogTime uss: [$UserName] fstab already contains a tmpfs partition. Nothing to be done." >> $LogFile
            fi
            if [ "$fstab" -eq "0" ]
              then
                 echo "# fstab being updated to secure shared memory"
                 echo "$LogTime uss: [$UserName] fstab being updated to secure shared memory" >> $LogFile
                 sudo echo "# $TFCName Script Entry - Secure Shared Memory - $LogTime" >> /etc/fstab
                 sudo echo "tmpfs     /dev/shm     tmpfs     defaults,noexec,nosuid     0     0" >> /etc/fstab
                 echo "# Shared memory secured. Reboot required"
                 echo "$LogTime uss: [$UserName] Shared memory secured. Reboot required" >> $LogFile
      		fi
  		 fi
    echo "15" ; sleep 0.1
    # 3. SSH Hardening - disable root login and change port
       option=$(echo $selection | grep -c "SSH")
       if [ "$option" -eq "1" ] 
         then
           echo "# 3. SSH Hardening - disable root login and change port"
           echo "$LogTime uss: [$UserName] 3. SSH Hardening - disable root login and change port" >> $LogFile 
           sshNewPort=$(zenity --entry --text "Select a new SSH port?" --title "SSH Hardening - $TFCName $TFCVersion" --entry-text "22")
           echo "# Updating SSH settings"
           echo "$LogTime uss: [$UserName] Updating SSH settings" >> $LogFile 
           # Check if Port entry exists comment out old entries
           echo "$LogTime uss: [$UserName] Check if Port entry exists comment out old entries" >> $LogFile 
           sshconfigPort=$(grep -c "Port" /etc/ssh/sshd_config)
           if [ ! "$sshconfigPort" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/Port/#Port/g' /etc/ssh/sshd_config > /tmp/.sshd_config
                sudo mv /etc/ssh/sshd_config /etc/ssh/ssh_config.backup
                sudo mv /tmp/.sshd_config /etc/ssh/sshd_config
           fi
           # Check if Protocol entry exists comment out old entries
           echo "$LogTime uss: [$UserName] Check if Protocol entry exists comment out old entries" >> $LogFile            
           sshconfigProtocol=$(grep -c "Protocol" /etc/ssh/sshd_config)
           if [ ! "$sshconfigProtocol" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/Protocol/#Protocol/g' /etc/ssh/sshd_config > /tmp/.sshd_config
                sudo mv /etc/ssh/sshd_config /etc/ssh/ssh_config.backup
                sudo mv /tmp/.sshd_config /etc/ssh/sshd_config
           fi
           # Check if PermitRootLogin entry exists comment out old entries
			  echo "$LogTime uss: [$UserName] Check if PermitRootLogin entry exists comment out old entries" >> $LogFile            
           sshconfigPermitRoot=$(grep -c "PermitRootLogin" /etc/ssh/sshd_config)
           if [ ! "$sshconfigPermitRoot" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original 
                sudo sed 's/PermitRootLogin/#PermitRootLogin/g' /etc/ssh/sshd_config > /tmp/.sshd_config
                sudo mv /etc/ssh/sshd_config /etc/ssh/ssh_config.backup
                sudo mv /tmp/.sshd_config /etc/ssh/sshd_config
           fi
           echo "# Write new SSH configuration settings"             
           echo "$LogTime uss: [$UserName] Write new SSH configuration settings" >> $LogFile            
           sudo echo "# $TFCName Script Entry - SSH settings $LogTime" >> /etc/ssh/sshd_config
           sudo echo "Port $sshNewPort" >> /etc/ssh/sshd_config
           sudo echo "Protocol 2" >> /etc/ssh/sshd_config
           sudo echo "PermitRootLogin no" >> /etc/ssh/sshd_config
           echo "# SSH settings update complete"
  			  echo "$LogTime uss: [$UserName] SSH settings update complete" >> $LogFile            
           zenity --question --title "SSH Hardening - $TFCName $TFCVersion" --text "Open new SSH port $sshNewPort on UFW Firewall ?"
           if [ "$?" -eq "0" ]  
             then
                # open new port on UFW Firewall
                sudo ufw $sshNewPort
                echo "# Port $sshNewPort opened on UFW Firewall"
                echo "$LogTime uss: [$UserName] Port $sshNewPort opened on UFW Firewall" >> $LogFile            
           fi 
           if [ ! "$sshNewPort" -eq "22" ] 
             then
              zenity --question --title "SSH Hardening - $TFCName $TFCVersion" --text "Close old SSH port 22 on UFW Firewall ?"
              if [ "$?" -eq "0" ]
                then
                # close old port on UFW Firewall
                  sudo ufw deny port 22
                  echo "# Port 22 closed on UFW Firewall"
                  echo "$LogTime uss: [$UserName] Port 22 closed on UFW Firewall" >> $LogFile            
              fi 
           fi   
           zenity --question --title "SSH Hardening - $TFCName $TFCVersion" --text "Would you like to restart the SSH server now?"
           if [ "$?" -eq "0" ]
             then
                # restart SSHd
                sudo /etc/init.d/ssh restart
                echo "# SSH server restarted"
                echo "$LogTime uss: [$UserName] SSH server restarted" >> $LogFile            
           fi 
  		 fi      
    echo "20" ; sleep 0.1
    # 4. Protect su by limiting access only to admin group
       option=$(echo $selection | grep -c "Protect[[:space:]]su")
       if [ "$option" -eq "1" ] 
         then
            echo "# 4. Protect su by limiting access only to admin group"
            echo "$LogTime uss: [$UserName] 4. Protect su by limiting access only to admin group" >> $LogFile 
            # Get new admin group name 
            newAdminGroup=$(zenity --entry --title "Protect su - $TFCName $TFCVersion" --text "Select name of new admin group?"  --entry-text "admin")
            # Check if new group already exists
            echo "# Checking if Group: $newAdminGroup already exists"
            echo "$LogTime uss: [$UserName] Checking if Group: $newAdminGroup already exists" >> $LogFile 
            groupCheck=$(grep -c -w "$newAdminGroup" /etc/group)
            if [ ! "$groupCheck" -eq "0" ] 
              then
                 # group already exists
                 echo "# Group: $newAdminGroup already exists. Group not added"
                 echo "$LogTime uss: [$UserName] Group: $newAdminGroup already exists. Group not added" >> $LogFile     
            fi
            if [ "$groupCheck" -eq "0" ] 
              then
                 # group does not exist create new group
                 echo "# Group: $newAdminGroup does not exist"
                 echo "$LogTime uss: [$UserName] Group: $newAdminGroup does not exist" >> $LogFile     
                 sudo groupadd  $newAdminGroup          
                 echo "# Group: $newAdminGroup added"
                 echo "$LogTime uss: [$UserName] Group: $newAdminGroup added" >> $LogFile     
            fi
            # Add current administrator user to new admin group 
            addAdminUser=$(zenity --entry --title "Protect su - $TFCName $TFCVersion" --text "Which current user should be added to the new admin group?"  --entry-text "admin")
            # Check if user is already part of the admin group
            echo "# Checking if User: $addAdminUser is already part of the Group: $newAdminGroup"
            echo "$LogTime uss: [$UserName] Checking if User: $addAdminUser is already part of the Group: $newAdminGroup" >> $LogFile 
            userCheck=$(groups $addAdminUser | grep -c -w "$newAdminGroup")
  
            if [ ! "$userCheck" -eq "0" ] 
              then
                 # user is already part of the admin group
                 echo "# User: $addAdminUser is already part of the Group: $newAdminGroup. User not added"
                 echo "$LogTime uss: [$UserName] User: $addAdminUser is already part of the Group: $newAdminGroup. User not added" >> $LogFile     
            fi
            if [ "$userCheck" -eq "0" ] 
              then
                 # user is not part of admin group and needs to be added
                 echo "# User: $addAdminUser is not part of the Group: $newAdminGroup, adding user to group"
                 echo "$LogTime uss: [$UserName] User: $addAdminUser is not part of the Group: $newAdminGroup, adding user to group" >> $LogFile     
                 sudo usermod -a -G $newAdminGroup $addAdminUser     
                 echo "# User: $addAdminUser added to the Group: $newAdminGroup"
                 echo "$LogTime uss: [$UserName] User: $addAdminUser added to the Group: $newAdminGroup" >> $LogFile  
            fi
            # change su permission to limit access only to admin group
            echo "# Checking if dpkg state override aleady exists"
            echo "$LogTime uss: [$UserName] Checking if dpkg state override aleady exists" >> $LogFile 
            dpkgCheck=$(sudo dpkg-statoverride --list | grep -c "4750[[:space:]]/bin/su")
            if [ ! "$dpkgCheck" -eq "0" ] 
              then
                 # dpkg state override already exists. do nothing
                 echo "# User: dpkg state override already exists. Override not set."
                 echo "$LogTime uss: [$UserName] dpkg state override already exists. Override not set." >> $LogFile     
            fi
            if [ "$dpkgCheck" -eq "0" ] 
              then
                 echo "# Setting new dpkg state override"
                 echo "$LogTime uss: [$UserName] Setting new dpkg state override" >> $LogFile 
                 sudo dpkg-statoverride --update --add root $newAdminGroup 4750 /bin/su
                 echo "# dpkg state override done. /bin/su only accessible by $newAdminGroup group members"
                 echo "$LogTime uss: [$UserName] dpkg state override done. /bin/su only accessible by $newAdminGroup group members" >> $LogFile    
            fi
       fi    
    echo "25" ; sleep 0.1
    # 5. Harden network with sysctl settings
       option=$(echo $selection | grep -c "sysctl")
       if [ "$option" -eq "1" ] 
         then
           echo "# 5. Harden network with sysctl settings"
           echo "$LogTime uss: [$UserName] 5. Harden network with sysctl settings" >> $LogFile 
           echo "# Updating sysctl network settings"
           echo "$LogTime uss: [$UserName] Updating sysctl network settings" >> $LogFile 
           # Check if sysctl entry exists comment out old entries
           echo "$LogTime uss: [$UserName] Check if net.ipv4.conf.default.rp_filter entry exists comment out old entries" >> $LogFile 
           sysctlConfig1=$(grep -c "net.ipv4.conf.default.rp_filter" /etc/sysctl.conf)
           if [ ! "$sysctlConfig1" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv4.conf.default.rp_filter/#net.ipv4.conf.default.rp_filter/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
           # Check if sysctl entry exists comment out old entries
           echo "$LogTime uss: [$UserName] Check if net.ipv4.conf.all.rp_filter entry exists comment out old entries" >> $LogFile            
           sysctlConfig2=$(grep -c "net.ipv4.conf.all.rp_filter" /etc/sysctl.conf)
           if [ ! "$sysctlConfig2" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv4.conf.all.rp_filter/#net.ipv4.conf.all.rp_filter/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
           # Check if sysctl entry exists comment out old entries
			  echo "$LogTime uss: [$UserName] Check if net.ipv4.icmp_echo_ignore_broadcasts entry exists comment out old entries" >> $LogFile            
           sysctlConfig3=$(grep -c "net.ipv4.icmp_echo_ignore_broadcasts" /etc/sysctl.conf)
           if [ ! "$sysctlConfig3" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv4.icmp_echo_ignore_broadcasts/#net.ipv4.icmp_echo_ignore_broadcasts/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
           # Check if sysctl entry exists comment out old entries
           echo "$LogTime uss: [$UserName] Check if net.ipv4.tcp_syncookies entry exists comment out old entries" >> $LogFile 
           sysctlConfig4=$(grep -c "net.ipv4.tcp_syncookies" /etc/sysctl.conf)
           if [ ! "$sysctlConfig4" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv4.tcp_syncookies/#net.ipv4.tcp_syncookies/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
           # Check if sysctl entry exists comment out old entries
           echo "$LogTime uss: [$UserName] Check if net.ipv4.conf.all.accept_source_route entry exists comment out old entries" >> $LogFile            
           sysctlConfig5=$(grep -c "net.ipv4.conf.all.accept_source_route" /etc/sysctl.conf)
           if [ ! "$sysctlConfig5" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv4.conf.all.accept_source_route/#net.ipv4.conf.all.accept_source_route/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
           # Check if sysctl entry exists comment out old entries
			  echo "$LogTime uss: [$UserName] Check if net.ipv6.conf.all.accept_source_route entry exists comment out old entries" >> $LogFile            
           sysctlConfig6=$(grep -c "net.ipv6.conf.all.accept_source_route" /etc/sysctl.conf)
           if [ ! "$sysctlConfig6" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv6.conf.all.accept_source_route/#net.ipv6.conf.all.accept_source_route/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
                      # Check if sysctl entry exists comment out old entries
           echo "$LogTime uss: [$UserName] Check if net.ipv4.conf.default.accept_source_route entry exists comment out old entries" >> $LogFile 
           sysctlConfig7=$(grep -c "net.ipv4.conf.default.accept_source_route" /etc/sysctl.conf)
           if [ ! "$sysctlConfig7" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv4.conf.default.accept_source_route/#net.ipv4.conf.default.accept_source_route/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
           # Check if sysctl entry exists comment out old entries
           echo "$LogTime uss: [$UserName] Check if net.ipv6.conf.default.accept_source_route entry exists comment out old entries" >> $LogFile            
           sysctlConfig8=$(grep -c "net.ipv6.conf.default.accept_source_route" /etc/sysctl.conf)
           if [ ! "$sysctlConfig8" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv6.conf.default.accept_source_route/#net.ipv6.conf.default.accept_source_route/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
           # Check if sysctl entry exists comment out old entries
			  echo "$LogTime uss: [$UserName] Check if net.ipv4.conf.all.log_martians entry exists comment out old entries" >> $LogFile            
           sysctlConfig9=$(grep -c "net.ipv4.conf.all.log_martians" /etc/sysctl.conf)
           if [ ! "$sysctlConfig9" -eq "0" ] 
             then
                # if entry exists use sed to search and replace - write to tmp file - move to original
                sudo sed 's/net.ipv4.conf.all.log_martians/#net.ipv4.conf.all.log_martians/g' /etc/sysctl.conf > /tmp/.sysctl_config
                sudo mv /etc/sysctl.conf /etc/sysctl.conf.backup
                sudo mv /tmp/.sysctl_config /etc/sysctl.conf
           fi
           echo "# Write new sysctl configuration settings"             
           echo "$LogTime uss: [$UserName] Write new sysctl configuration settings" >> $LogFile            
           sudo echo "# $TFCName Script Entry - sysctl settings $LogTime" >> /etc/sysctl.conf
           sudo echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
           sudo echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
           sudo echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
           sudo echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
           sudo echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
           sudo echo "net.ipv6.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
           sudo echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
           sudo echo "net.ipv6.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
           sudo echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
           echo "# sysctl settings update complete"
  			  echo "$LogTime uss: [$UserName] sysctl settings update complete" >> $LogFile            
           
           zenity --question --title "Network hardening - $TFCName $TFCVersion" --text "Would you like restart sysctl with the new settings now?"
           if [ "$?" -eq "0" ]
             then
                # reload sysctl
                sudo sysctl -p
                echo "# sysctl settings reloaded"
                echo "$LogTime uss: [$UserName] sysctl settings reloaded" >> $LogFile            
           fi 
  		 fi    
    echo "30" ; sleep 0.1
    # 6. Disable Open DNS Recursion - BIND DNS Server
       option=$(echo $selection | grep -c "DNS")
       if [ "$option" -eq "1" ] 
         then
            echo "# 6. Disable Open DNS Recursion - BIND DNS Server"
            echo "$LogTime uss: [$UserName] 6. Disable Open DNS Recursion - BIND DNS Server" >> $LogFile
            # Make sure DNS recursion entry does not exist
            echo "# Check if DNS recursion option exists"
            echo "$LogTime uss: [$UserName] Check if DNS recursion option exists" >> $LogFile           
            dnsRecur=$(grep -c "recursion" /etc/bind/named.conf.options )
            if [ ! "$dnsRecur" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# DNS recursion entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] DNS recursion entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/recursion/#recursion/g' /etc/bind/named.conf.options > /tmp/.named_config
                 sudo mv /etc/bind/named.conf.options /etc/bind/_named.conf.options.backup
                 sudo mv /tmp/.named_config /etc/bind/named.conf.options
            fi
            # add DNS recursion option setting
            echo "# Add DNS recursion option setting"
            echo "$LogTime uss: [$UserName] Add DNS recursion option setting" >> $LogFile         
            sudo sed 's/options[[:space:]]{/options { recursion no; # $TFCName Script /g' /etc/bind/named.conf.options > /tmp/.named_config
            sudo mv /etc/bind/named.conf.options /etc/bind/_named.conf.options.backup
            sudo mv /tmp/.named_config /etc/bind/named.conf.options       
            echo "# Restart bind9 DNS server"
        	   echo "$LogTime uss: [$UserName] Restart bind9 DNS server" >> $LogFile          
        	   sudo /etc/init.d/bind9 restart
            echo "# DNS server restarted"
        	   echo "$LogTime uss: [$UserName] DNS server restarted" >> $LogFile                   
  		 fi 
    echo "35" ; sleep 0.1
    # 7. Prevent IP Spoofing
       option=$(echo $selection | grep -c "Spoofing")
       if [ "$option" -eq "1" ] 
         then
            echo "# 7. Prevent IP Spoofing"
            echo "$LogTime uss: [$UserName] 7. Prevent IP Spoofing" >> $LogFile
            # Make sure IP Spoofing entry does not exist
            echo "# Check if IP Spoofing option exists"
            echo "$LogTime uss: [$UserName] Check if IP Spoofing option exists" >> $LogFile           
            ipSpoof=$(grep -c "nospoof" /etc/host.conf )
            if [ ! "$ipSpoof" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# nospoof entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] nospoof entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/nospoof/#nospoof/g' /etc/host.conf > /tmp/.host_config
                 sudo mv /etc/host.conf /etc/host.conf.backup
                 sudo mv /tmp/.host_config /etc/host.conf
            fi
            # Make sure order entry does not exist
            echo "# Check if order entry exists"
            echo "$LogTime uss: [$UserName] Check if order option exists" >> $LogFile           
            orderOp=$(grep -c "order" /etc/host.conf )
            if [ ! "$orderOp" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# order entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] order entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/order/#order/g' /etc/host.conf > /tmp/.host_config
                 sudo mv /etc/host.conf /etc/host.conf.backup
                 sudo mv /tmp/.host_config /etc/host.conf
            fi
            # add new order and nospoof option settings
            echo "# Write new host configuration settings"             
            echo "$LogTime uss: [$UserName] Write new host configuration settings" >> $LogFile         
            sudo echo "# $TFCName Script Entry - IP nospoof settings $LogTime" >> /etc/host.conf
            sudo echo "order bind,hosts" >> /etc/host.conf
            sudo echo "nospoof on" >> /etc/host.conf
            echo "# host configuration settings update complete"
            echo "$LogTime uss: [$UserName] host configuration settings update complete" >> $LogFile  
  		 	   echo "# Restart bind9 DNS server"
        	   echo "$LogTime uss: [$UserName] Restart bind9 DNS server" >> $LogFile          
        	   sudo /etc/init.d/bind9 restart
            echo "# DNS server restarted"
        	   echo "$LogTime uss: [$UserName] DNS server restarted" >> $LogFile                  
  		 fi 
    echo "40" ; sleep 0.1
    # 8. Harden PHP for security
       option=$(echo $selection | grep -c "PHP")
       if [ "$option" -eq "1" ] 
         then
            echo "# 8. Harden PHP for security"
            echo "$LogTime uss: [$UserName] 8. Harden PHP for security" >> $LogFile
            # Make sure disable_functions entry does not exist
            echo "# Check if disable_functions option exists"
            echo "$LogTime uss: [$UserName] Check if disable_functions option exists" >> $LogFile           
            disPhp=$(grep -c "disable_functions" /etc/php5/apache2/php.ini )
            if [ ! "$disPhp" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# disable_functions entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] disable_functions entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/disable_functions/;disable_functions/g' /etc/php5/apache2/php.ini > /tmp/.php_config
                 sudo mv /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.backup
                 sudo mv /tmp/.php_config /etc/php5/apache2/php.ini
            fi
            # Make sure register_globals entry does not exist
            echo "# Check if register_globals entry exists"
            echo "$LogTime uss: [$UserName] Check if register_globals option exists" >> $LogFile           
            gloPhp=$(grep -c "register_globals" /etc/php5/apache2/php.ini )
            if [ ! "$gloPhp" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# register_globals entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] register_globals entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/register_globals/;register_globals/g' /etc/php5/apache2/php.ini > /tmp/.php_config
                 sudo mv /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.backup
                 sudo mv /tmp/.php_config /etc/php5/apache2/php.ini
            fi
            # Make sure expose_php entry does not exist
            echo "# Check if register_globals entry exists"
            echo "$LogTime uss: [$UserName] Check if register_globals option exists" >> $LogFile           
            expPhp=$(grep -c "expose_php" /etc/php5/apache2/php.ini )
            if [ ! "$expPhp" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# expose_php entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] expose_php entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/expose_php/;expose_php/g' /etc/php5/apache2/php.ini > /tmp/.php_config
                 sudo mv /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.backup
                 sudo mv /tmp/.php_config /etc/php5/apache2/php.ini
            fi
            # Make sure magic_quotes_gpc entry does not exist
            echo "# Check if magic_quotes_gpc entry exists"
            echo "$LogTime uss: [$UserName] Check if magic_quotes_gpc option exists" >> $LogFile           
            expPhp=$(grep -c "magic_quotes_gpc" /etc/php5/apache2/php.ini )
            if [ ! "$expPhp" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# magic_quotes_gpc entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] magic_quotes_gpc entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/magic_quotes_gpc/;magic_quotes_gpc/g' /etc/php5/apache2/php.ini > /tmp/.php_config
                 sudo mv /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.backup
                 sudo mv /tmp/.php_config /etc/php5/apache2/php.ini
            fi
            # add new PHP configuration option settings
            echo "# Write new PHP configuration settings"             
            echo "$LogTime uss: [$UserName] Write new PHP configuration settings" >> $LogFile         
            sudo echo "; $TFCName Script Entry - PHP security settings settings $LogTime" >> /etc/php5/apache2/php.ini
            sudo echo "disable_functions = exec,system,shell_exec,passthru" >> /etc/php5/apache2/php.ini
            sudo echo "register_globals = Off" >> /etc/php5/apache2/php.ini
            sudo echo "expose_php = Off" >> /etc/php5/apache2/php.ini
            sudo echo "magic_quotes_gpc = On" >> /etc/php5/apache2/php.ini            
            echo "# PHP configuration settings update complete"
            echo "$LogTime uss: [$UserName] PHP configuration settings update complete" >> $LogFile  
            # Ask to restart Apache2
            zenity --question --title "PHP Security - $TFCName $TFCVersion" --text "Would you like restart Apache2 with the new settings now?"
            if [ "$?" -eq "0" ]
             then
                # restart apache2 
                echo "# Restart Apache2 server"
        	       echo "$LogTime uss: [$UserName] Restart Apache2 server" >> $LogFile          
                sudo /etc/init.d/apache2 restart
                echo "# Apache2 restarted"
                echo "$LogTime uss: [$UserName] Apache2 restarted" >> $LogFile            
            fi             
  		 fi
    echo "45" ; sleep 0.1
    # 9. Install ModSecurity
       option=$(echo $selection | grep -c "ModSecurity")
       if [ "$option" -eq "1" ] 
         then
            echo "# 9. Install ModSecurity"
            echo "$LogTime uss: [$UserName] 9. Install ModSecurity" >> $LogFile
            # install dependencies
            echo "# Install dependencies libxml2 libxml2-dev libxml2-utils elinks" 
            echo "$LogTime uss: [$UserName] Install dependencies libxml2 libxml2-dev libxml2-utils" >> $LogFile
            sudo apt-get install -y libxml2 libxml2-dev libxml2-utils 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing libxml2 libxml2-dev libxml2-utils" --auto-close
            echo "# Install dependencies libaprutil1 libaprutil1-dev"
            echo "$LogTime uss: [$UserName] Install dependencies libaprutil1 libaprutil1-dev" >> $LogFile
            sudo apt-get -y install libaprutil1 libaprutil1-dev 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing libaprutil1 libaprutil1-dev" --auto-close
            echo "# create symbolic link for 64bit users to libxml2.so.2"
            echo "$LogTime uss: [$UserName] create symbolic link for 64bit users to libxml2.so.2" >> $LogFile
            ln -s /usr/lib/x86_64-linux-gnu/libxml2.so.2 /usr/lib/libxml2.so.2
            # Install ModSecurity
            echo "# Install Apache ModSecurity"
            echo "$LogTime uss: [$UserName] Install Apache ModSecurity" >> $LogFile
            sudo apt-get install -y libapache-mod-security 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing libaprutil1 libaprutil1-dev" --auto-close
            # Activate default configuration file
            echo "# Activate Apache ModSecurity recommended rules"
            echo "$LogTime uss: [$UserName] Activate Apache Mod Security" >> $LogFile
            sudo mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
            # Edit modsecurity.conf and change the SecRequestBody Limits as the default 128KB is too low
            RecLimit=$(zenity --entry --text "Select the page request body limit (SecRequestBodyLimit)? Default is 128KB and is very low. Value in bytes:" --title "ModSecurity Configuration - $TFCName $TFCVersion" --entry-text "131072")
            echo "# Updating ModSecurity settings"
            echo "$LogTime uss: [$UserName] Updating ModSecurity settings" >> $LogFile 
            # Check if SecRequestBodyLimit entry exists comment out old entries
            echo "$LogTime uss: [$UserName] Check if SecRequestBodyLimit entry exists comment out old entries" >> $LogFile 
            modsecSecReq=$(grep -c "SecRequestBodyLimit" /etc/modsecurity/modsecurity.conf)
            if [ ! "$modsecSecReq" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original
                 sudo sed 's/SecRequestBodyLimit/#SecRequestBodyLimit/g' /etc/modsecurity/modsecurity.conf > /tmp/.modsec_config
                 sudo mv /etc/modsecurity/modsecurity.conf /etc/modsecurity/modsecurity.conf.backup
                 sudo mv /tmp/.modsec_config /etc/modsecurity/modsecurity.conf
            fi
            # Check if SecRequestBodyInMemoryLimit entry exists comment out old entries
            echo "$LogTime uss: [$UserName] Check if SecRequestBodyInMemoryLimit entry exists comment out old entries" >> $LogFile            
            modsecSecReqMem=$(grep -c "SecRequestBodyInMemoryLimit" /etc/modsecurity/modsecurity.conf)
            if [ ! "$modsecSecReqMem" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original
                 sudo sed 's/SecRequestBodyInMemoryLimit/#SecRequestBodyInMemoryLimit/g' /etc/modsecurity/modsecurity.conf > /tmp/.modsec_config
                 sudo mv /etc/modsecurity/modsecurity.conf /etc/modsecurity/modsecurity.conf.backup
                 sudo mv /tmp/.modsec_config /etc/modsecurity/modsecurity.conf
            fi  
            echo "# Write new ModSecurity configuration settings"             
            echo "$LogTime uss: [$UserName] Write new ModSecurity configuration settings" >> $LogFile            
            sudo echo "# $TFCName Script Entry - ModSecurity settings $LogTime" >> /etc/modsecurity/modsecurity.conf
            sudo echo "SecRequestBodyLimit $RecLimit" >> /etc/modsecurity/modsecurity.conf
            sudo echo "SecRequestBodyInMemoryLimit $RecLimit" >> /etc/modsecurity/modsecurity.conf
            echo "# ModSecurity settings update complete"
  			   echo "$LogTime uss: [$UserName] ModSecurity settings update complete" >> $LogFile         
            # Download latest OWASP Core Rule Set
            echo "# Download latest OWASP Core Rule Set"
            echo "$LogTime uss: [$UserName] Download latest OWASP Core Rule Set for SourceForge" >> $LogFile
            sourceforgeUrl="http://sourceforge.net/projects/mod-security/files/modsecurity-crs/0-CURRENT/"
            modesecurityFilePattern="modsecurity-crs_2.*"
            # Read sourceforge webpage with elinks and find the latest version filename
            crsFilename=$(elinks $sourceforgeUrl | grep -o -w --max-count=1 "$modesecurityFilePattern.tar.gz")
				# Create a tmp install folder            
            sudo mkdir /tmp/modsecurity-crs
            cd /tmp/modsecurity-crs
            # Download the latest crs from sourceforge
            echo "# Downloading Core Rule Set: $crsFilename from SourceForge"
            echo "$LogTime uss: [$UserName] Downloading Core Rule Set: $crsFilename from SourceForge" >> $LogFile
            # Download and show progress and download speed with zenity
            sudo wget $sourceforgeUrl$crsFilename 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Downloading $crsFilename" --auto-close
            # UnTar and install crs rules
            sudo tar -zxvf $crsFilename
            sudo cp -R $modesecurityFilePattern/* /etc/modsecurity/
            # Delete tmp install folder
            cd /tmp
            sudo rm -R /tmp/modsecurity-crs
            # Activate the default crs ruleset
            sudo mv /etc/modsecurity/modsecurity_crs_10_config.conf.example  /etc/modsecurity/modsecurity_crs_10_config.conf
            # Enable ModSecurity in Apache2
            sudo a2enmod mod-security
            echo "# Apache2 ModSecurity installation complete"
        	   echo "$LogTime uss: [$UserName] Apache2 ModSecurity installation complete" >> $LogFile
            # Ask to restart Apache2
            zenity --question --title "Apache2 ModSecurity - $TFCName $TFCVersion" --text "Would you like restart Apache2 with ModSecurity?"
            if [ "$?" -eq "0" ]
             then
                # restart apache2 
                echo "# Restart Apache2 with ModSecurity"
        	       echo "$LogTime uss: [$UserName] Restart Apache2 with ModSecurity" >> $LogFile          
                sudo /etc/init.d/apache2 restart
                echo "# Apache2 restarted"
                echo "$LogTime uss: [$UserName] Apache2 restarted with ModSecurity" >> $LogFile       
                # Output the Apache2 error.log file entries for ModSecurity to check status after install in zenity info box
                sudo grep "ModSecurity" /var/log/apache2/error.log | zenity --title "Apache2 ModSecurity Status - $TFCName $TFCVersion" --text-info --width 800 --height 400           
            fi
  		 fi
    echo "50" ; sleep 0.1
    # 10. Protect from DDOS (Denial of Service) attacks - ModEvasive
       option=$(echo $selection | grep -c "ModEvasive")
       if [ "$option" -eq "1" ] 
         then
            echo "# 10. Protect from DDOS (Denial of Service) attacks - ModEvasive"
            echo "$LogTime uss: [$UserName] 10. Protect from DDOS (Denial of Service) attacks - ModEvasive" >> $LogFile
            # Install ModEvasive
            echo "# Install Apache ModEvasive"
            echo "$LogTime uss: [$UserName] Install Apache ModEvasive" >> $LogFile
            sudo apt-get install -y libapache2-mod-evasive 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing libapache2-mod-evasive" --auto-close
            # Create log file for ModEvasive
            sudo mkdir /var/log/mod_evasive
            # Change the log folder permissions
            sudo chown www-data:www-data /var/log/mod_evasive/
            # Enter Email address to receive notifications from ModEvasive
            echo "# Enter Email address to receive notifications from ModEvasive"
        	   echo "$LogTime uss: [$UserName] Enter Email address to receive notifications from ModEvasive" >> $LogFile     
            modEvaEmail=$(zenity --entry --text "Enter the email for ModEvasive notifications" --title "Apache2 ModEvasive - $TFCName $TFCVersion" --entry-text "email@domain.com")
            # Check for previous ModEvasive configuration file
            if [ -f /etc/apache2/mods-available/mod-evasive.conf ]
             then
                echo "# Backup previous ModEvasive configuration file"
        	       echo "$LogTime uss: [$UserName] # Backup previous ModEvasive configuration file" >> $LogFile    
                sudo mv /etc/apache2/mods-available/mod-evasive.conf /etc/apache2/mods-available/mod-evasive.conf.backup
            fi
            # Writing New Configuration file for ModEvasive
            echo "# Writing New Configuration file for ModEvasive"
        	   echo "$LogTime uss: [$UserName] Writing New Configuration file for ModEvasive" >> $LogFile
        	   # Create Config file
            sudo echo "# $TFCName Script Entry - Apache2 ModEvasive Configuration $LogTime" > /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "<ifmodule mod_evasive20.c>" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSHashTableSize 3097" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSPageCount  2" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSSiteCount  50" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSPageInterval 1" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSSiteInterval  1" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSBlockingPeriod  10" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSLogDir   /var/log/mod_evasive" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSEmailNotify  $modEvaEmail" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "   DOSWhitelist   127.0.0.1" >> /etc/apache2/mods-available/mod-evasive.conf
            sudo echo "</ifmodule>" >> /etc/apache2/mods-available/mod-evasive.conf
            # Enable ModEvasive in Apache2
            sudo a2enmod mod-evasive
            echo "# Apache2 ModEvasive installation complete"
        	   echo "$LogTime uss: [$UserName] Apache2 ModEvasive installation complete" >> $LogFile
            # Ask to restart Apache2
            zenity --question --title "Apache2 ModEvasive - $TFCName $TFCVersion" --text "Would you like restart Apache2 with ModEvasive?"
            if [ "$?" -eq "0" ]
             then
                # restart apache2 
                echo "# Restart Apache2 with ModSecurity"
        	       echo "$LogTime uss: [$UserName] Restart Apache2 with ModEvasive" >> $LogFile          
                sudo /etc/init.d/apache2 restart
                echo "# Apache2 restarted"
                echo "$LogTime uss: [$UserName] Apache2 restarted with ModEvasive" >> $LogFile       
            fi
  		 fi
    echo "55" ; sleep 0.1
    # 11. Scan logs and ban suspicious hosts - DenyHosts
       option=$(echo $selection | grep -c "DenyHosts")
       if [ "$option" -eq "1" ] 
         then
            echo "# 11. Scan logs and ban suspicious hosts - DenyHosts"
            echo "$LogTime uss: [$UserName] 11. Scan logs and ban suspicious hosts - DenyHosts" >> $LogFile
            echo "# Check if Denyhosts is installed..."
            echo "$LogTime uss: [$UserName] Check if Denyhosts is installed..." >> $LogFile
            if [ -f /usr/sbin/denyhosts ]
              then
                 # RKHunter already installed
                 echo "# Denyhosts is already installed"
                 echo "$LogTime uss: [$UserName] Denyhosts is already installed" >> $LogFile
            fi
            if [ ! -f /usr/sbin/denyhosts ]
              then
                 # Install DenyHosts
                 echo "# Install DenyHosts"
                 echo "$LogTime uss: [$UserName] Install DenyHosts" >> $LogFile
                 sudo apt-get install -y denyhosts 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing DenyHosts" --auto-close
      	   fi           
            # Enter Email address to receive notifications from DenyHosts
            echo "# Enter Email address to receive notifications from DenyHosts"
        	   echo "$LogTime uss: [$UserName] Enter Email address to receive notifications from DenyHosts" >> $LogFile     
            denyhostEmail=$(zenity --entry --text "Enter the email for DenyHosts notifications" --title "DenyHosts - $TFCName $TFCVersion" --entry-text "root@localhost")
            denyhostFrom=$(zenity --entry --text "Enter the email from field for DenyHosts notifications" --title "DenyHosts - $TFCName $TFCVersion" --entry-text "DenyHosts <nobody@localhost>")
            # Make sure ADMIN_EMAIL entry does not exist
            echo "# Check if ADMIN_EMAIL option exists"
            echo "$LogTime uss: [$UserName] Check if ADMIN_EMAIL option exists" >> $LogFile           
            adminEmail=$(grep -c "ADMIN_EMAIL" /etc/denyhosts.conf )
            if [ ! "$adminEmail" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# ADMIN_EMAIL entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] ADMIN_EMAIL entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/ADMIN_EMAIL/#ADMIN_EMAIL/g' /etc/denyhosts.conf > /tmp/.denyhosts_config
                 sudo mv /etc/denyhosts.conf /etc/denyhosts.conf.backup
                 sudo mv /tmp/.denyhosts_config /etc/denyhosts.conf
            fi
            # Make sure order entry does not exist
            echo "# Check if SMTP_FROM entry exists"
            echo "$LogTime uss: [$UserName] Check if SMTP_FROM option exists" >> $LogFile           
            smtpFrom=$(grep -c "SMTP_FROM" /etc/denyhosts.conf )
            if [ ! "$smtpFrom" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# SMTP_FROM entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] SMTP_FROM entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/SMTP_FROM/#SMTP_FROM/g' /etc/denyhosts.conf > /tmp/.denyhosts_config
                 sudo mv /etc/denyhosts.conf /etc/denyhosts.conf.backup
                 sudo mv /tmp/.denyhosts_config /etc/denyhosts.conf
            fi
            # write new DenyHosts settings
            echo "# Write new DenyHosts configuration settings"             
            echo "$LogTime uss: [$UserName] Write new DenyHosts configuration settings" >> $LogFile         
            sudo echo "# $TFCName Script Entry - DenyHosts settings $LogTime" >> /etc/denyhosts.conf
            sudo echo "ADMIN_EMAIL = $denyhostEmail" >> /etc/denyhosts.conf
            sudo echo "SMTP_FROM = $denyhostFrom" >> /etc/denyhosts.conf            

            echo "# DenyHosts configuration settings update complete"
            echo "$LogTime uss: [$UserName] DenyHosts configuration settings update complete" >> $LogFile  
  		 	   echo "# Restart DenyHosts service"
        	   echo "$LogTime uss: [$UserName] Restart DenyHosts service" >> $LogFile          
        	   sudo /etc/init.d/denyhosts restart
            echo "# DenyHosts service restarted"
        	   echo "$LogTime uss: [$UserName] DenyHosts service restarted" >> $LogFile                  
  		 fi 
    echo "60" ; sleep 0.1
    # 12. Intrusion Detection - PSAD
       option=$(echo $selection | grep -c "PSAD")
       if [ "$option" -eq "1" ] 
         then
            echo "# 12. Intrusion Detection - PSAD"
            echo "$LogTime uss: [$UserName] 12. Intrusion Detection - PSAD" >> $LogFile
            echo "# Check if PSAD is installed..."
            echo "$LogTime uss: [$UserName] Check if PSAD is installed..." >> $LogFile
            if [ -f /usr/sbin/psad ]
              then
                 # PSAD already installed
                 echo "# PSAD is already installed"
                 echo "$LogTime uss: [$UserName] PSAD is already installed" >> $LogFile
            fi
            if [ ! -f /usr/sbin/psad ]
              then
                 # Install PSAD
                 echo "# Install PSAD"
                 echo "$LogTime uss: [$UserName] Install PSAD" >> $LogFile
                 sudo apt-get install -y psad 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing PSAD" --auto-close
      	   fi           
            # Enter Email address to receive notifications from PSAD
            echo "# Enter Email address to receive notifications from PSAD"
        	   echo "$LogTime uss: [$UserName] Enter Email address to receive notifications from PSAD" >> $LogFile     
            psadEmail=$(zenity --entry --text "Enter the email for PSAD notifications" --title "PSAD - $TFCName $TFCVersion" --entry-text "root@localhost")

            # Make sure EMAIL_ADDRESSES entry does not exist
            echo "# Check if EMAIL_ADDRESSES option exists"
            echo "$LogTime uss: [$UserName] Check if EMAIL_ADDRESSES option exists" >> $LogFile           
            psadAdminEmail=$(grep -c "EMAIL_ADDRESSES" /etc/psad/psad.conf )
            if [ ! "$psadAdminEmail" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# EMAIL_ADDRESSES entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] EMAIL_ADDRESSES entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/EMAIL_ADDRESSES/#EMAIL_ADDRESSES/g' /etc/psad/psad.conf > /tmp/.psad_config
                 sudo mv /etc/psad/psad.conf /etc/psad/psad.conf.backup
                 sudo mv /tmp/.psad_config /etc/psad/psad.conf
            fi
            # Make sure ENABLE_AUTO_IDS entry does not exist
            echo "# Check if ENABLE_AUTO_IDS entry exists"
            echo "$LogTime uss: [$UserName] Check if ENABLE_AUTO_IDS option exists" >> $LogFile           
            psadIdsEmail=$(grep -c "ENABLE_AUTO_IDS_EMAILS" /etc/psad/psad.conf )
            if [ ! "$psadIdsEmail" -eq "0" ] 
              then
                 # if entry exists use sed to search and replace - write to tmp file - move to original 
                 echo "# ENABLE_AUTO_IDS entry exists. Commenting out old entries"
                 echo "$LogTime uss: [$UserName] ENABLE_AUTO_IDS entry exists. Commenting out old entries" >> $LogFile            
                 sudo sed 's/ENABLE_AUTO_IDS_EMAILS/#ENABLE_AUTO_IDS_EMAILS/g' /etc/psad/psad.conf > /tmp/.psad_config
                 sudo mv /etc/psad/psad.conf /etc/psad/psad.conf.backup
                 sudo mv /tmp/.psad_config /etc/psad/psad.conf
            fi
            # write new PSAD settings
            echo "# Write new PSAD configuration settings"             
            echo "$LogTime uss: [$UserName] Write new PSAD configuration settings" >> $LogFile         
            sudo echo "# $TFCName Script Entry - DenyHosts settings $LogTime" >> /etc/psad/psad.conf
            sudo echo "EMAIL_ADDRESSES  $psadEmail;" >> /etc/psad/psad.conf
            sudo echo "ENABLE_AUTO_IDS_EMAILS Y;" >> /etc/psad/psad.conf
            echo "# PSAD configuration settings update complete"
            echo "$LogTime uss: [$UserName] PSAD configuration settings update complete" >> $LogFile  
            echo "# Update iptables to add log rules for PSAD"
        	   echo "$LogTime uss: [$UserName] Update iptables to add log rules for PSAD" >> $LogFile    
        	   sudo iptables -A INPUT -j LOG
            sudo iptables -A FORWARD -j LOG
            sudo ip6tables -A INPUT -j LOG
            sudo ip6tables -A FORWARD -j LOG    
  		 	   echo "# Update and Restart PSAD service"
        	   echo "$LogTime uss: [$UserName] Update and Restart PSAD service" >> $LogFile          
        	   sudo psad -R
            sudo psad --sig-update
            sudo psad -H
            echo "# PSAD service updated and restarted"
        	   echo "$LogTime uss: [$UserName] PSAD service updated restarted" >> $LogFile                  
  		 fi 
  	 echo "65" ; sleep 0.1
    # 13. Check for rootkits - RKHunter 
       option=$(echo $selection | grep -c "RKHunter")
       if [ "$option" -eq "1" ] 
         then
           echo "$LogTime uss: [$UserName] 13. Check for rootkits - RKHunter" >> $LogFile
           echo "# 13. Check for rootkits - RKHunter"
           echo "# Check if RKHunter is installed..."
           echo "$LogTime uss: [$UserName] Check if RKHunter is installed..." >> $LogFile
           if [ -f /usr/bin/rkhunter ]
             then
                # RKHunter already installed
                echo "# RKHunter is already installed"
                echo "$LogTime uss: [$UserName] RKHunter is already installed" >> $LogFile
           fi
           if [ ! -f /usr/bin/rkhunter ]
             then
                # Install RKHunter
                echo "# RKHunter NOT installed, installing..."
                echo "$LogTime uss: [$UserName] RKHunter NOT installed, installing..." >> $LogFile
                sudo apt-get install -y rkhunter 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing RKHunter" --auto-close
      	  fi
      	  # Update RKHunter   
           echo "# Updating RKHunter"
           echo "$LogTime uss: [$UserName] Updating RKHunter" >> $LogFile                             
           sudo rkhunter --update 2>&1 | zenity --progress --title="RKHunter - $TFCName $TFCVersion" --text="Downloading updates..." --width 400 --auto-close --percentage=33
           sudo rkhunter --propupd 2>&1 | zenity --progress --title="RKHunter - $TFCName $TFCVersion" --text="Updating properties..." --width 400 --auto-close --percentage=85
           echo "# RKHunter installed and updated"
           echo "$LogTime uss: [$UserName] RKHunter installed and updated" >> $LogFile   
      	  # Ask to run RKHunter scan now
           zenity --question --title "RKHunter - $TFCName $TFCVersion" --text "Would you like to run a RKHunter check now?"
           if [ "$?" -eq "0" ]
             then
                # Run RKHunter check 
                echo "# Running RKHunter check"
        	       echo "$LogTime uss: [$UserName] Running RKHunter check" >> $LogFile 
        	       # Run RKHunter check and output to Zenity         
                sudo rkhunter --check --nocolors --skip-keypress 2>&1 | zenity --text-info --title "RKHunter - $TFCName $TFCVersion" --width 600 --height 400
                echo "# RKHunter check done"
                echo "$LogTime uss: [$UserName] RKHunter check done" >> $LogFile       
           fi            	   
  		 fi  
  	 echo "70" ; sleep 0.1
    # 14. Scan open ports - Nmap
       option=$(echo $selection | grep -c "Nmap")
       if [ "$option" -eq "1" ] 
         then
           echo "$LogTime uss: [$UserName] 14. Scan open ports - Nmap" >> $LogFile
           echo "# 14. Scan open ports - Nmap"
           echo "# Check if Nmap is installed..."
           echo "$LogTime uss: [$UserName] Check if Nmap is installed..." >> $LogFile
           if [ -f /usr/bin/nmap ]
             then
                # Nmap already installed
                echo "# Nmap is already installed"
                echo "$LogTime uss: [$UserName] Nmap is already installed" >> $LogFile
           fi
           if [ ! -f /usr/bin/nmap ]
             then
               # Install Nmap
                echo "# Nmap NOT installed, installing..."
                echo "$LogTime uss: [$UserName] Nmap NOT installed, installing..." >> $LogFile
                sudo apt-get install -y nmap 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing Nmap" --auto-close
      	  fi
           echo "# Nmap installed"
           echo "$LogTime uss: [$UserName] Nmap installed" >> $LogFile   
      	  # Ask to run Nmap scan now
           zenity --question --title "Nmap - $TFCName $TFCVersion" --text "Would you like to run a Nmap port scan of the localhost now?"
           if [ "$?" -eq "0" ]
             then
                # Run Nmap check 
                echo "# Running Nmap localhost scan"
        	       echo "$LogTime uss: [$UserName] Running Nmap locahost scan" >> $LogFile 
        	       # Run Nmap check and output to Zenity         
                sudo nmap -v -sT -A localhost 2>&1 | zenity --text-info --title "Nmap Localhost Scan - $TFCName $TFCVersion" --width 800 --height 500
                echo "# Nmap check done"
                echo "$LogTime uss: [$UserName] Nmap check done" >> $LogFile       
           fi            	   
  		 fi  
  	 echo "75" ; sleep 0.1
    # 15. Analyse system LOG files - LogWatch
       option=$(echo $selection | grep -c "LogWatch")
       if [ "$option" -eq "1" ] 
         then
           echo "$LogTime uss: [$UserName] 15. Analyse system LOG files - LogWatch" >> $LogFile
           echo "# 15. Analyse system LOG files - LogWatch"
           echo "# Check if LogWatch is installed..."
           echo "$LogTime uss: [$UserName] Check if LogWatch is installed..." >> $LogFile
           if [ -f /usr/sbin/logwatch ]
             then
                # LogWatch already installed
                echo "# LogWatch is already installed"
                echo "$LogTime uss: [$UserName] LogWatch is already installed" >> $LogFile
           fi
           if [ ! -f /usr/sbin/logwatch ]
             then
               # Install LogWatch
                echo "# LogWatch NOT installed, installing..."
                echo "$LogTime uss: [$UserName] LogWatch NOT installed, installing..." >> $LogFile
                sudo apt-get install -y logwatch libdate-manip-perl 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing LogWatch" --auto-close
      	  fi
           echo "# LogWatch installed"
           echo "$LogTime uss: [$UserName] LogWatch installed" >> $LogFile   
      	  # Ask to run LogWatch scan now
           zenity --question --title "Nmap - $TFCName $TFCVersion" --text "Would you like to run a LogWatch for the past day now?"
           if [ "$?" -eq "0" ]
             then
                # Run LogWatch check 
                echo "# Running LogWatch scan"
        	       echo "$LogTime uss: [$UserName] Running LogWatch scan" >> $LogFile 
        	       # Run LogWatch check and output to Zenity         
                sudo logwatch | less | zenity --text-info --title "LogWatch Report - $TFCName $TFCVersion" --width 800 --height 500
                echo "# LogWatch scan done"
                echo "$LogTime uss: [$UserName] LogWatch scan done" >> $LogFile       
           fi            	   
  		 fi    
    echo "80" ; sleep 0.1
    # 16. SELinux - Apparmor
       option=$(echo $selection | grep -c "Apparmor")
       if [ "$option" -eq "1" ] 
         then
           echo "$LogTime uss: [$UserName] 16. SELinux - Apparmor" >> $LogFile
           echo "# 16. SELinux - Apparmor"
           echo "# Check if Apparmor is installed..."
           echo "$LogTime uss: [$UserName] Check if Apparmor is installed..." >> $LogFile
           if [ -f /usr/sbin/apparmor_status ]
             then
                # Apparmor already installed
                echo "# Apparmor is already installed"
                echo "$LogTime uss: [$UserName] Apparmor is already installed" >> $LogFile
           fi
           if [ ! -f /usr/sbin/apparmor_status ]
             then
               # Install Apparmor
                echo "# Apparmor NOT installed, installing..."
                echo "$LogTime uss: [$UserName] Apparmor NOT installed, installing..." >> $LogFile
                sudo apt-get install -y apparmor apparmor-profiles 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing Apparmor" --auto-close
      	  fi
           echo "# Apparmor installed"
           echo "$LogTime uss: [$UserName] Apparmor installed" >> $LogFile   
      	  # Ask to run Apparmor status check now
           zenity --question --title "Apparmor - $TFCName $TFCVersion" --text "Would you like to check the Apparmor status now?"
           if [ "$?" -eq "0" ]
             then
                # Run Apparmor check 
                echo "# Check Apparmor status"
        	       echo "$LogTime uss: [$UserName] Check Apparmor status" >> $LogFile 
        	       # Run Apparmor status check and output to Zenity         
                sudo apparmor_status 2>&1 | zenity --text-info --title "Apparmor status check - $TFCName $TFCVersion" --width 600 --height 400
                echo "# Apparmor status check done"
                echo "$LogTime uss: [$UserName] Apparmor status check done" >> $LogFile       
           fi            	   
  		 fi  
    echo "85" ; sleep 0.1
    # 17. Audit your system security - Tiger
       option=$(echo $selection | grep -c "Tiger")
       if [ "$option" -eq "1" ] 
         then
           echo "$LogTime uss: [$UserName] 17. Audit your system security - Tiger" >> $LogFile
           echo "# 17. Audit your system security - Tiger"
           echo "# Check if Tiger is installed..."
           echo "$LogTime uss: [$UserName] Check if Tiger is installed..." >> $LogFile
           if [ -f /usr/sbin/tiger ]
             then
                # Tiger already installed
                echo "# Tiger is already installed"
                echo "$LogTime uss: [$UserName] Tiger is already installed" >> $LogFile
           fi
           if [ ! -f /usr/sbin/tiger ]
             then
               # Install Tiger
                echo "# Tiger NOT installed, installing..."
                echo "$LogTime uss: [$UserName] Tiger NOT installed, installing..." >> $LogFile
                sudo apt-get install -y tiger 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="Downloading File..." --text="Installing Tiger" --auto-close
      	  fi
           echo "# Tiger installed"
           echo "$LogTime uss: [$UserName] Tiger installed" >> $LogFile   
      	  # Ask to run Tiger audit now
           zenity --question --title "Tiger - $TFCName $TFCVersion" --text "Would you like to run a Tiger system audit now?"
           if [ "$?" -eq "0" ]
             then
                # Run Tiger audit 
                echo "# Run Tiger system audit"
        	       echo "$LogTime uss: [$UserName] Run Tiger system audit" >> $LogFile 
        	       # Tiger system audit and output to Zenity         
                sudo tiger -e 2>&1 | zenity --text-info --title "Tiger system audit - $TFCName $TFCVersion" --width 800 --height 500
                echo "# Tiger system audit done"
                echo "$LogTime uss: [$UserName] Tiger system audit done" >> $LogFile       
           fi            	   
  		 fi    		 		   	  		 		   		 
     echo "100" ; sleep 0.1
     echo "# Installation Complete" ; sleep 0.1
     # End of Zenity Progress code
     ) |
     zenity --progress \
            --title="$TFCName $TFCVersion" \
            --text="Configuring security features..." \
            --width 500 \
            --percentage=0

     if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Installation canceled."
     fi

     exit;
   fi
exit;

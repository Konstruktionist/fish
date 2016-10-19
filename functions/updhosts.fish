function updhosts -d 'Update my /etc/hosts file'
   set current_working_directory $PWD
   # set cleanup grep 0.0.0.0 | sed 's/[[:space:]]*#.*$//g;' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015' | sort -u
   # set yocleanup (sed 's/127.0.0.1/0.0.0.0/g;' |  grep 0.0.0.0 | sed 's/[[:space:]]*#.*$//g;' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015')
   
   cd ~/workspace
   
   cat my_blocklist | sed 's/[[:space:]]*#.*$//g;' | tr ' ' '\t' | tr -s '\t' | tr -d '\015' | sort -u > hosts_temp
   
   curl -s http://someonewhocares.org/hosts/zero/hosts | grep 0.0.0.0 | sed 's/[[:space:]]*#.*$//g;' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015' | sort -u > hosts1
   curl -s http://winhelp2002.mvps.org/hosts.txt | grep 0.0.0.0 | sed 's/[[:space:]]*#.*$//g;' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015' | sort -u > hosts2
   curl -s 'https://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=0&startdate%5Bday%5D=&startdate%5Bmonth%5D=&startdate%5Byear%5D=&mimetype=plaintext' | sed 's/127.0.0.1/0.0.0.0/g;' |  grep 0.0.0.0 | sed 's/[[:space:]]*#.*$//g;' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015' > hosts3
   curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-social/hosts | grep 0.0.0.0 | sed 's/[[:space:]]*#.*$//g;' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015' | sort -u > hosts4

   cat hosts2 >> hosts1
   cat hosts3 >> hosts1
   cat hosts4 >> hosts1
   cat hosts_temp >> hosts1

   cat hosts_original.txt > my_current_hosts
   echo -n "#   Last updated: "  (date -R) >> my_current_hosts
   cat hosts1 | sort -u >> my_current_hosts
   sudo mv my_current_hosts /etc/hosts
   rm hosts1 hosts2 hosts3 hosts4 hosts_temp
   cd $current_working_directory
end


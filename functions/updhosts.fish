function updhosts -d 'Update my /etc/hosts file'
   set current_working_directory $PWD
   cd ~/workspace
   curl -s http://someonewhocares.org/hosts/zero/hosts > my_current_hosts
   cat my_blocklist >> my_current_hosts
   sudo mv my_current_hosts /etc/hosts
   cd $current_working_directory
end


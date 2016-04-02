function updhosts -d 'Update my /etc/hosts file'
   cd ~/workspace
   curl -s http://someonewhocares.org/hosts/zero/hosts > my_current_hosts
   cat my_blocklist >> my_current_hosts
   sudo mv my_current_hosts /etc/hosts
end


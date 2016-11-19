function updhosts -d 'Update my /etc/hosts file'

  # Relies on a helper function: helper_cleanup_hosts

  # Save current working directory, so we can excecute this anywhere in the file system.
  set current_working_directory $PWD

  cd ~/workspace

  # Clean up my blocklist
  # This is a list which I maintain with reasons why the sites are on there. If
  # in the future things seem odd, I can review if I broke something.
  cat my_blocklist | sed 's/[[:space:]]*#.*$//g;' | tr ' ' '\t' | tr -s '\t' | tr -d '\015' | sort -u > hosts_temp

  # Get blocklists online, clean them up & append them to our temp file
  # The StevenBlack list contains the other lists as well. So if any one of
  # them fails, they still get included.
  # If all of them fail we end up with the standard hosts file provided by the
  # OS with my personal blocklist appended.

  curl -s http://someonewhocares.org/hosts/zero/hosts | helper_cleanup_hosts >> hosts_temp
  curl -s http://winhelp2002.mvps.org/hosts.txt | helper_cleanup_hosts >> hosts_temp
  curl -s 'https://pgl.yoyo.org/as/serverlist.php?hostformat=hosts&showintro=0&startdate%5Bday%5D=&startdate%5Bmonth%5D=&startdate%5Byear%5D=&mimetype=plaintext' | helper_cleanup_hosts >> hosts_temp
  curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling/hosts | helper_cleanup_hosts >> hosts_temp


  # Restore the original hosts entries
  cat hosts_original.txt > my_temp_hosts

  # Add a time stamp
  echo -n "#   Last updated: "  (date -R) >> my_temp_hosts

  # Sort entries, remove duplicates & append to my_temp_hosts
  cat hosts_temp | sort -u >> my_temp_hosts

  # Put it in the right place
  sudo mv my_temp_hosts /private/etc/hosts

  # clear DNS caches
  # The commands have changed over the years with OS versions
  # This is for macOS 10.12 Sierra
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder

  # Clean up after ourselves
  rm hosts_temp

  # Return to where we came from
  cd $current_working_directory
end

# A replacement for getnet.fish
#
# PROBLEM: getnet.fish has en0 & en1 hardcoded to Ethernet & Wi-Fi.
#   This works if there is a physical ethernet port on the computer
#   but current MacBooks may not have one.
#
# SOLUTION: find out what ports are available on the machine & how
#   they map to Ethernet and Wi-Fi. Then use this information to
#   diplay the correct port with the user friendly labels.
#
# IMPORTANT: netinfo was a tool on MacOS X < 10.5, so it may cause
#   problems there.

function netinfo -d "get network information"
  # echo "To be implemented"
  networksetup -listallhardwareports
  echo "==== " (ifconfig -uv en0 | grep 'type: ' | awk '{print $2}') " ====="
  echo " "
  echo '   IP-address:' (ifconfig -uv en0 | grep 'inet ' | awk '{print $2}')
  echo 'Network Speed: '(ifconfig -uv en0 | grep 'link rate: ' | awk '{print $3, $4}')
  echo " "
  echo "==== " (ifconfig -uv en1 | grep 'type: ' | awk '{print $2}') " ====="
  echo " "
  echo '   IP-address:' (ifconfig -uv en1 | grep 'inet ' | awk '{print $2}')
  echo 'Network Speed: '(ifconfig -uv en1 | grep 'downlink rate: ' | awk '{print $3, $4}')
  echo " "
end

# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 

function func_try -d 'Playground function'

  # get all the info we can grab from networksetup -listallhardwareports
  #   array of friendly labels
  set hw_port (networksetup -listallhardwareports | grep 'Hardware Port:' | awk -F : '{print $2}')
  #   array of geeky port names
  set device (networksetup -listallhardwareports | grep 'Device:' | awk -F : '{print $2}')
  #   array of MAC adresses
  set NWSU_MAC_Address (networksetup -listallhardwareports | grep 'Ethernet Address:' | awk '{print $3}')

  # get all the info we can get from ifconfig
  # 	an array of geeky port names
  set ports (ifconfig -uv | grep '^[a-z0-9]' | awk -F : '{print $1}')
  # 	an array of MAC addresses
  set IC_MAC_Address (ifconfig -uv | grep 'ether' | awk '{print $2}')

  echo $hw_port
  echo $device
  echo $NWSU_MAC_Address
  echo ''
  echo $ports
  echo $IC_MAC_Address

end

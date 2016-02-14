# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#

function func_try -d 'Playground function'

  # get all the info we can grab from networksetup -listallhardwareports
  #   array of friendly labels
  set hw_port (networksetup -listallhardwareports | grep 'Hardware Port:' | awk -F : '{print $2}' | sed s/\ /""/ )
  #   array of geeky port names
  set device (networksetup -listallhardwareports | grep 'Device:' | awk -F : '{print $2}' | awk '{print $1}')
  #   array of MAC adresses
  set NWSU_MAC_Address (networksetup -listallhardwareports | grep 'Ethernet Address:' | awk '{print $3}')

  # get all the info we can get from ifconfig
  #   an array of firendly labels
  set type (ifconfig -uv | grep 'type:' | awk -F : '{print $2}' | awk '{print $1}')
  # 	an array of geeky port names
  set ports (ifconfig -uv | grep '^[a-z0-9]' | awk -F : '{print $1}')
  # 	an array of MAC addresses
  set IC_MAC_Address (ifconfig -uv | grep 'ether' | awk '{print $2}')

  echo $hw_port
  # result [Wi-Fi, Bluetooth PAN, Thunderbolt 1, Thunderbolt 2, Thunderbolt Bridge]
  # Total: 5 elements
  echo $device
  # result [en0, en3, en1, en2, bridge0]
  # Total: 5 elements
  echo $NWSU_MAC_Address
  # result [ac:bc:32:b8:12:79, ac:bc:32:b8:12:7a, 4a:00:03:ea:db:f0, 4a:00:03:ea:db:f1, ae:bc:32:8b:58:00]
  # Total: 5 elements
  echo ''
  echo $type
  # result [Wi-Fi, Ethernet, Ethernet, Wi-Fi, Wi-Fi]
  # Total: 5 elements
  echo $ports
  # result [lo0, en0, en1, en2, p2p0, awdl0, bridge0, utun0]
  # Total: 8 elements
  echo $IC_MAC_Address
  # result [ac:bc:32:b8:12:79, 4a:00:03:ea:db:f0, 4a:00:03:ea:db:f1, 0e:bc:32:b8:12:79, 7e:1c:4b:9b:cb:82, ae:bc:32:8b:58:00]
  # Total: 6 elements

  #   We want to use the friendly labels from networksetup but the data from ifconfig
  #   The only thing that matches in both is the MAC address

  echo '------------------------------------------------'
  for i in  $IC_MAC_Address
    for j in $NWSU_MAC_Address
    # set counter (seq (count [$j]))
      if test $i = $j
        set_color green; echo -n $i; echo -n ' =? '; echo $j; set_color normal
      else
        set_color red; echo -n $i; echo -n ' =? '; echo $j; set_color normal
      end
    end
  end
end

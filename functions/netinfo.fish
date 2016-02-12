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
  # TODO:
  # echo "To be implemented"
  # networksetup -listallhardwareports
  # pair the MAC adresses to the device identifier
  #  Then:
  #       for every identifier do ifconfig -uv identifier
  #         (this should get also any virtual network interfaces like VPN's)

  # get all the info we can grab from networksetup -listallhardwareports
  # set hw_port (networksetup -listallhardwareports | grep 'Hardware Port:' | awk -F : '{print $2}')
  # set device (networksetup -listallhardwareports | grep 'Device:' | awk -F : '{print $2}')
  # set MAC_Address (networksetup -listallhardwareports | grep 'Ethernet Address:' | awk '{print $3}')

  # set nw_services (networksetup -listallnetworkservices | awk 'NF<=4') # get rid of the first line
  # for value in $nw_services
  #   set_color -o blue; echo $value ; set_color normal
  #   networksetup -getinfo $value
  #   echo 'DNS-Servers:' (networksetup -getdnsservers $value | awk '{print $1 "  " $2}')
  #   echo ' '
  # end

  # set ports (networksetup -listallhardwareports | grep 'Device:' | awk '{print $2}')
  set ports (ifconfig -uv | grep '^[a-z0-9]' | awk -F : '{print $1}')
  for val in $ports
    set activated (ifconfig -uv $val | grep 'status: ' | awk '{print $2}')
    set nwtype (ifconfig -uv $val | grep 'type: ' | awk '{print $2, $3, $4}')
    # set nwtype (networksetup -listallhardwareports $val | grep 'Hardware Port:' | awk -F : '{print $2}')
    set geekport (ifconfig -uv $val | grep '^[a-z0-9]' | awk -F : '{print $1}')
    # set geekport (networksetup -listallhardwareports $val | grep 'Device:' | awk '{print $2}')
    set state (ifconfig -uv $val | grep 'status: ' | awk '{print $2}')
    set ipaddress (ifconfig -uv $val | grep 'inet ' | awk '{print $2}')
    set networkspeed (ifconfig -uv $val | grep 'link rate: ' | awk '{print $3, $4}')
    set macaddress (ifconfig -uv $val | grep 'ether ' | awk '{print $2}')
    set mask (ipconfig getpacket $val | grep 'subnet_mask (ip):' | awk '{print $3}')
    set router (ipconfig getpacket $geekport | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
    set dnsserver (ipconfig getpacket $geekport | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')
    
    if test $activated = 'active' ^/dev/null
      set_color -o blue; echo -n $nwtype ; echo -n ' ('; echo -n $geekport ; echo ')'
      set_color -o blue; echo "----------------"; set_color normal
      # set_color -o blue; echo -n '       Status: ' ; set_color normal; echo $state
      set_color -o blue; echo -n '   IP-address: ' ; set_color normal; echo $ipaddress
      set_color -o blue; echo -n '  Subnet Mask: ' ; set_color normal; echo $mask
      set_color -o blue; echo -n '       Router: ' ; set_color normal; echo $router
      set_color -o blue; echo -n '   DNS Server: ' ; set_color normal; echo $dnsserver
      set_color -o blue; echo -n '  MAC-address: ' ; set_color normal; echo $macaddress
      set_color -o blue; echo -n 'Network Speed: ' ; set_color normal; echo $networkspeed
      set_color -o blue; echo " "
    else if test $activated = 'inactive' ^/dev/null
      set_color -o blue; echo -n $nwtype ; echo -n ' ('; echo -n $geekport ; echo ')'
      set_color -o blue; echo "----------------"; set_color normal
      set_color -o blue; echo -n '       Status: ' ; set_color normal; echo $state
      set_color -o blue; echo -n '  MAC-address: ' ; set_color normal; echo $macaddress
      set_color -o blue; echo " "
    end
  end
end

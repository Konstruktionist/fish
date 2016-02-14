# A replacement for getnet.fish
#
# PROBLEM: getnet.fish has en0 & en1 hardcoded to Ethernet & Wi-Fi.
#   This works if there is a physical ethernet port on the computer
#   but current MacBooks may not have one.
#   This also displays all network interfaces, not just Ethetnet & Wi-Fi.
#
# SOLUTION: find out what ports are available on the machine & how
#   they map to Ethernet and Wi-Fi. Then use this information to
#   diplay the correct port with the user friendly labels.
#
#   version 1.0
#   14-02-2016

function netinfo -d "get network information"

  set public (curl -s http://ipecho.net/plain)

  echo " "
  echo "    Public IP: $public"
  echo "     Hostname:" (uname -n)
  echo " "

  set ports (ifconfig -uv | grep '^[a-z0-9]' | awk -F : '{print $1}')
  for val in $ports
    set activated (ifconfig -uv $val | grep 'status: ' | awk '{print $2}')
    set label (ifconfig -uv $val | grep 'type' | awk -F : '{print $2}')
    set geekport (ifconfig -uv $val | grep '^[a-z0-9]' | awk -F : '{print $1}')
    set state (ifconfig -uv $val | grep 'status: ' | awk '{print $2}')
    set ipaddress (ifconfig -uv $val | grep 'inet ' | awk '{print $2}')
    set networkspeed (ifconfig -uv $val | grep 'link rate: ' | awk '{print $3, $4}')
    set macaddress (ifconfig -uv $val | grep 'ether ' | awk '{print $2}')
    set netmask (ipconfig getpacket $val | grep 'subnet_mask (ip):' | awk '{print $3}')
    set router (ipconfig getpacket $geekport | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
    set dnsserver (ipconfig getpacket $geekport | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')

    if test $activated = 'active' ^/dev/null
      echo -n $label ; echo -n ' ('; echo -n $geekport ; echo ')'
      echo "--------------"
      # echo -n '       Status: ' ; echo $state
      echo -n '   IP-address: ' ; echo $ipaddress
      echo -n '  Subnet Mask: ' ; echo $netmask
      echo -n '       Router: ' ; echo $router
      echo -n '   DNS Server: ' ; echo $dnsserver
      echo -n '  MAC-address: ' ; echo $macaddress
      echo -n 'Network Speed: ' ; echo $networkspeed
      echo " "

      # Don't display the inactive ports.
    else if test $activated = 'inactive' ^/dev/null
      # echo -n $label ; echo -n ' ('; echo -n $geekport ; echo ')'
      # echo "----------------"; set_color normal
      # echo -n '       Status: ' ; echo $state
      # echo -n '  MAC-address: ' ; echo $macaddress
      # echo " "
    end
  end
end

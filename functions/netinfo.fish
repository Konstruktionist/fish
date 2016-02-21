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
#   version 1.1
#   21-02-2016

function netinfo -d "get network information"

  set public (curl -s http://ipecho.net/plain)
  if test -z "$public" # We don't have an internet connection
    set public "No internet connection available"
  end

  echo " "
  echo "    Public IP: $public"
  echo "     Hostname:" (uname -n)
  echo " "

  set ports (ifconfig -uv | grep '^[a-z0-9]' | awk -F : '{print $1}')
  set wifi_name (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep '\sSSID:' | sed 's/.*: //')

  for val in $ports
    set activated (ifconfig -uv $val | grep 'status: ' | awk '{print $2}')
    set label (ifconfig -uv $val | grep 'type' | awk -F : '{print $2}')
    set geekport (ifconfig -uv $val | grep '^[a-z0-9]' | awk -F : '{print $1}')
    set state (ifconfig -uv $val | grep 'status: ' | awk '{print $2}')
    set ipaddress (ifconfig -uv $val | grep 'inet ' | awk '{print $2}')
    set networkspeed (ifconfig -uv $val | grep 'link rate: ' | awk '{print $3, $4}')
    set macaddress (ifconfig -uv $val | grep 'ether ' | awk '{print $2}')
    set quality (ifconfig -uv $val | grep 'link quality:' | awk '{print $3, $4}')
    set netmask (ipconfig getpacket $val | grep 'subnet_mask (ip):' | awk '{print $3}')
    set router (ipconfig getpacket $geekport | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
    set dnsserver (ipconfig getpacket $geekport | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')

    # We want inofmation about active network ports...
    if test $activated = 'active' ^/dev/null
    #   and of these, the ones with an ip-address assigned to it
      if test -n "$ipaddress" # Do we have an ip address?
      # Give us the information
        echo -n $label ; echo -n ' ('; echo -n $geekport ; echo ')'
        echo "--------------"
        # Does this port have a name associated with it? If so, it is Wi-Fi
        #   and we want to know the name of the network
        if test -n "$wifi_name"
          echo -n ' Network Name: ' ; echo $wifi_name
        end
        echo -n '   IP-address: ' ; echo $ipaddress
        echo -n '  Subnet Mask: ' ; echo $netmask
        echo -n '       Router: ' ; echo $router
        echo -n '   DNS Server: ' ; echo $dnsserver
        echo -n '  MAC-address: ' ; echo $macaddress
        echo -n 'Network Speed: ' ; echo $networkspeed
        echo -n 'Netw. quality: ' ; echo $quality
        echo " "
      end

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

# A replacement for getnet.fish
#
# PROBLEM: getnet.fish has en0 & en1 hardcoded to Ethernet & Wi-Fi.
#   This works if there is a physical ethernet port on the computer
#   but current Macs may not have one.
#
# SOLUTION: find out what ports are available on the machine & how
#   they map to Ethernet and Wi-Fi. Then use this information to
#   display the correct port with the user friendly labels.
#
#   This also should display all network interfaces, not just Ethernet & Wi-Fi.
#   I have not tested this assumption, for lack of specific hardware.
#
#   version 1.9
#   24-8-2017

function netinfo -d "get network information"

  # Get public ip address
  set public (dig +short myip.opendns.com @resolver1.opendns.com)

  if test -z "$public" # No Internet connection
    set public "No Internet connection available"
  end

  echo " "
  echo -n "    Public IP: "; echo $public
  echo -n "     Hostname: "; echo (uname -n)
  echo " "

  # Get all available hardware ports
  set ports (ifconfig -uv | grep '^[a-z0-9]' | awk -F : '{print $1}')

  # Get for all available hardware ports their status
  for val in $ports
    set activated (ifconfig -uv $val | grep 'status: ' | awk '{print $2}')

    # We want information about active network ports...
    if test $activated = 'active' ^/dev/null
      set ipaddress (ifconfig -uv $val | grep 'inet ' | awk '{print $2}')

      # and of these, the ones with an IP-address assigned to it
      if test -n "$ipaddress" ^/dev/null

        # Do we have an IP address?
        # Then give us the information
        set label (ifconfig -uv $val | grep 'type' | awk '{print $2}')
        set macaddress (ifconfig -uv $val | grep 'ether ' | awk '{print $2}')
        set quality (ifconfig -uv $val | grep 'link quality:' | awk '{print $3, $4}')
        set netmask (ipconfig getpacket $val | grep 'subnet_mask (ip):' | awk '{print $3}')
        set router (ipconfig getpacket $val | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
        set dnsserver (ipconfig getpacket $val | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')

        # Header for the network interfaces
        echo -n $label ; echo -n ' ('; echo -n $val ; echo ')'
        echo "--------------"

        # Is this a WiFi associated port? If so, then we want the network name
        switch $label
          case Wi-Fi
            # Get WiFi network name
            set wifi_name (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep '\sSSID:' | sed 's/.*: //')
            echo -n ' Network Name: '; echo $wifi_name
            # Networkspeed for Wi-Fi
            set networkspeed (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep lastTxRate: | sed 's/.*: //' | sed 's/$/ Mbps/')
          case '*'
            # Networkspeed  for other ports
            set networkspeed (ifconfig -uv $val | grep 'link rate:' | awk '{print $3, $4}')
        end

        echo -n '   IP-address: ' ; echo $ipaddress
        echo -n '  Subnet Mask: ' ; echo $netmask
        echo -n '       Router: ' ; echo $router
        echo -n '   DNS Server: ' ; echo $dnsserver
        echo -n '  MAC-address: ' ; echo $macaddress
        echo -n 'Network Speed: ' ; echo $networkspeed
        echo -n ' Link quality: ' ; echo $quality
        echo ''
      end

      # Don't display the inactive ports.
    else if test $activated = 'inactive' ^/dev/null
    end
  end
end

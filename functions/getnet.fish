function getnet -d "get network information"

  set QUERY0 (ipconfig getpacket en0)
  set QUERY1 (ipconfig getpacket en1)
  set ETH_MAC0 (ifconfig en0 | grep ether | awk '{print $2}')
  set ETH_MAC1 (ifconfig en1 | grep ether | awk '{print $2}')

  set PUBLIC (curl -s http://checkip.dyndns.org | awk '{print $6}' | awk 'BEGIN {FS = "<"} {print $1}')
  set ETH_IP1 (ipconfig getpacket en0 | grep ciaddr | awk '{print $3}')
  set ETH_IP2 (ipconfig getpacket en0 | grep yiaddr | awk '{print $3}')
  set ETH_SUBNET (ipconfig getpacket en0 | grep 'subnet_mask (ip):' | awk '{print $3}')
  set ETH_ROUTER (ipconfig getpacket en0 | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
  set ETH_DNS (ipconfig getpacket en0 | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')
  set ETH_SPEED (ifconfig en0 | grep media: | sed 's/.*(//' | sed 's/ .*//' | sed 's/baseT/ MBit\/s/')
  set WI_IP1 (ipconfig getpacket en1 | grep ciaddr | awk '{print $3}')
  set WI_IP2 (ipconfig getpacket en1 | grep yiaddr | awk '{print $3}')
  set WI_SUBNET (ipconfig getpacket en1 | grep 'subnet_mask (ip):' | awk '{print $3}')
  set WI_ROUTER (ipconfig getpacket en1 | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
  set WI_DNS (ipconfig getpacket en1 | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')
  set WI_SPEED (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep lastTxRate: | sed 's/.*: //' | sed 's/$/ MBit\/s/')


  echo $QUERY0 | grep 'BOOTREPLY' > /dev/null
  set ET $status # Exit status van vorige regel, Ethernet aanwezig

  echo $QUERY1 | grep 'BOOTREPLY' > /dev/null
  set WI $status  # Exit status van vorige regel, Wifi aanwezig

  echo " "

  if test $ET -a $WI
    echo "     Public IP: $PUBLIC"
  end

  echo "      Hostname:" (uname -n)
  echo " "

  echo  "Wired Ethernet (en0)"
  echo "--------------------"

  if test $ET -eq 0
    echo $QUERY0 | grep 'yiaddr = 0.0.0.0' > /dev/null
    set AT $status
    if test $AT -eq 0
        echo "   IP Address: $ETH_IP1 (Static)"
      else
        echo "   IP Address: $ETH_IP2 (DHCP)"
    end
    # end
    echo "  Subnet Mask: $ETH_SUBNET"
    echo "       Router: $ETH_ROUTER"
    echo "   DNS Server: $ETH_DNS"
    echo "  MAC Address: $ETH_MAC0"
    echo "        Speed: $ETH_SPEED"

   else
    if test $ET -a 0
      echo "  IP Address: inactive"
      echo "  MAC Address: $ETH_MAC0"
    end
  end

  echo " "
  echo "Wireless Ethernet (en1)"
  echo "-----------------------"

  if test $WI -eq 0
    echo $QUERY1 | grep 'yiaddr = 0.0.0.0' > /dev/null
    set AT $status
    if test $AT -eq 0
        echo "   IP Address: $WI_IP1 (Static)"
      else
        echo "   IP Address: $WI_IP2 (DHCP)"
    end
    # end
    echo "  Subnet Mask: $WI_SUBNET"
    echo "       Router: $WI_ROUTER"
    echo "   DNS Server: $WI_DNS"
    echo "  MAC Address: $ETH_MAC1"
    echo "        Speed: $WI_SPEED"

    else
      if test  $WI -a 0
        echo "  IP Address: inactive"
        echo "  MAC Address: $ETH_MAC1"
    end
  end
  echo " "
end


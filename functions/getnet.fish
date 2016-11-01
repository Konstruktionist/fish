#   Deprecated. Use netinfo.fish instead
#
#     This is not correct on machines witout a physical Ethernet port

function getnet -d "get network information"

  set QUERY0 (ipconfig getpacket en0) # Query Ethernet
  set QUERY1 (ipconfig getpacket en1) # Query Wifi
  set ETH_MAC0 (ifconfig en0 | grep ether | awk '{print $2}') # Ethernet MAC address
  set WIFI_MAC1 (ifconfig en1 | grep ether | awk '{print $2}') # Wifi MAC address

  set PUBLIC (curl -s http://ipecho.net/plain)

  # ciaddr = Client IP Address (DHCP)
  # yiaddr = Your IP Address (DHCP)

  set ETH_IP1 (ipconfig getpacket en0 | grep ciaddr | awk '{print $3}')
  set ETH_IP2 (ipconfig getpacket en0 | grep yiaddr | awk '{print $3}')
  set ETH_SUBNET (ipconfig getpacket en0 | grep 'subnet_mask (ip):' | awk '{print $3}')
  set ETH_ROUTER (ipconfig getpacket en0 | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
  set ETH_DNS (ipconfig getpacket en0 | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')
  set ETH_SPEED (ifconfig en0 | grep media: | sed 's/.*(//' | sed 's/ .*//' | sed 's/baseT/ MBit\/s/')
  set WIFI_IP1 (ipconfig getpacket en1 | grep ciaddr | awk '{print $3}')
  set WIFI_IP2 (ipconfig getpacket en1 | grep yiaddr | awk '{print $3}')
  set WIFI_SUBNET (ipconfig getpacket en1 | grep 'subnet_mask (ip):' | awk '{print $3}')
  set WIFI_ROUTER (ipconfig getpacket en1 | grep 'router (ip_mult):' | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')
  set WIFI_DNS (ipconfig getpacket en1 | grep 'domain_name_server (ip_mult):' | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')
  set WIFI_SPEED (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep lastTxRate: | sed 's/.*: //' | sed 's/$/ MBit\/s/')
  set WIFI_NAME (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep '\sSSID:' | sed 's/.*: //')


  echo $QUERY0 | grep 'BOOTREPLY' > /dev/null
  set ETH $status # Exit status from previous line, Ethernet active?

  echo $QUERY1 | grep 'BOOTREPLY' > /dev/null
  set WIFI $status  # Exit status from previous line, Wifi active?

  echo " "

  if test $ETH -a $WIFI
    echo "    Public IP: $PUBLIC"
  end

  echo "     Hostname:" (uname -n)
  echo " "

  echo  "Wired Ethernet (en0)"
  echo "--------------------"

  if test $ETH -eq 0
    echo $QUERY0 | grep 'yiaddr = 0.0.0.0' > /dev/null
    set AT $status
    if test $AT -eq 0
      echo "   IP Address: $ETH_IP1 (Static)"
    else
      echo "   IP Address: $ETH_IP2 (DHCP)"
    end

    echo "  Subnet Mask: $ETH_SUBNET"
    echo "       Router: $ETH_ROUTER"
    echo "   DNS Server: $ETH_DNS"
    echo "  MAC Address: $ETH_MAC0"
    echo "        Speed: $ETH_SPEED"

  else
    if test $ETH -a 0
      echo "   IP Address: inactive"
      echo "  MAC Address: $ETH_MAC0"
    end
  end

  echo " "
  echo "Wireless Ethernet (en1)"
  echo "-----------------------"

  if test $WIFI -eq 0
    echo $QUERY1 | grep 'yiaddr = 0.0.0.0' > /dev/null
    set AT $status
    if test $AT -eq 0
      echo "   IP Address: $WIFI_IP1 (Static)"
    else
      echo "   IP Address: $WIFI_IP2 (DHCP)"
    end

    echo " Network Name: $WIFI_NAME"
    echo "  Subnet Mask: $WIFI_SUBNET"
    echo "       Router: $WIFI_ROUTER"
    echo "   DNS Server: $WIFI_DNS"
    echo "  MAC Address: $WIFI_MAC1"
    echo "        Speed: $WIFI_SPEED"

  else
    if test  $WIFI -a 0
      echo "   IP Address: inactive"
      echo "  MAC Address: $WIFI_MAC1"
    end
  end
  echo " "
end

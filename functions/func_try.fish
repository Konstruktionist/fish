# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#

function func_try -d 'Playground function'

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
    set quality (ifconfig -uv $val | grep 'link quality:' | awk '{print $3, $4}')
    set wifi_name (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep '\sSSID:' | sed 's/.*: //')

    if test $activated = 'active' ^/dev/null
      if test -n "$ipaddress"
        echo -n $label ; echo -n ' ('; echo -n $geekport ; echo ')'
        echo "--------------"
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
    end
  end

end

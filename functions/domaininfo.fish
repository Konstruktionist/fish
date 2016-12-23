function domaininfo -d "Get information for a FQDN"

  # Found this thanks to Hacker News about blocking Facebook (or anyone else)
  # by using a firewall (like pf or iptables).
  #
  # You need to know the ASN (Autonomous System Number).
  # Use that number and plug it into a whois query like so:
  #  whois -h whois.radb.net '!gAS32934' | tr ' ' '\n'
  #                             ======= <- this is the ASN
  #
  # Described in detail at https://www.perpetual-beta.org/weblog/blocking-facebook-on-os-x.html

  # if we don't get an argument we'll use our public IP address

  if test -z "$argv"
    set dig_response (curl -s http://ipecho.net/plain)
    set_color brred; echo "Querying your own public IP address"
    echo "This is probably not what you want, enter a domain name as argument"; set_color normal
  else
    set dig_response (dig +short $argv)
    set_color blue; echo "Querying "$argv; set_color normal
  end

  for val in $dig_response
    # display the information of the requested domain
    curl -s ipinfo.io/$val | sed -e '/[{}]/d' | sed 's/\"//g' | sed 's/  //g' | sed 's/,$//'
    # get the ASN
    set as_number (curl -s ipinfo.io/$val | sed -e '/[{}]/d' | sed 's/\"//g' | sed 's/  //g' | sed 's/,$//' | egrep -i 'org:' | awk '{print $2}')
    # display the IP ranges that this domain uses
    set_color blue; echo "And its IP address ranges are: "; set_color normal
    whois -h whois.radb.net '!g'$as_number
    # save it to a file for later use
    set reply (whois -h whois.radb.net '!g'$as_number | tr ' ' '\n' | awk 'length > 10')
    echo "# "$argv >> ~/"$argv"_iptables.txt
    for val in $reply
      echo "iptables -A INPUT -d" $val "-j REJECT" >> ~/"$argv"_iptables.txt
    end
    set_color yellow; echo "Saved as ~/"$argv"_iptables.txt"; set_color normal
  end
end

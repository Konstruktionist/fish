function domaininfo -d "Get information for a FQDN"

  # Found this thanks to Hacker News about blocking Facebook (or anyone else) by
  # using the pf firewall. You need to know the ASN (Autonomous System Number).
  # Use that number and plug it into a whois query like so:
  #  whois -h whois.radb.net '!gAS32934' | tr ' ' '\n'
  #                             ======= <- this is the ASN
  # Described in detail at https://www.perpetual-beta.org/weblog/blocking-facebook-on-os-x.html
  #
  #  Anyway this function will show the ASN after the  "org":

  # if we don't get an argument we'll use our public IP address

  if test -z "$argv"
    set dig_response (dig +short myip.opendns.com @resolver1.opendns.com)
    set_color brred; echo "Querying your own public IP address"
    echo "This is probably not what you want, enter a domain name as argument"; set_color normal
  else
    set dig_response (dig +short $argv)
    set_color blue; echo "Querying "$argv; set_color normal
  end

  for val in $dig_response
    echo ''
    curl -s ipinfo.io/$val | sed -e '/[{}]/d' | sed 's/\"//g' | sed 's/  //g' | sed 's/,$//'
  end
end

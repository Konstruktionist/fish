function ipinfo -d "Get IP information for a FQDN"

  # Found this thanks to Hacker News about blocking Facebook (or anyone else) by
  # using the pf firewall. You need to know the ASN (Autonomous System Number).
  # Use that number and plug it into a whois query like so:
  #  whois -h whois.radb.net '!gAS32934' | tr ' ' '\n'
  #                             ======= <- this is the ASN
  # Described in detail at https://www.perpetual-beta.org/weblog/blocking-facebook-on-os-x.html
  #
  #  Anyway this function will show the ASN after the  "org":

  curl ipinfo.io/(dig +short $argv)
end

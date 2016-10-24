function helper_cleanup -d "Helper function for cleaning up downloaded hosts file"

  # files downloaded from:
  #   http://someonewhocares.org/hosts/zero/hosts
  #   http://winhelp2002.mvps.org/hosts.txt
  #   https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-social/hosts
  #   https://pgl.yoyo.org

  sed 's/127.0.0.1/0.0.0.0/g;' |  grep 0.0.0.0 | sed 's/[[:space:]]*#.*$//g;' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015'
end

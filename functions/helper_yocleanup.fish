function helper_yocleanup -d "Helper function for cleaning up yoyo hosts file"

  # file downloaded from:
  #   https://pgl.yoyo.org

  sed 's/127.0.0.1/0.0.0.0/g;' |  grep 0.0.0.0 | sed 's/[[:space:]]*#.*$//g;' | grep -v localhost | tr ' ' '\t' | tr -s '\t' | tr -d '\015'
end

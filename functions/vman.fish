# bash, zsh
#  vman() {
#   vim -c "SuperMan $*"
#
#   if [ "$?" != "0" ]; then
#     echo "No manual entry for $*"
#   fi
# }

function vman -d "use vim as a man-page viewer"
  set -gx cmd vim -c 'SuperMan $argv'
  eval $cmd

  if test $status != 0;
    echo "No manual entry for $argv"
  end
end

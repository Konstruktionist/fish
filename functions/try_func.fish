# This function is a playground to try out new scripts and unfamiliar concepts
# of fish and other programs interaction with fish scripting.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#

function try_func
  # get a list of all the tools installed by brew
  set tools (brew list)
  for value in $tools
    # print tools name
    echo -n (set_color blue) $value (set_color brgreen) "used by:" (set_color white)
    # print its dependancies
    echo -n (brew uses --installed $value)
      echo ""
  end
end

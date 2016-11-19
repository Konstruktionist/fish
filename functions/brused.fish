function brused -d 'list which tools use what library/tool'

  # get a list of all the tools installed by brew
  set tools (brew list)
  for value in $tools

    # print tools name
    echo -n (set_color blue) $value (set_color brgreen) "used by:" (set_color white)

    # print who uses that tool/library
    echo -n (brew uses --installed $value)
    echo ""
  end
end

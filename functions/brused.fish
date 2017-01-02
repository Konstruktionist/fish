function brused -d 'list which tools uses what library/tool'

  # Test if we have an argument
  if test -z "$argv"
    # apparently no argument so we list all the installed tools

    # get a list of all the tools installed by brew
    set tools (brew list)

    for value in $tools
      # print tools name
      echo -n (set_color blue) $value (set_color normal)'used by:' (set_color yellow)

      # print who uses that tool/library
      echo -n (brew uses --installed $value)
      echo ""
    end
  else
    # We have at least one argument, so let's diplay the results
    for value in $argv
      echo -n (set_color blue) $value (set_color normal)'used by:' (set_color yellow); echo (brew uses --installed $value)
    end
  end
end

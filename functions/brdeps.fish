function brdeps -d 'List dependancies of packages'

  # Test if we have an argument
  if test -z "$argv"
    # apparently no argument so we list all the installed tools

    # get a list of all the tools installed by brew
    set tools (brew list)

    for value in $tools
      # print tools name
      echo -n (set_color blue) $value (set_color normal)'depends on:' (set_color yellow)

      # print its dependancies
      echo -n (brew deps $value)
      echo ""
    end
  else
    # We have at least one argument, so let's diplay the results
    for value in $argv
      echo -n (set_color blue) $value (set_color normal)'depends on:' (set_color yellow); echo (brew deps $value)
    end
  end
end

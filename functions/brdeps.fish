function brdeps -d 'List dependancies of packages'

  # get a list of all the tools installed by brew
  set tools (brew list)
  for value in $tools

    # print tools name
    echo -n (set_color blue) $value (set_color brgreen) "depends on:" (set_color white)

    # print its dependancies
    echo -n (brew deps $value)
    echo ""
  end
end

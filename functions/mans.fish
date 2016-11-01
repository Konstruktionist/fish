#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and three lines surrounding each hit.
#             Example: mans mplayer codec
#   --------------------------------------------------------------------

function mans -d 'Search manpage given in argument 1 for term given in argument 2'
  man $argv[1] | grep -iC3 --color=always $argv[2] | less -R
end

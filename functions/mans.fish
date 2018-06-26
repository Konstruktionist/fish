#   mans:   Search manpage given in agument '1' for term given in argument '2'
#            (case insensitive)
#           displays paginated result with colored search terms and seven lines
#           surrounding each hit.
#             Example: mans mplayer codec
#   ---------------------------------------------------------------------------
#
#   piping the man page trough col is neccesary to strip nroff control
#   characters. The -b option strips backspace chars.
#   Thanks to:
#   https://apple.stackexchange.com/questions/328703/

function mans -d 'Search manpage given in argument 1 for term given in argument 2'
  man $argv[1] | col -b | grep -iC7 --color=always $argv[2] | less -RX
end

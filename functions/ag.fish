# This forces ag to use the colors I prefer
function ag
  command ag --color-path '93' --color-match '4;32' --color-line-number 94 $argv
end

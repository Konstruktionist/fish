# This forces cat to use the bat command with the colors I prefer
function cat
  command bat --theme=base16-ocean.dark $argv
end

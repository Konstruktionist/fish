function gitk -d "prevent the horrible X11 app gitk to show up"
  # It's nice that they tried, but there are better alternatives
   command -sq gitk 2>/dev/null
end

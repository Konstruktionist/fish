function down4me -d 'Checks whether a website is down for you, or everybody'
  curl --silent "https://downforeveryoneorjustme.com/$argv" | grep -e "It's.*[.!]" | sed "s/\s*\(It's[^<>]*[.!]\).*\$/\1/"
end

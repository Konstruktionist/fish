function img_size -d 'Show image dimensions'
  convert $argv -print "Size: %wx%h\n" /dev/null
end

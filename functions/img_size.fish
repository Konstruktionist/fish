# A function to determine image dimensions
#

function img_size -d 'Show image dimensions'
  echo -n 'Height: ' ; mdls $argv | grep 'kMDItemPixelHeight' | awk '{print $3}'
  echo -n ' Width: ' ; mdls $argv | grep 'kMDItemPixelWidth' | awk '{print $3}'
end

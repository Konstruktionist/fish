# A function to determine image dimensions
#
#     dependency: graphicsmagick
#     ==========================
#

function img_size -d 'Show image dimensions'
  gm identify -verbose $argv | egrep Geometry
end

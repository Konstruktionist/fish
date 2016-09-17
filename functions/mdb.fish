# A script to create a simple movie database
#
#       dependency: tag (https://github.com/jdberry/tag) via brew
#       =========================================================
#
#   version 1.1
#   17-09-2016

function mdb -d 'Make a flatfile movie database'

  set drive (pwd | awk -F / '{print $3}')

  # clean up from previous use
  if test -f $HOME/Movies\ on\ $drive.txt
    rm $HOME/Movies\ on\ $drive.txt
    else
    echo -n ''
  end

  for file in *.mp4
    set title $file
    set width (mdls $file | grep kMDItemPixelWidth | awk '{print $3}')
    set height (mdls $file | grep kMDItemPixelHeight | awk '{print $3}')
    set tags (tag -lN $file)

    # If file has no tags, don't try to put it in database
    if test -z $tags
      echo $title '•' $width 'x' $height >> "$HOME/Movies on $drive.txt"
      else
      echo $title '•' $width 'x' $height '•' $tags >> "$HOME/Movies on $drive.txt"
    end
   end
end

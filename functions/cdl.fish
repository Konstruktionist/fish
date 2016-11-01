# Taken from: https://github.com/LoveIsGrief/fish-functions/blob/master/functions/cdl.fish

function cdl -d 'Automatically output folder after changing to it.'

  if test (count $argv) -ge 1

    #When a file is given just read the directory

    #Follow symlink, if it isn't just set the normal value
    set path (readlink -n $argv[1])
    if test -z $path
      set path $argv[1]
    end

    #In case of a file, go to it's parent directory
    if test -f $path
      set path (dirname $path)
    end
  end

  cd $path ;and ll
end

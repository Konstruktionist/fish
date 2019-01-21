function fixmp4metadata

  # This script takes all mp4 files in the current directory and sets the
  # filename (without the .mp4 extension) as its title in metadata & clears the
  # comments. Then it calls the fixdate function to set the creation and
  # modification date.

  for file in *.mp4
    command AtomicParsley $file --title (string trim -c '.mp4' $file) --comment "" --overWrite
  end
  fixdate
end

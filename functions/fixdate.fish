# A script to extract dates from filenames and put those in the date created & modified metadata
#
# A work in progress
# TODO: longer dates, take into account time values as well
#   version 1.0
#   31-01-2016
#

function fixdate
  #clean up from previous use
  if test -f candidates.txt
    rm candidates.txt
    else
    echo -n ''
  end
    if test -f errors.txt
    rm errors.txt
    else
    echo -n ''
  end

  # Assumption: date is formatted as YYMMDD (6 numbers)
  # get list of files
  for file in *.mp4
      # find out if filename contains numbers
      # pattern longer than 6 numbers?
      if test (echo $file | egrep '[0-9]{7,}')
          # we will ignore these
          echo $file >> errors.txt
      else if test (echo $file | egrep '[0-9]{6}') # matches dates with six numbers
          echo $file >> candidates.txt
          set datum (echo $file | egrep '[0-9]{6}' | awk '{print $2}')
          # get the individual year, month and day items
          set year (echo $datum | cut -c 1-2)
          set month (echo $datum | cut -c 3-4)
          set day (echo $datum | cut -c 5-6)
          # plug them into the SetFile command
          # SetFile is deprecated as of Xcode 6, may not work in the future
          SetFile -d $month/$day/$year $file
          SetFile -m $month/$day/$year $file
      end
  end
end

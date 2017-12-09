# A script to extract dates from filenames
#   and put those in the date created & modified metadata
#
# A work in progress
# TODO: longer dates, take into account time values as well
#
#       dependency: SetFile
#       ===================
#
# SetFile is deprecated as of Xcode 6, may not work in the future
#
#   version 1.4
#   17-02-2016
#

function fixdate -d 'fix file creation & modification dates'
  #clean up from previous use
  if test -f "fixdate_candidates.txt"
    rm fixdate_candidates.txt
  end
  if test -f "fixdate_errors.txt"
    rm fixdate_errors.txt
  end

  # Assumption: date in filename is formatted as YYMMDD (6 digits)
  # get list of files
  for file in *.mp4
    # find out if filename contains digits
    # pattern longer than 6 digits?
    if test (echo $file | egrep '[0-9]{7,}')
      # we will ignore these
      echo $file >> fixdate_errors.txt
    else if test (echo $file | egrep '[0-9]{6}') # match dates with 6 digits
      echo $file >> fixdate_candidates.txt
      # we don't know where the date appears, so let's grab only the
      #  matching part
      set datum (echo $file | egrep -o '[0-9]{6}')
      # get the individual year, month and day items
      set year (echo $datum | cut -c 1-2)
      set month (echo $datum | cut -c 3-4)
      set day (echo $datum | cut -c 5-6)
      # plug them into the SetFile command
      SetFile -d $month/$day/$year $file  # creation date
      SetFile -m $month/$day/$year $file  # modification date
    end
  end
end

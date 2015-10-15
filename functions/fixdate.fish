# A script to extract dates from filenames and put those in the date created & modified metadata
#
# A work in progress
#

function fixdate
   # get list of files
   for file in *.mp4
   # find out if filename contains numbers
   # in which field are these numbers, so awk knows where to look
   # if yes, how many
   # does it look like a date
   # does it include a time stamp
   # does it include a timezone specifier
   # discard all time stamp info
   # we assume that the date format is the following:
   #  either yymmdd or yyyymmdd
   ls | grep -E '[0-9]{8}'     # matches dates with eight numbers
   ls | grep -E '[0-9]{6}'     # matches dates with six numbers
   #  get the individual year, month and day items
   #  plug them into the SetFile command
end


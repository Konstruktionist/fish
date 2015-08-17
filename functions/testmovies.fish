# A script to extract dates from filenames and put those in the date created & modified metadata
#
# A work in progress
#

function testmovies

	# Get a list of possibleCandidates

	ls *.mkv *.m4v *.avi > possibleCandidates

	# use possibleCandidates file as input for mediaInfo

		for file in possibleCandidates
			mediainfo | grep 'Height*>720'
         # for val in Height*; echo $val; end
			# if 'Height' > 720
			# 	file > finalCandidates
			# end
		end


	#    if ((kMDItemPixelHeight > '720')) < possibleCandidates
	#         echo Found fish
	# else if grep bash /etc/shells
	#         echo Found bash
	# else
	#         echo Got nothing
	# end
end

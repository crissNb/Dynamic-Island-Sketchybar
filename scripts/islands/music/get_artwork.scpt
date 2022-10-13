tell application "Music"
	try
		if player state is not stopped then
			set alb to (get album of current track)
			tell artwork 1 of current track
				set imgFormat to ".jpg"
			end tell
			set rawData to (get raw data of artwork 1 of current track)
		else
			return
		end if
	on error
		return
	end try
end tell

tell application "Finder"
	set baseLoc to container of (path to me) as alias
end tell

set newPath to ((baseLoc as text) & "artwork" & imgFormat) as text
try
	tell me to set fileRef to (open for access newPath with write permission)
	write rawData to fileRef starting at 0
	tell me to close access fileRef
on error m number n
	log n
	log m
	try
		tell me to close access fileRef
	end try
end try

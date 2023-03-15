tell application "Music"
    set currentTrack to current track
    set artworkData to raw data of artwork 1 of currentTrack
end tell

set tempFile to (path to temporary items folder as string) & "artwork_temp.jpg"
set fileRef to open for access tempFile with write permission
write artworkData to fileRef
close access fileRef

set resizeCommand to "sips -Z 600 " & quoted form of POSIX path of tempFile
do shell script resizeCommand

set currentFolder to POSIX path of ((path to me as string) & "::")
set newFile to currentFolder & "artwork.jpg"
set moveCommand to "mv " & quoted form of POSIX path of tempFile & " " & quoted form of newFile
do shell script moveCommand

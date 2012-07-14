(*

Xcode 4 Find and Replace in Selection

Author: Michael Bobroski <bobroski@gmail.com>
License: MIT/X11 <http://www.opensource.org/licenses/mit-license.php/>

*)

-- Clear clipboard, so we don't accidentally perform a search/replace on old data
do shell script "echo '' | pbcopy"

tell application "Xcode"
	activate
	tell application id "com.apple.systemevents"
		keystroke "c" using {command down}
	end tell
end tell

tell application "Xcode" to display dialog "Find in Selection:" default answer "" buttons {"Cancel", "Continue"} default button 2
set findText to text returned of the result

tell application "Xcode" to display dialog "Replace with:" default answer "" buttons {"Cancel", "Continue"} default button 2
set replaceText to text returned of the result

set selectedText to do shell script "pbpaste"

if selectedText is "" then return

set newText to replaceString(selectedText, findText, replaceText)

-- Line feeds stripped during find/replace, get em back.
set lineFeeds to getLineFeeds()

do shell script "printf '%s" & lineFeeds & "' " & quoted form of newText & "| pbcopy"

tell application "Xcode"
	activate
	tell application id "com.apple.systemevents"
		keystroke "v" using {command down}
	end tell
end tell



on getLineFeeds()
	set counter to 0
	set lastChar to ""
	repeat until lastChar is not ""
		set counter to counter + 1
		set lastChar to do shell script "pbpaste | tail -c " & counter & " | head -c 1"
	end repeat
	set numberOfNewLines to counter - 1
	
	set newLineString to ""
	if numberOfNewLines is 2 then
		set newLineString to "\\n"
	end if
	if numberOfNewLines is greater than 2 then
		set newLineString to "\\n\\n"
	end if
	return newLineString
end getLineFeeds

-- http://applescript.bratis-lover.net/library/string/#replaceString
on replaceString(theText, oldString, newString)
	local ASTID, theText, oldString, newString, lst
	set ASTID to AppleScript's text item delimiters
	try
		considering case
			set AppleScript's text item delimiters to oldString
			set lst to every text item of theText
			set AppleScript's text item delimiters to newString
			set theText to lst as string
		end considering
		set AppleScript's text item delimiters to ASTID
		return theText
	on error eMsg number eNum
		set AppleScript's text item delimiters to ASTID
		error "Can't replaceString: " & eMsg number eNum
	end try
end replaceString
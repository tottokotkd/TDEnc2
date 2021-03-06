on open TDEnc2 -- if items dropped
	set args to ""
	repeat with droppedFile in TDEnc2
		set filePath to POSIX path of droppedFile
		set args to args & " \"" & filePath & "\""
	end repeat
	run_command(set_command(args))
	activate_terminal()
end open

on run -- if doubleclicked
	run_command(set_command(""))
	activate_terminal()
end run

on set_command(args)
	tell application "Finder"
		set appPath to parent of (path to current application) as text
		set unixPath to POSIX path of appPath & "tool/TDEnc2.sh"
		return "\"" & unixPath & "\"" & args & ";exit"
	end tell
end set_command

on run_command(str)
	tell application "System Events"
		set processList to processes whose bundle identifier is id of application "Terminal"
	end tell
	tell application "Terminal"
		activate
		if processList is not {} then
			try
				if custom title of front window is "TDEnc2" then
					tell application "System Events" to keystroke "t" using command down
				else
					error
				end if
			on error
				set win to do script
				set custom title of win to "TDEnc2"
				do script str in win
				return
			end try
		end if
		do script str in front window
		return
	end tell
end run_command

on activate_terminal()
	tell application "Terminal"
		activate
		try
			set current settings of front window to settings set "TDEnc2"
		on error
			set number of columns of front window to 80
			set number of rows of front window to 26
			set cursor color of front window to "black"
			set background color of front window to "black"
			set normal text color of front window to "white"
			set bold text color of front window to "white"
			set font name of front window to "Menlo Regular"
			set font size of front window to 14
			set title displays device name of front window to false
			set title displays shell path of front window to false
			set title displays window size of front window to false
			set custom title of front window to "TDEnc2"
		end try
	end tell
end activate_terminal
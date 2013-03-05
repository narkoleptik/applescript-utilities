#!/usr/bin/osascript

on run argv
    if the length of argv is less than 3 then
        return "Usage: add-address.scpt email Firstname Lastname"
    end if

    set fname to item 2 of argv
    set lname to item 3 of argv
    set eml to item 1 of argv
    set fullname to fname & " " & lname

--    log fullname & " is being processed!"

tell application "Contacts"
    if not (exists person fullname)
        set thePerson to make new person with properties {first name:fname, last name:lname}
        tell thePerson
         make new email at end of emails with properties {label:"Work", value:eml}
        end tell
        save addressbook
        log "Adding " & eml & " to " & fullname & "."
    else 
        set theVictim to first person whose name is fullname
        set duplicates to 0
        log fullname & " already exists!"
        tell theVictim
            repeat with this_email in every email of theVictim
               if the value of this_email is eml
                   set duplicates to duplicates + 1
               end if
            end repeat
            if duplicates is equal to 0
             make new email at end of emails of theVictim with properties {label:"Work", value:eml}
--             make new email at end of emails of thePerson with properties {label:"Work", value:"applescriptguru@mac.com"}
             set duplicates to 0
            save addressbook
             log "Adding " & eml & " to " & fullname & "."
--             log eml & " adding to " & fullname
           end if
        end tell
   end if
end tell
end run

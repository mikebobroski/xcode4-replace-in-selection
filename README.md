
Xcode 4 Find and Replace in Selection
=====================================

In Xcode 4, Apple eliminated the ability to find and replace within selected 
text. This script brings it back.


Usage
-----

Highlight an area of text, press user-defined shortcut. Simple!


Installation
------------

- Download the script.
- Add a Behavior (From Preferences).
- You should see a little shaded Command Key symbol next to (or overlapping) the
  title you typed in for the behavior. Double-click that to add a keyboard
  shortcut. I use Option-F.
- Check off the Run box, Choose Script.  If the script is grayed out, 
  run `chmod +x Xcode4ReplaceInSelection.applescript` in terminal.


Caveat
------

- You can't paste into the find/replace fields.

  This is a limitation between Xcode and Applescript, and not the script 
  itself. If anyone has any ideas on how to get around this, let me know.

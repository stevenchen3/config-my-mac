# Shortcuts

## Plugin shortcuts

+ `CTRL + i` or `TAB`: normal mode, format C-family source codes
+ `F5`: normal mode, format Scala source codes
+ `F2`: insert mode, e.g., type `for<F2` to auto-generate snippets
+ `:x, yCommentary`: normal mode, comment or uncomment lines from x to y
+ `cs '"`: normal mode, selected word, replace pair
+ `ds "`: normal mode, selected word, delete double quote pair
+ `\gt`: normal mode, selected word, go to definition or declaration, `CTRL+o` to go back

## Replacement and copy and paste

+ `:x, y co z`: normal mode, copy lines x to y and paste to position z
+ `CTRL+v c` insert contents `ESC`: normal mode, substitute selected position in multiple lines with
the contents provided

## Folding and unfolding

+ `zf`: normal mode, fold selected lines
+ `fo`: normal mode, unfold selected folded block

## Multiple windows

+ `CTRL+w v`: normal mode, duplicate open file in vim vertically (`CTRL` + w then type `v`)
+ `CTRL+w s`: normal mode, duplicate open file in vim horizontally
+ `CTRL+w c`: normal mode, close current window
+ `CTRL+w l`: normal mode, move cursor to the right window
+ `CTRL+w h`: normal mode, move cursor to the left window
+ `CTRL+w k`: normal mode, move cursor to the above window
+ `CTRL+w j`: normal mode, move cursor to the bottom window
+ `CTRL+w L`: normal mode, move window to right
+ `CTRL+w H`: normal mode, move window to left
+ `CTRL+w K`: normal mode, move window to above
+ `CTRL+w J`: normal mode, move window to bottom
+ `CTRL+w =`: normal mode, set height even among all windows same content

## Searching

+ `/`: normal mode, search from current cursor position and forward
+ `?`: normal mode, search from current cursor position and backward
+ `*`: normal mode, search forward for the occurrence of the word
+ `#`: normal mode, search backward for the occurrence of the word

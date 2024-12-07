## 20: Typing command-line commands quickly

- <S-Left>/<S-Right> : one word left/right
- 'CTRL-B': Beginning of command line
- 'CTRL-E': End of command line
- 'CTRL-U': delete all text
- 'CTRL-W': delete a word

All ':' commands can be abbreviated - designated by optional chars in their help page

Command line supports tab complete 
'CTRL-D' will show all possible completion values
'CTRL-L' completes word to longest unambiguous string

There are technically 5 histories in Vim. / and ? share history. : commands get their own
'q:': CLI window at bottom, with normal mode, history. Executes when pressing enter

## 21: Go away and come back

Can suspend Vim via CTRL-Z, and come back with fg
Or start a new shell via :terminal

[TODO] Configure shell/term command, so i don't have to cycle between different Wezterm instances (or do, but familiarize commands for that)


[TODO] Consider configuring the 'shada' (shared data) to ensure marks / register info / etc. is persisted btwn editor sessions
Note that shada can be written/read via :wshada and :rshada

`'0`: A special mark saved when closing Vim. In fact, 0-9 are all saved.

:oldfiles shows previously edited files
:e #<{number} Open oldfile with number {number}
OR, :browse oldfiles

Session: Store looks of the whole of vim
View: Stores properties of one window only
Modeline: store settings for just one file

[TODO] Configure sessionoptions 
sessionoptions option affects what is remembered when saving / restoring an editing session
:mksession to make a section, :source to restore the session, or vim -S {sessionName} works too

##  22: Finding the file to edit
Finding files:
'gf': Goto file. Vim will search for it using the 'path' option to deetermine which files can be candidates
Relative paths set in 'path' will mean to search relative to the directory in which 'gf' is used.
(I bet I can configure paths to affect how Telescope searches)
[TODO] Investigate how Telescope picks what files to search over


### Netrw: the builtin file browser

Press <F1> To get help ([TODO] Remap that)
'-': Jump up a directory.... without navigating to ..
'cd': Change what Vim thinks is the CWD. A history is kept. Can execute as a command
'lcd': Change CWD for just one window

### Buffer List: 
Buffer: A file being edited. (A copy of the file being edited. When finished making changes, write the buffer contents to the file. Contain file content, marks, settings etc.

Buffer lifecycle:
    Active: Appears in a window, text loaded
    Hidden: Not visible, text loaded
    Inactive: Not visible, no text loaded

:ls OR :buffers to see buffer list
:buffer {filename} will try to find the best match for filename in the bufferlist, and open it

:ls! will show unlisted buffers (those that have been deleted, but not wiped)

## 23: Editing other files
Vim auto detects what file format we are working with (MAC / DOS / Unix). Run :set fileformat? to inspect for current file.
In the rare chance you want to edit this, just override the fileformat for the file.

Remote files? As long as you have a tool for downloading them, Vim can try to detect and use it (ftp/rcp/scp/http)

Binary files? Sure! Set the binary flag, can display everything in Hex format
(Definitely not the best choice here, maybe use a real editor)
Or, if you really want, see "Using XXD" in section 23.3

Compressed files are automatically handled via the gzip plugin. May need to install different compression tools if not already installed.

## 24: Inserting quickly (Mainly useful insert mode keymaps)

'i_CTRL-O {command}' Execute a normal mode command from Insert mode.

### 24.1 Making corrections
The standard, modeless keys can be useful when in Insert mode. Or escape and use Vim commands. Your call.
This chapter lists all of the keys you can use on insert mode. I bet my terminal keymaps would work too, if i ever learn them.

### 24.3 Completion
'i-CTRL-[P|N]': Try to auto complete the current word (if blank, searches backwards). CTRL-N works 
Vim is a tryhard about this. It will check hidden/inactive buffers, tag files, and even files that are imported into the current one.
[TODO] Look into configuring this - ignore/infer case?

'i-CTRL-X CTRL-{char}': we can filter autocomplete specifically. 
For example, CTRL-F for filenanmes in current directory. See ins-completion for more.

Omni completion (intellisense): 'CTRL-X CTRL-O'. This is for smarter completion (requires some setup per language). See compl-omni-filetypes / omnifunc for more details.

### 24.4 Repeating an insert
This might be useful occasionally, like doing something 2-3 times. Other than that, probably better off recording a macro.
'i_CTRL-A': Repeat the text typed last time in insert mode
'i_CTRL-@': Alias for 'i_CTRL-A <Esc>'

### 24.5 Copying from another line
'i_CTRL-Y': Copies the character on the line above.
'i_CTRL-E': Copies the character on the line below.

### 24.6 Inserting a register (Paste in insert mode)
'i_CTRL-R {register}' inserts the contents of a register. (Paste in insert mode)
Doubling up on CTRL-R will insert it exactly as is, not as if a keyboard was typing it.

### 24.7 Abbreviations
You can add abbreviations with :iabbrev - they get inserted when typing something that can't be part of a word.
Insert and command mode only. 
    - [TODO] Consider if there's any that make sense. Currently can't think of any, but its late and I'm on a flight.
    - Could be one way to support code snippets
    - Maybe common typos?
### 24.8 Inserting exact text
'i_CTRL-V': Insert the next character literally
'i_CTRL-K': To insert digraphs (such as a ψ symbol)

## 25: Editing formatted text
'gq' Format the selection
'formatprg' option lets us format with external tools
Can align text with left/center/right commands
'gj/gk': Move up/down based on visual lines, instead of actual lines (useful when linewrap is on)
[TODO] Consider making gj/gk easier to type

[TODO] Read 25.3 again, and configure shiftwidth/tabstop.

If you decide to turn off linewrap for long lines, look into prefixing movements with 'z' (to move without scrolling)
Prefixing some move commands (0/$/^ etc.) with g will let us move to visible chars, instead of being line based.
shiftwidth/tabstop options are explored in 25.3. 
[TODO] Decide if its worth setting linebreak setting. this will make lines break at words instead of any letter.

### Editing tables
First, :set virtualedit=all
    This lets you edit where this is virtual space, and no actual text.
    Can use visual-block mode to copy/paste columns, too, which is cool
Make sure to unset this via ':set virtualedit=' when done

Or, use Virtual Replace mode ('gr' or 'gR' for multiple characters)

## 26: Repeating

'gv': Select the same visual area again

'CTRL-A': Increment by 1
'CTRL-X': Decrement by 1

Cool time saver: 'v-g CTRL-A' can be used to make numbered list quickly from a list of all 1s 

:windo and :bufdo : Execute command in all windows / buffers in those lists

Can run Vim from a shell script to execute a command for me. (makes sense if I'm more comfortable with its syntax than the corresponding CLI tool)

Opening vim with "-" as the filename tells it to read from stdin
vim -w flag will write out my actions to a file.


## 27: Search commands and patterns (a decent reference)
:help magic, pattern, character-classes
[NOTE]: The following are all to be used as part of a search pattern.
{item} designates a character, or an atomic group inside of (escaped) parentheses

'\c': Ignore case
'\C': Match case
'\v': Very magic, makes everything except [0-9a-Z_] have special meaning (lets us capture group without escaping) - see magic for details
'/pattern/{offset}': Moves curosr to be offset away from matching pattern
    - if a number, moves that many lines (+ or -)
    - 'e' specifies offset from end of match (moves onto last character of match)
    - 'b' is for beginning of pattern
'//{offset}': Use previous search pattern but with a different offset
'{item}*\+': 0/1 or more of preceding item
'\({pattern}\)+': to match a pattern >1 char, must group it w/ parentheses
'{item}\': Specifies item as optional
'{item}\{n,m}': (Matches item [n, m] times) (note item should not be in {})
'{item}\{-n,m}': Match minimal amount possible
'{item}\{-}': n and m are each optional. Removing both means match 0 or more times, as few as possible.
    - given a string like axbxb, searching for '/a.\{-}b' Will match 'axb', instead of matching entire string

'{patternA}\|{patternB}': Matches patternA or patternB
    - Must be grouped in parentheses to match multiple times
'{patternA}\&{patternB}: Requires alternative pattern to match in same spots. Resulting match uses last alternative.
	- ".*Peter\&.*Bob" matches in a line containing both "Peter" and "Bob"
'[]': character ranges, we're familiar

'\s': White space
'\_s': White space OR line break (in fact, adding _ to most character classes will match a line break)
There's some special character ranges (\d for digit, for ex.). These can not go inside of a character range.

There's also some character classes, such as identifier characters, keyword chars, printable chars, file name chars etc.

Concludes with some very basic examples. Key of this is: Use what pattern I can think of. And always feel free to lookup the help for this.

## 28 Folding
Used to show a range of lines in a buffer as a single line.

All fold commands start with 'z'

[TODO] Determine if folds have a place in my workflow. If so, configure them to be useful. 28.3 has some starting ideas (such as a foldcolumn).
'zf': Create fold
'zo': Open fold
'zc': Close fold
'zr': Reduce all folding (1 level)
'zR': Reduce all folding (completely)
'zm': Folds everything (1 level)
'zM': Folds everything (completely)
'zn/N': Toggle folding off/on
'zi': Toggle folding

Can change foldmethod to choose how folds are automatically created (defaults to manual)

If ya wanna save folds, gotta make a view.

### Automatic folding
Manual folding can be tedious. Consider setting foldmethod to indent. This will automatically fold based on indentation (including nested folds).

OR we can fold by markers
OR by syntax (per filetype!) -> Most likely this

## 29 Moving through programs

Tag: A location where an identifier is defined (for ex, a function definition). 
A tagfile stores a list of tags and is used to automatically jump to the tags location (such as a function definition)

:tags will tell me where I am when using tags.
:tnext will go to the next matching tag file (if there are multiple matches for one tag)
:tselect to select a specific tag
    - :tselect /{pattern} to search for a tag matching a pattern.
    - or is it :tag? Idk i can find out later if I ever use this

Can search for a tag when runn

'CTRL-W ]': Split window and jump to tag under cursor

If i want I can set it up to preview whats under a tag. I think I do this with LSP already. Might be nice to set it up for help tags

Might have some luck using '[m' and ']m' to find the start of methods
(works for other types of braces/brackets etc.)
'[{': Find previous {
']}': Find next }
'[/': Move to beginning of comment
'[I': List all matching lines for the identifier under cursor?

:checkpath to confirm that included files were found

## 30 Editing programs

[TODO]: Figure out if I can leverage this to run type check / tests etc. and have the failings in quickfix
quickfix list can be autopopulated by the 'make' command, but we have to set a different compiler in different usecases.

:cnext Go to next quickfix item
:cfile {filename} Have Vim read and populate quickfix list from a file

[TODO]: Figure out how to auto indent for languages besides C
the 'cinoptions' setting will help with that 
Will involve adding to ft plugins 

'=': Re-indent operator
'i_CTRL-T': Increase indent one level (one shiftwidth amount)
'i_CTRL-D': Decrease indent one level

[TODO]: Evaluate my setting of softtabstop, or how tabs/spaces are treated
[TODO]: Do I like how comments are currently handled? If so, no need to configure here.




## usr_02.txt
|*usr_02.txt*| [TODO] can I add a way to tag this to jump directly into the help section?

'CTRL-T' has been good for closing from stack
2.8 Is useful, lists how to get help for things. For ex:
To get a complete index of all Vim commands, use the following command: >
	:help index

## usr_03.txt  Navigation, jumps, marks, searching (long one, extracted things I saw useful and don't currently use

Remember  the commands for the visible screen
			+-----------------------+
    'H' --> | text sample text	    |
			| sample text		    |
			| text sample text	    |
			| sample text		    |
	'M' -->	| text sample text	    |
			| sample text		    |
			| text sample text	    |
			| sample text		    |
	'L' -->	| text sample text	    |
			+-----------------------+


'CTRL+F' / 'CTRL+B' to scroll entire pages at a time, instead of just half a page from 

### Searching
When searching, I can type for some of the history before pressing up key to look through history

\> means end of word in a search pattern
\< means beginning of word

:nohlsearch will remove the highlighting for current search term
[TODO] make a keymap for this, i've wanted that before

what do g* and g# do? loooks like search back/fwd for word under cursor!
'*' Command will search for occurrences of word under cursor!
'#' Command will search (backward) for occurences of word under curosr

'CTRL-O' and 'CTRL-I' to go betwen jump positions (these get marked automatically)

:jumps to list prev jumps
:marks to list mark spots

`": Take me to last position where cursor was when I left the file.
`.: Take me to last position where I made a change.

**operator-motion** for commands

## usr_04.txt Editing / Making changes

's' change one character [TODO] Start using this more often, 
'S' change whole line (or cc)
'D' delete til end of line
'Y' yank til end of line

'.' only repeats CHANGES, not movements
'v-o' In visual mode (hence the v- prefix), jump to other end of selection
'v-O' In visual block mode, jujmp to other corner on same line

'R' for replace mode

'~' Change case of character under cursor and move to next character

### TextObjects
These are things such as 'i', 'a' (inside, around)
operator-textObject
There's a long list of them in :help text-objects

## usr_05.txt Setting options
You can write filetype plugins to do things only in certain filetypes
**runtimepath**: List of directories to be searched for any runtime files. This could be Lua plugins, tutorial files, ftplugins etc.

**package**: A directory that contains plugins. 
**plugin**: A vim script flie that is loaded automatically when Vim starts.

Vim ships with some Global plugins.
For ftplugins, if you need multiple files for same filetype, toss in an underscore after the filetype. Or a subdirectory (I prefer this)
Help files go under the /doc path.
See :help rtp for locations of helpfiles, etc.
Run :helptags with path to the file to generate its helptags

Open :options for a list of options / getting help for a specific one

To set an option back to its default value, stick an & at the end of the set command


[TODO] Options to consider, but not currently set:
- iskeyword, to decide if '-' or '_' should count as part of a keyword (maybe do this per ft). We can use +=<char> or -=<char> to add or remove a character
- Any variation of backups (maybe writebackup?)


## usr_06.txt  Syntax highlighting
Honestly mine already works. Reference if it breaks, ever
colorschemes live under rtp/colors

## usr_07.txt Editing multiple files
Interestingly, I can pass a list of files into nvim to edit, and use :next (wnext to save and go next) to jump between them.
This might be useful for something like type checks / lint errors etc, by getting a list of file names I'll need to edit and piping it in.
[TODO] Figure out if I like ^, or if thers a better way

CTRL-^ is to jump to alternate file.

Capital marks are global, lowercase are file scoped

:marks M will show where the M mark is

We can set modifiable / writeable even in readonly mode. oh or open in readonly mode

use :saveas to save current buffer to a different file name while also keeping original file. Good for creating copies 
### Registers!!!
Register is a place where Vim stores text

'"<char><yank operation>': Perform operation and yank the text into the "<char> register

If ya want, the write command outputs the file. So you can use shell append to append to another file.

(FROM USR_10.txt)
Registers are shared between yank / macros 
Meaning we can edit macros by hand and place them back into the register.
Append to a register by using the uppercase letter for the register, instead of lowercase.

## usr_08.txt Splitting Windows
Status line: shows info about window above it

'CTRL-W' prepends all window commands
'CTRL-W + H/J/K/L' to move current window to desired spot

### Diffing (maybe need to use this with Fugitive/gitdiff? )
Starting Vim with -o or -O can presplit windows for each file passed in. (less useful)

nvim -d to have it show diffs, or :vertical diffpatch difffile

'zo'/'zc' to open close folds

']c' '[c' to jump to next/prev changes
'dp' | 'do' to put / obtain from other diffed file.

Slapping s in front of a command usually splits into a window then performs command

### Tabs
:tabedit  to edit something in a new tab
:tab split for new tab of same buffer

'gt': go to tab
:help tab-page for more info about tab pages

## usr_09.txt Using the GUI -> I'm not using gvim.
Nothing useful in here really

## usr_10.txt Making big changes (macros, substitution)
### 10.1 Macros (Record/playback commands)
1. 'q{register}' records keystrokes into register
2. Do commands
3. 'q' ends recording

'@{register}' to playback a macro
'Q' to playback most recent macro (whats the difference between this and QQ?)
'@@' will also play most recent macro

*These registers are shared with yank/delete registers. Meaning, you can yank a macro and execute it immediately. Or paste it and edit it manually*

### 10.2 Substitution [Command]
Find and replace text 
:[range]s/from/to/[flags]

Useful flags: 
g all occurences
p print the line
c confirm each substitution

If using lots of slashes, probably easier to replace the / for the command with another character (perhaps +, or =)

Capture groups (backreferences):

\( \): Designates a pattern to "capture"

For example, \([^,]*\) will capture everything before , into the \1 argument.
\0 referes to the entire matched pattern, not a specific capture group (up to 9 of these per substitute)
See sub-replace-special.txt for more special substitute commands

### 10.3 Ranges
Line numbers to operate on, inclusive.

{number},{number}
:. current line
:$ last line
:1 first line
:0 before first line (sometimes works)
:?pattern? search backwards
:/pattern/ search forwards for pattern (stops at first)
:'{mark} line that includes the mark
{number}: apply command to the next n lines (press number before entering : )

Selecting a range in visual mode, it will automatically apply it to the command being run
'< and '> marks are at end/start of visual selection
Can mix and match these w/ other range syntaxes, for ex: 
    :'>,$ -> apply to all text after the end of visual mode in a file

offsets: add -/+{number} after the search pattern to do n line before (-1 is line above)

### 10.4 Global [Command]
Match for a pattern and execute a command there
:[range]g/{pattern}/{command}

:g+//+s/foobar/barfoo/g -> find all occurences of //, then run s/foobar...

[TODO] Learn more commands that can take advantage of this. Lot easier than writing crazy patterns 

### 10.5 Visual Block (some operators act funky, at bottom is just a list of operations again)
'[$|0]': all lines also extend until end of line until moving horizontally. Break out by moving horizontally. (0 also works)
'[I|A]{string}<Esc>': Inserts string in each line, left of the block. Only changes lines that are selected.
NOTE: A will append to short lines. $A will do the end of each line, instead of at block location on short lines
'C': beginning of block until end of line.

'c' works as expected
'~': swap case
'[U|u]': upper/lower case
'r': replace block with a character
'J': join all lines together (prepend w/ g to keep whitespace same)

### 10.6 Read/Write part of a file
:[range]read {filename} - add file contents starting on line below range
write also accepts a range

### 10.7 Formatting text
'gq{motion}' Format the lines motion moves over.

### 10.9 Use external programs
'!': tells vim to call external program, or to use a filter
'!!': filter current line through a filter

For ex, running :read !<cmd> will stick cmd outputs in file

'CTRL-L': Redraw the screen (useful if another program modifies a file and Vim doesn't realize


## usr_11.txt Recovering from a crash
Can use 'vim -r {filename}' to recover the file if a swapfile exists. use "" for unnamed file

## usr_12.txt Clever tricks

### 12.1 Replace word in many files
To replace a word in multiple files, you could:
- open all files that might be relevant in VIM
- Record a macro which does the substitution, then runs :wnext to move to the next file.
- Use the e flag to tell substitute that not finding a match is not an error

### 12.3 Sort a selection of lines
The command 

	:.,/^$/-1!sort

Means "Starting at current line, search for the pattern of "^$" (empty line). If its found, subtract 1 line, and thats the range on which we apply the sort command"

Rather just visual select -> run sort 

### 12.4 Reversing a (subset of) file
:global/^/move {location}
:g/^/m {location}

Move command moves a line to a location
Since global executes the following command for each line, its as if we are simply moving one line at a time to the top of the file (and since global goes top -> bottom, we end up reversing the file)

'g CTRL-g' - gives us the word count and position in file
Generally, if we wanna count stuff with vim, look at count-items.txt

### 12.6 Find manpage
There's a builtin :Man command (can also type 'K')

### 12.8 Find where a word is used
Just `grep -l` over potential files to list their names, and open these in vim.
Alternatively, while in vim, use the `grep` command thats builtin.. This will show all lines where the pattern occurs (in the quickfix list)



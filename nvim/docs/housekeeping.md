- Plugins store their data in predictable location based on stdpath, thanks to Lazy
- our RTP is searched for the files we are using (such as under the lua folder)


Lua API guide can be found at :h lua-guide-api
- furhter reading: h api

Lua modules are just filepaths, and an init.lua in it lets us omit the final filepath.

`pcall` to not crash if an errors encountered while requiring a module
`[[STRINGLITERAL]]` lua string literal syntax, to avoid escaping chars
theres a few ways to set a vim var at diff scopes (vim.g for global, vim.b for current buffer)


there are mapping options to be aware of, such as setting for only current buffer
TODO: use this for qfix list? maybe i already do haha
• `expr`: If set to `true`, do not execute the {rhs} but use the return value
  as input. Special |keycodes| are converted automatically. For example, the following
  mapping replaces <down> with <c-n> in the popupmenu only: >lua
    vim.keymap.set('c', '<down>', function()
      if vim.fn.pumvisible() == 1 then return '<c-n>' end
      return '<down>'
    end, { expr = true })


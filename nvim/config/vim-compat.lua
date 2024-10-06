vim.opt.rtp:prepend("/usr/share/vim/vimfiles")

vim.cmd([[
  for file in split(globpath('~/.config/vim/plugin', '*.vim8'), '\n')
    exec "source " file
  endfor

  autocmd BufNewFile * call AutodetectFiletype()
  autocmd BufNewFile * call SetShebang()
  autocmd BufNewFile * let b:new_file = 1
  autocmd BufWritePost *.py,*.sh if exists('b:new_file') | call SetExecutable() | endif
  autocmd BufWritePost if exists('b:new_file') | unlet b:new_file | endif
  " autocmd BufNewFile * call AddModelineString()

  " Right aligned relative cursor line number:
  " :let &stc='%=%{v:relnum?v:relnum:v:lnum} '
  " :set relativenumber

  nmap <F1> <nop>

]])

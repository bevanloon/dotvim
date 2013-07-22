execute pathogen#infect('bundle/{}', 'colors/{}')

au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab

au BufRead,BufNewFile *.php,*.css,*.html set tabstop=4
au BufRead,BufNewFile *.php,*.css,*.html set shiftwidth=4
au BufRead,BufNewFile *.php,*.css,*.html set expandtab
" Display tabs at the beginning of a line in Python mode as bad.
" au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

syntax on
filetype plugin indent on
filetype on


set t_Co=256
let python_highlight_all=1
syntax enable
set background=dark

set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode


"autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

"autocmd VimEnter * NERDTree

set number

set laststatus=2
set statusline=%f\ %m\ %r
set statusline+=Line:%l/%L[%p%%]
set statusline+=Col:%v
set statusline+=Buf:#%n
set statusline+=[%b][0x%B]

let NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
    colorscheme solarized
    let explicitDirectory = isdirectory(a:directory)
    let directory = explicitDirectory || empty(a:directory)

    if explicitDirectory
        exe "cd " . fnameescape(a:directory)
    endif

    " Allows reading from stdin
    " ex: git diff | mvim -R -
    if strlen(a:directory) == 0
        return
    endif

    if directory
        NERDTree
        wincmd p
        bd
    endif

    if explicitDirectory
        wincmd p
    endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
    let stay = 0

    if(exists("a:1"))
        let stay = a:1
    end

    if exists("t:NERDTreeBufName")
        let nr = bufwinnr(t:NERDTreeBufName)
        if nr != -1
            exe nr . "wincmd w"
            exe substitute(mapcheck("R"), "<CR>", "", "")
            if !stay
                wincmd p
            end
        endif
    endif
endfunction

let g:ccpPath = expand("<sfile>:p:h") . "/"
let g:Python = "3.6"

" get KnTL path
if has('win32')
  let g:KnTL = g:ccpPath . "KnTL/KnTL.exe"
else
  let g:KnTL = g:ccpPath . "KnTL/KnTL"
endif

" compile KnTL
function KnTLInstall()
  execute "!g++ -std=c++11 " . g:ccpPath . "KnTL/KnTL.cpp" . " -o " . g:KnTL
endfunction

" mode=1 : just run
" mode=2 : run fron IN
function KnTL(mode, forceCompile)                      " now using KnTL
  if has('win32')
    let l:ext = ".exe"
  else
    let l:ext = ""
  endif

  " check if need to compile
  let l:compile=&mod
  if a:forceCompile==1
    let l:compile=1
  endif

  if a:mode==1
    if l:compile || !filereadable(expand("%:p:r").l:ext)
      execute "w | silent !".g:KnTL shellescape("%") "R"
    else
      execute "silent !".g:KnTL shellescape("%") "r"
    endif
  elseif a:mode==2
    if l:compile || !filereadable(expand("%:p:r").l:ext)
      execute "w | silent !".g:KnTL shellescape("%") "I"
    else
      execute "silent !".g:KnTL shellescape("%") "i"
    endif
  endif
  execute "redraw!"
endfunction

function CCP(mode, forceCompile)
  let l:clear = "clear"
  let l:rm = "rm"
  if has('win32')
    " For Windows systems
    let l:clear = "cls"
    let l:rm = "del"
  endif
  if expand('%:e') == "py"                    " Python
    execute "w | silent !" l:clear "&& echo [".shellescape("%:p")."]"
    if a:mode==1
      execute "!python" . g:Python shellescape("%:p")
    elseif a:mode==2
      execute "!python" . g:Python shellescape("%:p") "< IN"
    endif
  elseif expand('%:e') == "java"              " Java
    let l:ext = ".class"
    if &mod==1 || !filereadable(expand("%:p:r").l:ext)
      execute "silent !" l:rm shellescape("%:p:r").l:ext
      execute "w | !" l:clear "&& javac" shellescape("%:p")
    endif
    if filereadable(expand("%:p:r").l:ext)
      execute "silent !" l:clear "&& echo [".shellescape("%")."]"
      if a:mode==1
        execute "!java" shellescape("%:r")
      elseif a:mode==2
        execute "!java" shellescape("%:r") "< IN"
      endif
    endif
  elseif expand('%:e') == "cpp"               " C++
    call KnTL(a:mode, a:forceCompile)
  endif
endfunction

" INpage toggling
function IN()
  if shellescape(expand('%'))==#shellescape('IN')
    execute "normal c"
  elseif bufwinnr('./IN') > 0
    execute "normal ".expand(bufwinnr('./IN'))."w"
  else
    silent execute "50vs IN"
  endif
endfunction

" paste clipboard to IN file
function PASTE()
  execute "silent! call writefile(getreg('*',0,1),\"IN\")"
endfunction

" CPing
nnoremap <silent> <F2> :call IN()<CR>
nnoremap <silent> <F3> :call PASTE()"<CR>
nnoremap <silent> <F4> :call CCP(2,0)<CR>
nnoremap <silent> <S-F4> :call CCP(2,1)<CR>
nnoremap <silent> <F5> :call CCP(1,0)<CR>
nnoremap <silent> <S-F5> :call CCP(1,1)<CR>

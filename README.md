# ccp
A vim plugin wrapper for [KnTL](https://github.com/kuningfellow/KnTL)

<h3>Installation</h3>
<h4>vim-plug</h4>

Add ```Plug 'kuningfellow/ccp'``` to your vimrc

Then install by running ```:PlugInstall```

<h3>Usage</h3>

This plugin provides the following functions
```
IN()             for toggling the input file IN
PASTE()          for pasting clipboard content to IN
CCP(a,b)         to compile current file.
                   if a=1 then run file from stdin
                   if a=2 then run file with input redirection from IN
                   if b=0 then don't force compilation (works by checking if file is modified)
                   if b=1 then force compilation
KnTLInstall()    for recompiling KnTL.cpp should your machine not be compatible with the precompiled binaries

```
The default mappings are
```
nnoremap <silent> <F2> :call IN()<CR>
nnoremap <silent> <F3> :call PASTE()"<CR>
nnoremap <silent> <F4> :call CCP(2,0)<CR>
nnoremap <silent> <S-F4> :call CCP(2,1)<CR>
nnoremap <silent> <F5> :call CCP(1,0)<CR>
nnoremap <silent> <S-F5> :call CCP(1,1)<CR>
```

<h3>Example</h3>

C++ file:

![image](https://user-images.githubusercontent.com/43501223/71417609-d645bb00-2698-11ea-955c-7877111abbcb.png)

Output:

![image](https://user-images.githubusercontent.com/43501223/71417650-03926900-2699-11ea-8da1-0d5ff3c17465.png)

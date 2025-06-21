" ======================================================
" HARCODED ESSENTIAL PLUGINS (Fixed Errors)
" ======================================================

" 1. vim-commentary - Toggle comments
" ==================================
" Comment current line (gcc)
nnoremap <silent> gcc :<C-u>call plugins#CommentLine()<CR>

" Comment operator (gc{motion})
nnoremap <silent> gc :set opfunc=plugins#CommentMotion<CR>g@

function! plugins#CommentLine()
  let comment = empty(&commentstring) ? '#' : split(&commentstring, '%s')[0]
  execute 's/^/\=comment/'
endfunction

function! plugins#CommentMotion(type)
  let comment = empty(&commentstring) ? '#' : split(&commentstring, '%s')[0]
  let start_line = line("'[")
  let end_line = line("']")
  execute start_line . ',' . end_line . 's/^/\=comment/'
endfunction

" 2. vim-surround - Wrap text with chars
" ====================================
vnoremap <silent> s <Esc>:call plugins#SurroundVisual()<CR>

function! plugins#SurroundVisual()
  let char = input('Surround with: ')
  if !empty(char)
    execute "normal! `<i" . char . "\<Esc>`>a" . char . "\<Esc>"
  endif
endfunction

" Surround motion (e.g., ysiw")
nnoremap <silent> ys :set opfunc=plugins#SurroundMotion<CR>g@

function! plugins#SurroundMotion(type)
  let char = input('Surround with: ')
  if !empty(char)
    execute 'normal! `[i' . char . "\<Esc>`]a" . char . "\<Esc>"
  endif
endfunction
" 3. vim-repeat - Dot-repeat support
" ================================
let g:repeat_tick = get(g:, 'repeat_tick', {})
function! plugins#repeat_set(sequence)
  let g:repeat_tick[bufnr('%')] = a:sequence
endfunction

function! plugins#Repeat()
  if has_key(g:repeat_tick, bufnr('%'))
    execute 'normal! ' . g:repeat_tick[bufnr('%')]
  else
    normal! .
  endif
endfunction
nnoremap . :call plugins#Repeat()<CR>

" ======================================================
" END OF HARCODED PLUGINS
" ======================================================

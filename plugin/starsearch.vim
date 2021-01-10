" Name: starsearch
" Version: 0.1.1

if exists('loaded_starsearch')
	finish
endif
let loaded_starsearch = 1

let s:savedCpo = &cpo
set cpo&vim


function! s:VStarsearch_searchCWord()
	let wordStr = expand("<cword>")
	if strlen(wordStr) == 0
		echohl ErrorMsg
		echo 'E348: No string under cursor'
		echohl NONE
		return
	endif
	
	if wordStr[0] =~ '\<'
		let @/ = '\<' . wordStr . '\>'
	else
		let @/ = wordStr
	endif

	let savedUnnamed = @"
	let savedS = @s
	normal! "syiw
	if wordStr != @s
		normal! w
	endif
	let @s = savedS
	let @" = savedUnnamed
    call histadd("/",@/)
endfunction

" https://github.com/bronson/vim-visual-star-search/
function! s:VStarsearch_searchVWord()
	let savedUnnamed = @"
	let savedS = @s
	normal! gv"sy
	let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
	let @s = savedS
	let @" = savedUnnamed
    call histadd("/",@/)
endfunction

function! SearchCword_CountMatch()
    "get current position of your cursor
    let save_pos = getpos(".")

    "call VStarsearch_searchVWord in Vmode
    :call <SID>VStarsearch_searchCWord()
    "count matches use Ex command
    :%s ///gn
    "restore the position of your cursor
    :call setpos('.', save_pos)
endfunction

function! s:VsearchWord_CountMatch()
    "get current position of your cursor
    let save_pos = getpos(".")

    "call VStarsearch_searchVWord in Vmode
    :call <SID>VStarsearch_searchVWord()
    "count matches use Ex command
    :%s ///gn
    "restore the position of your cursor
    :call setpos('.', save_pos)
endfunction

nnoremap <silent> * :call SearchCword_CountMatch()<CR>:set hls<CR>
vnoremap <silent> * :<C-u>call <SID>VsearchWord_CountMatch()<CR>:set hls<CR>

let &cpo = s:savedCpo

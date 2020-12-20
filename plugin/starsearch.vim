" Name: Star search
" Author: Name5566 <name5566@gmail.com>
" Version: 0.1.1

if exists('loaded_starsearch')
	finish
endif
let loaded_starsearch = 1

let s:savedCpo = &cpo
set cpo&vim

function! Determine_initial_word_of_row()
    let cur_word_row_num = line(".")
    let cur_word_col_num = col(".")
    if cur_word_row_num == 1 && cur_word_col_num == 1
        let is_first_word = 1
    else
        norm ebb
        let pre_word_row_num = line(".")
        norm w
        if cur_word_row_num == pre_word_row_num
            let is_first_word = 0
        else
            let is_first_word = 1
        endif
    endif
    return is_first_word
endfunction

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
    let i = Determine_initial_word_of_row()
    if  i == 1
        :call <SID>VStarsearch_searchCWord()
        :%s ///gn
    else
        :call <SID>VStarsearch_searchCWord()
        :norm wb
        :%s ///gn
        :norm ``
    endif
    return i
endfunction

function! s:VsearchWord_CountMatch()
    let j = 0
    let cur_word_col_num = col(".")
    let i = Determine_initial_word_of_row()
    if  i == 1
        :call <SID>VStarsearch_searchVWord()
        :%s ///gn
    else
        :call <SID>VStarsearch_searchVWord()
        :%s ///gn
        :norm 0
        while j <= cur_word_col_num
            let j = j+1
            :norm l
        endwhile
    endif
    return cur_word_col_num
endfunction

nnoremap <silent> * :call SearchCword_CountMatch()<CR>:set hls<CR>
vnoremap <silent> * :<C-u>call <SID>VsearchWord_CountMatch()<CR>:set hls<CR>

let &cpo = s:savedCpo

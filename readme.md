# readme.md

## Introduction

**If you don't like the way vim jumps to the next match by default when the \* key is pressed, this vim plug-in will be a good choice.**

## Features

The plug provides two search modes with the * key.

* normal mode:

![normal mode](./pic/normal_mode.gif "normal mode")

Change the behavior of the super star(*) key. Vim don't jump to the next match when * is pressed. Also it would show how many matches there are for the current buffer.

* visual mode:

![visual](./pic/visual_mode.gif "visual")

Add * key support for visual mode. You can select some text (using visual mode) and then press * for searching (don't jump to the next match). Also it would show how many matches there are for the current buffer.

And, all searches will be stroed in the search history.

## Install

It is recommended to use [vim-plug](https://github.com/junegunn/vim-plug) to install the plug-in:
`Plug 'weiguoquan422/vim-starsearch'`

## Reference
https://www.vim.org/scripts/script.php?script_id=4335

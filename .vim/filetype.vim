" my filetype file
	if exists("did_load_filetypes")
	  finish
	endif
	augroup filetypedetect
	  au! BufRead,BufNewFile *.gf		setfiletype gf
	  au! BufRead,BufNewFile *.xyz		setfiletype drawing
	augroup END

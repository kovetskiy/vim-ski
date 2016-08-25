if !exists('g:skeletons_dir')
    let g:skeletons_dir = expand('<sfile>:p:h:h') . '/skeletons/'
endif

function! Skeleton()
    let filetype = &filetype
    let filename = expand("%")
    let skeletonPathFiletype = s:getSkeletonPath(filetype)
    let skeletonPathFilename = s:getSkeletonPath(filename)

    if filereadable(skeletonPathFilename)
       call feedkeys("i\<C-R>=SkeletonExpand('" . filename . "')\<CR>")
    elseif filereadable(skeletonPathFiletype)
       call feedkeys("i\<C-R>=SkeletonExpand('" . filetype . "')\<CR>")
    endif
endfunction!

command! -bar
    \ Skeleton
    \ call Skeleton()

function! SkeletonExpand(filetype)
    let skeleton = s:getSkeleton(a:filetype)
    return UltiSnips#Anon(skeleton)
endfunction!

function! s:getSkeletonPath(skeletonName)
    return g:skeletons_dir . a:skeletonName . '.skeleton'
endfunction!

function! s:getSkeleton(skeletonName)
    return join(readfile(s:getSkeletonPath(a:skeletonName)), "\n")
endfunction!

function! SetSkeletonFiletype()
    let filename = expand("%")
    let splitted = split(filename, "\\.")

    if len(splitted) >= 2
        let filetype = splitted[len(splitted) - 2]
        exec "set ft=" . filetype
    endif
endfunction!

command! -bar
    \ SetSkeletonFiletype
    \ call SetSkeletonFiletype()

augroup vim_ski
    au!
    au BufNewFile * Skeleton
    au BufNewFile,BufRead *.skeleton SetSkeletonFiletype
augroup end

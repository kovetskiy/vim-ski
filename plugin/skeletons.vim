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

au BufNewFile * Skeleton

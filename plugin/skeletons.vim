if !exists('g:skeletons_dir')
    let g:skeletons_dir = expand('<sfile>:p:h:h') . '/skeletons/'
endif

function! InitSkeleton()
    let filetype      = &filetype
    let skeletonPath = s:getSkeletonPath(filetype)

    if filereadable(skeletonPath)
       call feedkeys("i\<C-R>=Skeleton('" . filetype . "')\<CR>") 
    endif
endfunction!

function! Skeleton(filetype)
    let skeleton = s:getSkeleton(a:filetype)
    return UltiSnips#Anon(skeleton)
endfunction!

function! s:getSkeletonPath(filetype)
    return g:skeletons_dir . a:filetype . '.skeleton'
endfunction!

function! s:getSkeleton(filetype)
    return join(readfile(s:getSkeletonPath(a:filetype)), "\n")
endfunction!

au BufNewFile * call InitSkeleton()

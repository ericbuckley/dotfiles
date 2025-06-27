" ale_linters/python/ty.vim
" Author: Eric Buckley <https://github.com/ericbuckley>
" Description: ty type checking for Python files

call ale#Set('python_ty_executable', 'ty')
call ale#Set('python_ty_options', '')
call ale#Set('python_ty_use_global', get(g:, 'ale_use_global_executables', 0))
call ale#Set('python_ty_auto_pipenv', 0)
call ale#Set('python_ty_auto_poetry', 0)
call ale#Set('python_ty_auto_uv', 0)
call ale#Set('python_ty_change_directory', 1)

function! ale_linters#python#ty#GetExecutable(buffer) abort
    if (ale#Var(a:buffer, 'python_auto_pipenv') || ale#Var(a:buffer, 'python_ty_auto_pipenv'))
    \ && ale#python#PipenvPresent(a:buffer)
        return 'pipenv'
    endif

    if (ale#Var(a:buffer, 'python_auto_poetry') || ale#Var(a:buffer, 'python_ty_auto_poetry'))
    \ && ale#python#PoetryPresent(a:buffer)
        return 'poetry'
    endif

    if (ale#Var(a:buffer, 'python_auto_uv') || ale#Var(a:buffer, 'python_ty_auto_uv'))
    \ && ale#python#UvPresent(a:buffer)
        return 'uv'
    endif

    return ale#python#FindExecutable(a:buffer, 'python_ty', ['ty'])
endfunction

function! ale_linters#python#mypy#GetCwd(buffer) abort
    " Look upward for ty.toml or pyproject.toml
    for l:path in ale#path#Upwards(expand('#' . a:buffer . ':p:h'))
        if filereadable(l:path . '/ty.toml') || filereadable(l:path . '/pyproject.toml')
            return l:path
        endif
    endfor

    " Fallback to finding the Python project root
    let l:project_root = ale#python#FindProjectRoot(a:buffer)

    return !empty(l:project_root)
    \   ? l:project_root
    \   : expand('#' . a:buffer . ':p:h')
endfunction

function! ale_linters#python#ty#GetCommand(buffer) abort
    let l:executable = ale_linters#python#ty#GetExecutable(a:buffer)
    let l:exec_args = l:executable =~? '\(pipenv\|poetry\|uv\)$'
        \ ? ' run ty'
        \ : ''

    " ty check is the main command for type checking
    " Use --output-format=concise for structured text output
    return ale#Escape(l:executable) . l:exec_args
        \ . ' check'
        \ . ' --output-format=concise'
        \ . ale#Pad(ale#Var(a:buffer, 'python_ty_options'))
        \ . ' %s'
endfunction

function! ale_linters#python#ty#Handle(buffer, lines) abort
    let l:output = []

    if empty(a:lines)
        return l:output
    endif

    " Parse ty's concise output format
    " Format: error[code] filename:line:column: message
    for l:line in a:lines
        " Skip summary lines like "Found 1 diagnostic"
        if l:line =~# '^Found \d\+ diagnostic'
            continue
        endif
        
        let l:match = matchlist(l:line, '\v^(error|warning|info)\[([^\]]+)\]\s+([^:]+):(\d+):(\d+):\s*(.+)$')
        
        if !empty(l:match)
            let l:severity = l:match[1]
            let l:code = l:match[2]
            let l:filename = l:match[3]
            let l:lnum = str2nr(l:match[4])
            let l:col = str2nr(l:match[5])
            let l:text = l:match[6]
            
            " Only include errors for the current file
            let l:current_file = expand('#' . a:buffer . ':p')
            if fnamemodify(l:filename, ':p') ==# l:current_file
                call add(l:output, {
                    \ 'lnum': l:lnum,
                    \ 'col': l:col,
                    \ 'code': l:code,
                    \ 'text': l:text,
                    \ 'type': l:severity ==# 'error' ? 'E' : 'W',
                    \ 'sub_type': 'type',
                \})
            endif
        endif
    endfor

    return l:output
endfunction

call ale#linter#Define('python', {
    \ 'name': 'ty',
    \ 'executable': function('ale_linters#python#ty#GetExecutable'),
    \ 'command': function('ale_linters#python#ty#GetCommand'),
    \ 'callback': function('ale_linters#python#ty#Handle'),
    \ 'output_stream': 'both',
    \ 'lint_file': 1,
\})

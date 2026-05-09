" Incomplete Xcas vim syntax.
" Language: icas (Xcas / Giac)
" Author: Lacewing
" Date: 2026-03-05

if exists("b:current_syntax")
  finish
endif

syntax case match

" =====================
" Control structures
" =====================

syntax keyword icasControl
      \ if else
      \ for while repeat until do
      \ try catch
      \ break continue return
      \ local

" =====================
" Boolean constants
" =====================

syntax keyword icasBoolean true false

" =====================
" Statement terminators
" IMPORTANT: Order matters (longest first)
" =====================

" :;  (suppress output)
syntax match icasSilentTerm ":;"

" ;   (print output)
syntax match icasPrintTerm ";"

" =====================
" Assignment
" =====================

syntax match icasAssign ":="

" =====================
" Comparison operators
" =====================

syntax match icasOperator "=="
syntax match icasOperator "!="
syntax match icasOperator "<="
syntax match icasOperator ">="
syntax match icasOperator "[<>]"

" =====================
" Logical operators
" =====================

syntax match icasOperator "&&"
syntax match icasOperator "||"
syntax keyword icasOperator and or not
syntax match icasOperator "!"

" =====================
" Arithmetic operators
" =====================

syntax match icasOperator "[+\-*/^%]"

" =====================
" Delimiters
" =====================

syntax match icasDelimiter "[()\[\]{}.,]"

" =====================
" Numbers
" =====================

syntax match icasNumber "\v(\d+\.\d*|\d*\.\d+)([eE][+-]?\d+)?"
syntax match icasNumber "\v\d+[eE][+-]?\d+"
syntax match icasNumber "\v\<\d+\>"

" =====================
" Strings
" =====================

syntax region icasString start=+"+ skip=+\\\\\|\\"+ end=+"+

" =====================
" Comments
" =====================

syntax match icasComment "//.*$"
syntax region icasComment start="/\*" end="\*/"

" =====================
" Function names
" Word followed by '('
" =====================

syntax match icasFunction "\<[A-Za-z_]\w*\>\s*(\@="

" =====================
" Highlight links
" =====================

highlight default link icasControl      Statement
highlight default link icasBoolean      Boolean
highlight default link icasAssign       Operator
highlight default link icasOperator     Operator
highlight default link icasDelimiter    Delimiter
highlight default link icasNumber       Number
highlight default link icasString       String
highlight default link icasComment      Comment
highlight default link icasFunction     Function

" Distinguish statement endings visually
highlight default link icasPrintTerm    Special
highlight default link icasSilentTerm   SpecialChar

setlocal commentstring=//\ %s

let b:current_syntax = "icas"

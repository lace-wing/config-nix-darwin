" Simple Objdump Syntax
if exists("b:current_syntax")
  finish
endif

syntax match objdumpComment "\/\/.*$"

syntax match objdumpAddress "^\s*[0-9a-fA-F]\+:" nextgroup=objdumpOpcode skipwhite

syntax match objdumpOpcode "[0-9a-fA-F]\{2,}" contained nextgroup=objdumpInst skipwhite

syntax match objdumpInst "[a-zA-Z]\{2,}" contained

" Assign colors
highlight link objdumpComment Comment
highlight link objdumpAddress Identifier
highlight link objdumpOpcode Constant
highlight link objdumpInst Statement

let b:current_syntax = "objdump"

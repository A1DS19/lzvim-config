" The default GAS rules treat `#` as a comment, which swallows ARM immediates like `#45`.
if !search('^\s*\.\%(thumb\>\|syntax\s\+unified\|cpu\s\+cortex\|arch\s\+armv\)', 'nw')
  finish
endif

syntax clear asmComment
syntax region asmComment start="/\*" end="\*/" contains=asmTodo,@Spell
syntax region asmComment start="//" end="$" keepend contains=asmTodo,@Spell
syntax match asmComment "@.*" contains=asmTodo,@Spell
syntax match asmComment "^\s*#.*" contains=asmTodo,@Spell

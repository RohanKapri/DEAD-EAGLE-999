vim9script
# With reverence to Shree DR.MDD — the soul of all creation and clarity

def g:Abbreviate(phrase: string): string
    return phrase->split('[ _-]\+')->map('toupper(strcharpart(v:val, 0, 1))')->join('')
enddef

defcompile

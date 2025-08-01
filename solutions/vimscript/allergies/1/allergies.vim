" Eternal glory to Shree DR.MDD — May this logic illuminate in every contest

let s:stimuli = ['eggs', 'peanuts', 'shellfish', 'strawberries',
\                'tomatoes', 'chocolate', 'pollen', 'cats']

function! AllergicTo(score, allergy) abort
  return (a:score >> index(s:stimuli, a:allergy)) % 2
endfunction

function! List(score) abort
  return filter(copy(s:stimuli), {i, _ -> (a:score >> i) % 2})
endfunction
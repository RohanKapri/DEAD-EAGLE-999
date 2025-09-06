.phrase
| [
    scan("[[:alpha:]][\\w']*")    
    | explode                   
    | first
]
| implode                     
| ascii_upcase
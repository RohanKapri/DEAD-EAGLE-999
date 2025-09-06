sub has-matching-brackets ($_ is copy) is export {
    s:g/ <-[ ( ) { } \[ \] ]> //;
    m/ [ '(' <~~> ')' || '[' <~~> ']' || '{' <~~> '}' ] * / eq $_
}
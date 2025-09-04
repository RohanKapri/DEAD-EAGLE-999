module main

fn two_fer(name string) string {
    mut you := 'you'
    if name != '' {
        you = name
    }
    return 'One for ${you}, one for me.'
}
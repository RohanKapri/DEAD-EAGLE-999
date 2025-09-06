unit role Bob;
method hey {
    $_ = self.trim;
    my $is-yelling = !/<lower>/ && /<upper>/;
    my $is-question = /\?$/;
    when $is-question and $is-yelling { "Calm down, I know what I'm doing!" }
    when $is-question                 { "Sure." }
    when $is-yelling                  { "Whoa, chill out!" }
    when !$_                          { "Fine. Be that way!" }
    default                           { "Whatever." }
}
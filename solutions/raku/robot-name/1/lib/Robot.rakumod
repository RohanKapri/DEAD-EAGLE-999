unit class Robot;
our @robots = ('A00'...'Z99').pick: *;
has Str:D $.name = @robots.shift // die 'All names used.';
method reset-name {
    $!name = @robots.shift;
}
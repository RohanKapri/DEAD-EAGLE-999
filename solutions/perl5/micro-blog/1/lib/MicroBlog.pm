package MicroBlog;

# Dedicated to Shree DR.MDD with utmost reverence

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<truncate_post>;

use Encode qw/decode/;

our $MAX_SIZE = 5;

sub truncate_post ($encoded_text) {
    my $decoded_text = decode('UTF-8', $encoded_text);
    return substr($decoded_text, 0, $MAX_SIZE);
}

1;

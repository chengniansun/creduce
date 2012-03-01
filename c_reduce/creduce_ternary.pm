#!/usr/bin/perl -w

package creduce_ternary;

use Regexp::Common;
use re 'eval';
use Exporter::Lite;

@EXPORT      = qw(ternary1 ternary2);

use strict;

use creduce_regexes;
use creduce_utils;

my $replace_cont;
sub replace_aux ($$$) { 
    my ($index,$original,$replacement) = @_;
    $replace_cont++;
    return ($replace_cont == $index) ? $replacement : $original;
}

sub ternary1 ($$) {
    (my $cfile, my $index) = @_;

    my $string = read_file ($cfile);
    my $string2 = $string;

    $replace_cont = -1;
    $string2 =~ s/(?<all>(?<del1>$borderorspc)(?<a>$varnumexp)\s*\?\s*(?<b>$varnumexp)\s*:\s*(?<c>$varnumexp)(?<del2>$borderorspc))/replace_aux($index,$+{all},$+{del1}.$+{b}.$+{del2})/eg;

    if ($string ne $string2) {
	write_file ($cfile, $string2);
	return $SUCCESS;
    } else {
	return $STOP;
    }
}

sub ternary2 ($$) {
    (my $cfile, my $index) = @_;

    my $string = read_file ($cfile);
    my $string2 = $string;

    $replace_cont = -1;
    $string2 =~ s/(?<all>(?<del1>$borderorspc)(?<a>$varnumexp)\s*\?\s*(?<b>$varnumexp)\s*:\s*(?<c>$varnumexp)(?<del2>$borderorspc))/replace_aux($index,$+{all},$+{del1}.$+{c}.$+{del2})/eg;

    if ($string ne $string2) {
	write_file ($cfile, $string2);
	return $SUCCESS;
    } else {
	return $STOP;
    }
}

1;
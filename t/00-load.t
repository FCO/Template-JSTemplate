#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Template::JSTemplate' ) || print "Bail out!\n";
}

diag( "Testing Template::JSTemplate $Template::JSTemplate::VERSION, Perl $], $^X" );

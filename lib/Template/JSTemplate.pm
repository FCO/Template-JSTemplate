package Template::JSTemplate;

use 5.006;
use strict;
use warnings;

use JavaScript::V8;
use JSON;

=head1 NAME

Template::JSTemplate - The great new Template::JSTemplate!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Template::JSTemplate;

    my $foo = Template::JSTemplate->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 new

=cut

my $path2template_js = "../Template-JSTemplate/JSTemplate/Template.js";

$Template::JSTemplate::js_context = JavaScript::V8::Context->new();

open my $TMPL_CODE, "<", $path2template_js || die $!;
$Template::JSTemplate::js_context->eval(join $/, <$TMPL_CODE>);
close $TMPL_CODE;

$Template::JSTemplate::js_context->eval("var TEMPLATES = {}");

sub new {
	my $class = shift;
	my %pars;
	if(@_ == 1) {
		$pars{template_data} = shift;
	} else {
		%pars  = @_;
	}

	if($pars{template_path}) {
		open(my $TMPL, "<", $pars{template_path}) || die "template_path error: " . $!;
		$pars{template_data} = join $/, <$TMPL>;
		close $TMPL;
	}
	my $self = bless {}, $class;
	$pars{template_data} =~ s{\n}{\\\n}g;
	$Template::JSTemplate::js_context->eval("TEMPLATES['$self'] = new Template('$pars{template_data}')");
	die "Template error: " . $@ if $@;
	$self
}

=head2 render

=cut

sub render {
	my $self = shift;
	my $data = to_json(shift);

	my $ret = $Template::JSTemplate::js_context->eval("TEMPLATES['$self'].render($data)");
	die $@ if $@;
	$ret
}

=head1 AUTHOR

Fernando Correa de Oliveira, C<< <fco at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-template-jstemplate at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Template-JSTemplate>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Template::JSTemplate


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Template-JSTemplate>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Template-JSTemplate>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Template-JSTemplate>

=item * Search CPAN

L<http://search.cpan.org/dist/Template-JSTemplate/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Fernando Correa de Oliveira.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Template::JSTemplate

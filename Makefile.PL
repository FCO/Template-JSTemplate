use inc::Module::Install;

name     'Template-JSTemplate';
all_from 'lib/Template/JSTemplate.pm';
author   q{Fernando Correa de Oliveira <fco@cpan.org>};
license  'perl';

build_requires 'Test::More';

install_share "JSTemplate";
auto_install;

WriteAll;


use inc::Module::Install;

name     'Template-JSTemplate';
all_from 'lib/Template/JSTemplate.pm';
author   q{Fernando Correa de Oliveira <fco@cpan.org>};
license  'perl';

install_share 'share';
build_requires 'Test::More';
requires 'JavaScript::V8' => 0;
requires 'File::ShareDir' => 0;

auto_install;

WriteAll;


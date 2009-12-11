use inc::Module::Install;
name 'Any-MooseX-ConfigFromFile';
all_from 'lib/Any/MooseX/ConfigFromFile.pm';
readme_from 'lib/Any/MooseX/ConfigFromFile.pm';

#requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;

package Any::MooseX::ConfigFromFile;
use Any::Moose '::Role';
use Any::Moose 'X::Types::Path::Class' => [qw( File )];

our $VERSION = '0.01';

requires 'get_config_from_file';

has configfile => (
    is => 'ro',
    isa => File,
    coerce => 1,
    predicate => 'has_configfile',
);

sub new_with_config {
    my ($class, %opts) = @_;

    my $configfile;

    if(defined $opts{configfile}) {
        $configfile = $opts{configfile}
    }
    else {
        my $cfmeta = $class->meta->get_attribute('configfile');
        $configfile = $cfmeta->default if $cfmeta->has_default;
    }

    if(defined $configfile) {
        %opts = (%{$class->get_config_from_file($configfile)}, %opts);
    }

    $class->new(%opts);
}

no Any::Moose '::Role';
1;

1;
__END__

=head1 NAME

Any::MooseX::ConfigFromFile - MooseX::ConfigFromFile for Any::Moose

=head1 SYNOPSIS

  ########
  ## A real role based on this abstract role:
  ########

  package Any::MooseX::SomeSpecificConfigRole;
  use Any::Moose '::Role';
  
  with 'Any::MooseX::ConfigFromFile';
  
  use Some::ConfigFile::Loader ();

  sub get_config_from_file {
    my ($class, $file) = @_;

    my $options_hashref = Some::ConfigFile::Loader->load($file);

    return $options_hashref;
  }


  ########
  ## A class that uses it:
  ########
  package Foo;
  use Any::Moose;
  with 'Any::MooseX::SomeSpecificConfigRole';

  # optionally, default the ConfigFile::Loader  has +configfile ( default => '/tmp/foo.yaml' );

  # ... insert your stuff here ...

  ########
  ## A script that uses the class with a configfile  ########

  my $obj = Foo->new_with_config(configfile => '/etc/foo.yaml', other_opt => 'foo');

=head1 SEE ALSO

L<MooseX::ConfigFromFile>

=head1 AUTHOR

Kazuhiro Osawa E<lt>yappo <at> shibuya <döt> plE<gt>

And L<MooseX::ConfigFromFile> author Brandon L. Black

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

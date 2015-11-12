{{
    $name = $dist->name =~ s/-/::/gr; ''
}}package {{ $name }}::Builder;

use Moose;
use File::ShareDir;
extends 'OpusVL::Website::Builder';

override _build_plugins => sub {
    my $plugins = super();

    push @$plugins, qw/
    /;

    return $plugins;
};

override _build_config => sub 
{
    my $self   = shift;
    my $config = super();

    $config->{'Controller::Login'} =
    {
        traits => '+OpusVL::FB11::TraitFor::Controller::Login::NewSessionIdOnLogin',
    };

    $config->{'View::CMS::Page'}->{AUTO_FILTER} = 'html';

    return $config;
};

1;

=head1 NAME

{{ $name }}::Builder

=head1 DESCRIPTION



=head1 METHODS

=head1 ATTRIBUTES


=head1 LICENSE AND COPYRIGHT

Copyright 2015 OpusVL.

This software is licensed according to the "IP Assignment Schedule" provided with the development project.

=cut


package TestApp::Builder;
use Test::PostgreSQL;

use Moose;
extends 'OpusVL::FB11::Builder';

# Just keep it in scope until the process ends.
our $PSQL;


override _build_superclasses => sub
{
  return [ 'OpusVL::FB11' ]
};

override _build_plugins => sub {
    my $plugins = super(); # Get what CatalystX::AppBuilder gives you

    push @$plugins, qw(
        +{{ $dist->name =~ s/-/::/gr }}
    );

    return $plugins;
};

override _build_config => sub {
    my $self   = shift;
    my $config = super(); # Get what CatalystX::AppBuilder gives you
    $PSQL = Test::PostgreSQL->new
        or die $Test::PostgreSQL::errstr;



    # point the FB11AuthDB Model to the temporary database
    $config->{'Model::FB11AuthDB'} = {
        schema_class => 'OpusVL::FB11::Schema::FB11AuthDB',
        connect_info => [ $PSQL->dsn ],
        on_connect_do => 'SET client_min_messages=WARNING',
    };

    # .. add static dir into the config for Static::Simple..
    my $static_dirs = $config->{static}->{include_path};
    unshift(@$static_dirs, TestApp->path_to('root'));
    $config->{static}->{include_path} = $static_dirs;
    
    # .. allow access regardless of ACL rules...
    $config->{'fb11_can_access_actionpaths'} = ['custom/custom'];

    # DEBUGIN!!!!
    $config->{'fb11_can_access_everything'} = 1;
    
    $config->{application_name} = 'FB11 TestApp';
    $config->{default_view}     = 'FB11TT';
    
    return $config;
};

1;

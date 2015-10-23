package TestApp::Builder;

use Moose;
extends 'OpusVL::FB11::Builder';

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

    # point the FB11Auth Model to the correct DB file....
    $config->{'Model::FB11AuthDB'} = 
    {
        schema_class => 'OpusVL::FB11::Schema::FB11AuthDB',
        connect_info => [
          'dbi:SQLite:' . TestApp->path_to('root','fb11-auth.db'),
        ],
    };

    # .. add static dir into the config for Static::Simple..
    my $static_dirs = $config->{static}->{include_path};
    unshift(@$static_dirs, TestApp->path_to('root'));
    $config->{static}->{include_path} = $static_dirs;
    
    # .. allow access regardless of ACL rules...
    $config->{'appkit_can_access_actionpaths'} = ['custom/custom'];

    # DEBUGIN!!!!
    $config->{'appkit_can_access_everything'} = 1;
    
    $config->{application_name} = 'FB11 TestApp';
    $config->{default_view}     = 'FB11TT';
    
    return $config;
};

1;

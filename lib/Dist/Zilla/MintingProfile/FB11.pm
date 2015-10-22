package Dist::Zilla::MintingProfile::FB11;

# ABSTRACT: Mints a new FB11 site

our $VERSION = '0.002';
use Moose;
with 'Dist::Zilla::Role::MintingProfile';
use File::ShareDir;
use Path::Class;        # sadly, we still need to use Path::Class :(
use Carp;
use namespace::autoclean;

sub profile_dir
{
    my ($self, $profile_name) = @_;

    die 'minting requires perl 5.014' unless $] >= 5.013002;

    my $dist_name = '{{ $dist->name }}';
    my $profile_dir = dir( File::ShareDir::dist_dir($dist_name) )
                      ->subdir( 'profiles', $profile_name );

    return $profile_dir if -d $profile_dir;

    confess "Can't find profile $profile_name via $self: it should be in $profile_dir";
}

__PACKAGE__->meta->make_immutable;

1;

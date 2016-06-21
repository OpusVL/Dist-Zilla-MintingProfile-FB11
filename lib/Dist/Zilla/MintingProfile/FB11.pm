package Dist::Zilla::MintingProfile::FB11;

# ABSTRACT: Mints a new FB11 site

our $VERSION = '0.008';
use Moose;
use 5.014;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';
use File::ShareDir;
use Path::Class;        # sadly, we still need to use Path::Class :(
use Carp;
use namespace::autoclean;

around profile_dir => sub
{
    my ($orig, $self, $profile_name) = @_;

    $profile_name ||= 'default';

    return $self->$orig($profile_name);
};

__PACKAGE__->meta->make_immutable;

1;

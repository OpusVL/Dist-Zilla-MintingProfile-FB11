package Dist::Zilla::MintingProfile::FB11;

# ABSTRACT: Mints a new FB11 site

our $VERSION = '0.010';
use Moose;
use 5.014;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';
use namespace::autoclean;

__PACKAGE__->meta->make_immutable;

1;

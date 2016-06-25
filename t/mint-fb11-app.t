use strictures 2;
use autodie;
use File::Temp qw/tempdir/;
use Test::Most;
use Cwd;
use Path::Tiny;
use Config;
use FindBin q/$Bin/;


my $dir = tempdir( CLEANUP => 1 );
my $olddir = getcwd();
chdir($dir);
explain $dir;

my $perl_path = path($^X)->parent;
$ENV{PERL5LIB} = join ($Config{path_sep}, @INC, "$Bin/../lib");

my $dzil =$perl_path->child('dzil')->stringify;
system($dzil, qw/new -P FB11 My::App/);

havedir('My-App');
chdir('My-App');
havedir('lib/My/App');
havepath('lib/My/App.pm');
havepath('lib/My/App/Builder.pm');

my $prove =$perl_path->child('prove')->stringify;
ok(system($prove, "-l", 't') == 0);

chdir($olddir);

done_testing();

sub havedir { my $path = shift; ok((-d $path), "directory: $path") }
sub havepath { my $path = shift; ok((-e $path), "should exist: $path") }



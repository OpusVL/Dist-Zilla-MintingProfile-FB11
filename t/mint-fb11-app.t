use strictures 2;
use autodie;
use File::Temp qw/tempdir/;
use Test::Most;
use Cwd;
use Test::DZil;
use Path::Tiny;


my $dir = tempdir( CLEANUP => 1 );
my $olddir = getcwd();
chdir($dir);

my $tzil = Minter->_new_from_profile(
    [ 'FB11' ],
    { name => 'My-App', },
    { global_config_root => path($dir)->absolute },
);
$tzil->chrome->logger->set_debug(1);
$tzil->mint_dist;
#system(qw/dzil new -P FB11 My::App/);

my $mint_dir = path($tzil->tempdir)->child('mint');
havedir($mint_dir);
chdir($mint_dir);
havedir('lib/My/App');
havepath('lib/My/App.pm');
havepath('lib/My/App/Builder.pm');

use App::Prove;
my $tests = App::Prove->new;
$tests->process_args(qw/-l t/);

ok($tests->run == 0);

chdir($olddir);

done_testing();

sub havedir { my $path = shift; ok((-d $path), "directory: $path") }
sub havepath { my $path = shift; ok((-e $path), "should exist: $path") }



#! C:\Dwimperl\perl\bin\perl.exe -w

use strict;
use FindBin;
use File::Find ();

# Set the variable $File::Find::dont_use_nlink if you're using AFS,
# since AFS cheats.

use vars qw/*name *dir *prune/;
*name  = *File::Find::name;
*dir   = *File::Find::dir;
*prune = *File::Find::prune;
my $pkg = bless {}, __PACKAGE__;

$pkg->main();
exit(0);

sub main {
    my $self      = shift;
    my $base_path = $FindBin::RealBin;
    my $shot_file = "$base_path/screenshot_list.txt";
    open my $FH, ">", $shot_file || die "Refusing to open $shot_file: $!";
    File::Find::find(
        {
            wanted => sub {
                ( my ( $dev, $ino, $mode, $nlink, $uid, $gid ) =
                         lstat($_)
                      && -d _
                      && /^screenshots\z/s
                      && print $FH "$name\n" );
              }
        },
        'D:\\games'
    );
    close $FH;
    return 0;
}

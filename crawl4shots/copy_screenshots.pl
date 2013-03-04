#! C:\Dwimperl\perl\bin\perl.exe -w

use strict;
use warnings;

use File::Copy;
use FindBin;

my $pkg = bless {}, __PACKAGE__;

$pkg->main();
exit(0);

sub main {
    my $self      = shift;
    my $base_path = $FindBin::RealBin;
    my $dest_dir  = "$base_path/screenshot_dest";
    my $shot_file = "$base_path/screenshot_list.txt";
    my $text      = do { local ( @ARGV, $/ ) = $shot_file; <> };
    foreach my $dir ( split( /\n/, $text ) ) {
        $dir =~ s/ /\\ /gs;
        foreach my $file ( glob("$dir/*.jpg") ) {
            $file =~ m/.*\/(.*)$/;
            my $name = $1;
            copy $file, "$dest_dir/$name" || die "Copy $file failed: $!";
            unlink $file;
        }
    }
    return 0;
}

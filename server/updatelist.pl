use 5.010;
use JSON::XS;
use File::Slurp 'slurp';
use Try::Tiny;
use LWP::Simple;
use autodie;
getstore 'https://github.com/perl6/ecosystem/raw/master/META.list',
         'metalist';

my @modules;

open my $fh, '<', "metalist";
for(<$fh>) {
    chomp;
    try {
        print "$_ ";
        say getstore($_, 'tmp');
        my $hash = decode_json slurp 'tmp';
        push @modules, $hash;
    };
    unlink 'tmp' if -e 'tmp';
}
close $fh;
#unlink 'metalist';

open($fh, '>', "/home/tjs/modules/public/projects.json");

print $fh encode_json \@modules;
close $fh;

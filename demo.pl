#/usr/bin/perl -w
my $string = 'aattgcgccc';
print $string."\n";
$string=~ tr/atcg/tagc/;
my $string2=reverse $string;
print $string2."\n";

#usr/bin/perl -w
my ($file) = @ARGV;
open IN, "$file" or die "$!";
while (<IN>) {
	if (/\s+(\w+\/v)\s+(\w+\/v/) {
		my $word = $1;
		my $trans = $2;
		print "$word\t$trans\n"
	}
}

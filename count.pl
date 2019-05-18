#usr/bin/perl -w
########################################################
##### 
#####	mirRNA 测序数据比对到 Rfam数据库，统计total reads 中各类 RNA的数量 
#####
#####
########################################################
use strict;
my @file = glob "*mapped.sam";
#print "@file\n";
use Cwd;
my $dir = cwd;
mkdir "information";
chdir "information";
my %hash;
for (0 .. $#file) {
	open IN,"$dir/$file[$_]" or die "$!";
	open OUT,">$file[$_].count" or die "$!";

	# 针对多分支匹配，我首先想到的是 if-elsif-else 结构
	
	# while (defined(my $line = <IN>)) {
	# 	my $tmp = (split(/\t/,$line))[2];
	# 	if ($tmp =~ /tRNA/i) {
	# 		$hash{'tRNA'} += 1; 
	# 	}elsif ($tmp =~ /mir/i) {
	# 		$hash{'mirRNA'} += 1;
	# 	}elsif ($tmp =~ /rRNA/i) {
	# 		$hash{'rRNA'} += 1;
	# 	}elsif ($tmp =~ /SNOR/i) {
	# 		$hash{'snoRNA'} += 1;
	# 	}else{
	# 		$hash{'others'} += 1;
	# 	}

	# }
	
	# 针对多分支匹配，perl中有个更好的工具 (用given-when)
	while (defined(my $line = <IN>)) {
		my $tmp = (split(/\t/,$line))[2];
		given ($tmp) {
			when (/tRNA/i) {$hash{'tRA'} += 1}
			when (/mir/i)  {$hash{'mirRNA'} += 1}
			when (/rRNA/i) {$hash{'rRNA'} += 1}
			when (/SNOR/i) {$hash{'snoRNA'} += 1}
			default {$hash{'others'} += 1};
		};
	

	print OUT "$file[$_]\n";
	foreach my $k(sort keys %hash) {
		print OUT "$k\t$hash{$k}\n";
	}
	close IN;
	close OUT;
	%hash = ();
	
}




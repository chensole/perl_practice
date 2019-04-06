#/usr/bin/perl -w
####################################################################
##2019-4-6
##代码解决的问题:从gff文件中获取基因信息和转录本信息
##步骤:1.以gene名为key值建立哈希;2.gene名value是一个匿名哈希，包括四个key值，chr,start,end,transcript,其中transcript的value是一个匿名数组，数			##组，且数组内的每一个元素为一个匿名哈希（一个数组内包含多个转录本信息）
##出现的问题:1.几天没写代码,把@ARGV写成了@ARGS!!!; 2.${hash}{$1}= 写成了$hash{$1}->,20行代码目的是通过引用建立数据结构，而不是对数据解引用。
##
##总结:多敲，细节问题还得注意
####################################################################
my ($file) = @ARGV;
#use Data::Dumper;
open IN,"$file" or die "$!";
my %hash;
while (my $line=<IN>) {
	chomp($line);
	next if ($line=~/^#/);
	my @tmp = split("\t",$line);
	if ($tmp[2] eq "gene") {
		if ($tmp[8]=~/gene_id "([^;]+)"/) {
			$hash{$1}={"chr"=>$tmp[0],"start"=>$tmp[3],"end"=>$tmp[4]};
		}
	}
	if ($tmp[2] eq "transcript") {
		if ($tmp[8]=~/gene_id "([^;]+)".*transcript_id "([^;]+)"/) {
			if (defined $hash{$1}) {
				push @{$hash{$1}->{'transcript'}},{"mrnaID"=>$2,"start"=>$tmp[3],"end"=>$tmp[4]};
			
			
			}
		
		
		}
		
	
	}
}

close IN;
#print Dumper(%hash);
foreach $keys(keys %hash) {
	#print "$keys\t$hash{$keys}->{'chr'}\t$hash{$keys}->{'start'}\t$hash{$keys}->{'end'}\n";
	print "$keys\t${$hash{$keys}{'transcript'}}[0]->{'mrnaID'}\t${$hash{$keys}{'transcript'}}[0]->{'start'}\t${$hash{$keys}{'transcript'}}[0]->{'end'}\n";
	
}

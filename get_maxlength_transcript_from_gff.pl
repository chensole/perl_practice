#/usr/bin/perl -w
############################################################
#2019-4-2
#代码解决的问题:从gff文件获取每个基因所对应的不同转录本信息，并且获取每个基因中最长转录本的ID
#测试数据是human_hg38文件
#数据结构:嵌套哈希
#步骤:1.构造嵌套哈希
#     2.对哈希的key进行排序 (这个步骤代码的实现弄了一会，吃完饭回来想通了！！！！)
#     3.输出所得结果
############################################################
my ($file) = @ARGV;
open IN,"$file" or die "$!";
my %geneinfo;
#思路:1.先构造哈希的嵌套结构，外层哈希key为geneID,内层哈希key为transcriptID,value为转录本长度
while (my $line=<IN>) {
	chomp($line);
	my @tmp=split(/\t/,$line);
	if ($tmp[2] eq "transcript") {
		if($tmp[8]=~ /gene_id "([^;]+)".*transcript_id "([^;]+)"/) {
			${geneinfo{$1}}{$2}=$tmp[4]-$tmp[3];
		}
	}

}
close IN;
#my $result;
my %maxhash;
#my $maxlen;
#思路:2.对内层哈希key值以对应的value(即转录本长度)值从大到小的排序,从而得到最长转录本的ID值.－－－－－>达到目的
foreach $k(keys %geneinfo) {
		#print "geneID:$k\n";
		#用value值对key进行排序
		my @transcripts =sort {$geneinfo{$k}->{$b}<=>$geneinfo{$k}->{$a}}keys %{$geneinfo{$k}};
		my $maxid =shift(@transcripts);
		my $maxlen =$geneinfo{$k}->{$maxid};
		$maxhash{$maxid}=$maxlen;
		
		#第一次用下面这串代码尝试取出最大的key值，效果不好，有bug。心塞！！！！还是上面这串代码简洁
#		my @transcript=keys %{$geneinfo{$k}};
#		my @length=map {$geneinfo{$k}->{$_}}keys %{$geneinfo{$k}};
#		
#		my $maxid=shift(@transcript);
#		foreach (@transcript) {
#			
#			if ($geneinfo{$k}->{$_} > $geneinfo{$k}->{$maxid}) {
#			
#				$maxid=$_;
#			}else {
#				shift(@transcript);
			
#			}
		
#			$result=$maxid;
#			$maxlen=$geneinfo{$k}->{$result};
#	}
#		$maxhash{$result}=$maxlen;
#
#	foreach(keys %{$geneinfo{$k}}) {
#		print "transcriptID:$_\t$geneinfo{$k}->{$_}\n";
#	}
#		print "\n";
}

foreach (keys %maxhash) {

	print "$_\t$maxhash{$_}\n"


}


#####################################总结###################################################
#perl的哈希结构能非常高效的处理问题；
#反思：由于刚开始想着用迭代的方法取得最长转录本长度所对应的transcriptID,一方面代码看着啰嗦，另一方面不高效。后来想到可以先对内层哈希以value值#从大到小排序，然后直接用shift函数取出最大的转录本长度所对应的key值。
#
#
#					解决问题的时候：1.确定所要构造的数据结构；2.确定解决问题的主要步骤；3.编写程序
#
#
#
#
#





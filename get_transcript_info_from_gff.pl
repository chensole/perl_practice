#/usr/bin/perl -w
#############################################
#2019-4-2
#代码解决的问题:根据gff文件统计每个基因所有转录本的长度信息
#测试数据:human_hg38.gff
#构造数据结构:哈希的嵌套结构
#步骤:1.读入文件　
#　　 2.构造数据
#     3.两个foreach循环将复合哈希打印出来
##############################################

my ($file) = @ARGV;
open IN,"$file" or die "$!";
my %geneinfo;
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
foreach(keys %geneinfo) {
	foreach(keys %{$geneinfo{$k}}) {
		print "transcriptID:$_\t$geneinfo{$k}->{$_}\n";
	}
		print "\n";
}




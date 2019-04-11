#/usr/bin/perl -w
#################################
#统计物种基因长度
#2019-4-11

use Bio::SeqIO;
use Bio::Seq;
my ($file)=@ARGV;
my $file =Bio::SeqIO->new(-file=>$ARGV[0],-format=>'fasta');
my $count=0;
while(my $obj=$file->next_seq) {
	$count=$count+$obj->length;

}
print $count;

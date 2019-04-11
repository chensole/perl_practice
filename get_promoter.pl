#/usr/bin/perl -w
use strict;
use Bio::SeqIO;
use Bio::Seq;
my ($file,$location,$results) = @ARGV;
my %hash;
my $seq=Bio::SeqIO->new(-file=>"$ARGV[0]",-format=>'fasta');
my $results=Bio::SeqIO->new(-file=>">$ARGV[2]",-format=>'fasta');
while (my $seqobj=$seq->next_seq) {
	my($id,$seq)=($seqobj->id,$seqobj->seq);
	$hash{$id}=$seqobj;

}
#print $hash{"1"}->seq."\n";
#my @keys=keys %hash;
#print "@keys"
open IN,"$ARGV[1]" or die "$!";
while (<IN>) {
	chomp;
	my @tmp=split;
	my $seqobj1=$hash{$tmp[1]};
	my $len=$seqobj1->length;
	if($tmp[4] eq "+") {
		if (($tmp[2]-1500)<0) {
			my $seq2=$seqobj1->subseq(0,$tmp[2]);
			my $seqobj2=Bio::Seq->new(-seq=>$seq2,-id=>$tmp[0]);
			$results->write_seq($seqobj2);
		
		}else{
		my $proseq=$seqobj1->subseq($tmp[2]-1500,$tmp[2]);
		my $proseqobj=Bio::Seq->new(-seq=>$proseq,-id=>$tmp[0]);
		$results->write_seq($proseqobj);
	}
	}else {
		if (($tmp[3]+1500)>$len) {
			my $seq3=$seqobj1->subseq($tmp[3],$len);
			my $seqobj3=Bio::Seq->new(-seq=>$seq3,-id=>$tmp[0]);
			$results->write_seq($seqobj3);
		
		}else{
		my $rev=$seqobj1->revcom;
		my $proseq1=$rev->subseq($tmp[3],$tmp[3]+1500);
		my $proseqobj1=Bio::Seq->new(-seq=>$proseq1,-id=>$tmp[0]);
		$results->write_seq($proseqobj1);
	}
}

}
close IN;
$seq->close();
$results->close();







#usr/bin/perl -w
use Bio::Seq;
#just make a Bioseq object
my $seq_obj = Bio::Seq->new(-seq=>'aaatttgcgctt',
							-alphabet=>'dna');
print $seq_obj->seq."\n";

my $seq_obj1 = Bio::Seq->new(-seq=>'aaattccggg',-alphabet=>'dna',-display_id=>"#1234",-desc=>'example sequence');
print $seq_obj1->seq()."\n";

# write a sequence to a file
#make a fasta bioseqIO object
use Bio::SeqIO;
my $seqio_obj = Bio::SeqIO->new(-file=>'>>sequence.fasta',-format=>'fasta');
$seqio_obj->write_seq($seq_obj);

#make a genebank bioseqIO object
my $seqio_obj1 = Bio::SeqIO->new(-file=>'>>seqence.genebank',-format=>'genbank');
$seqio_obj1->write_seq($seq_obj);

# retrleving a sequence from a file
my $seqio_obj2 =Bio::SeqIO->new(-file=>'sequence.fasta',-format=>'fasta');
my $seq_obj2=$seqio_obj2->next_seq;
print $seq_obj2->seq;

#if have multiple sequence in the input file,you can call next_seq() in a loop
while (my $seq_obj3=$seqio_obj2->next_seq) {
	print $seq_obj3->seq."\n";
}


# retrleving multiple sequences from a database
#use Bio::DB::Query::GenBank;
#use Bio::DB::Genbank;
#my $query="Arabidopsis[ORGN] AND topoisomerase[TITL] and 0:3000[SLEN]";
#my $query_obj=Bio::DB::Query::GenBank->new(-db=>'nucleotide',-query=>$query);
#my $gb_obj=Bio::DB::Query::GenBank->new;
#$stream_obj=$gb_obj->get_Stream_by_query($query_obj);
#while(my $seq_obj4=$stream_obj->next_seq) {
#	print $seq_obj4->display_id,"\t",$seq_obj4->lenght,"\n";
#
#}

# 关于seqobj对象的处理函数
#获得反向互补序列(先生成一个bioseq object)
	my $revom=$seq_obj2->revcom;
	print $revom->seq."\n";

#获得序列长度
	print $seq_obj2->length."\n";

#获取序列字符串
	print $seq_obj2->seq."\n";

#截取序列(有两个函数,subseq和trunc)
	print $seq_obj2->subseq(1,4)."\n"; #subseq得到一个字符串

	my $new_obj=$seq_obj2->trunc(1,5);
	print $new_obj->seq."\n";

#翻译序列
	my $pro_obj = $seq_obj2->translate;
	print $pro_obj->seq."\n";

#也可以设定翻译起始位置默认是翻译第一个阅读框(指定-frame) -frame=0表示从第一个核苷酸开始翻译
#如果想翻译整个CDS序列,translate需要检查开放阅读框的起始子和终止子是否正好是序列的起始和终止，并且序列中间无终止密码子，需要设定-complete=1
#如果完整编码序列的条件不满足，会给出警告信息，设定-throw=1
#translate也能找到开放阅读框，默认从第一个起始密码在开始翻译,设定-orf=1
#当-orf=1时，可设定起始密码子，默认是atg,通过-start="aug"可以修改

#!usr/bin/perl -w
### 2019-5-11
### 实现打印一行固定字符后换行

use strict;
open IN,"a" or die "$!";
my $line = <IN>;
$line =~ s/(\w{10})/$1\n/g;
print "$line";

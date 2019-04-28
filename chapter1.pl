#!/usr/bin/perl -w
## basic perl###
use strict;
#use warnings;
## single element and slice
	my @array = (1,2,3,5);
	my $a = $array[1];
	my @a = @array[1,2,3]; #slice

	print $a,"\n";
	print "@a\n";


	my %hash = ("a",1,"b",2,"c",3);
	my @key = @hash{"a","b"}; #slice 
	print "@key\n";





## list and array is different
	
	# 不同点是，array在标量上下文中，返回数组中元素的个数；list在标量上下文中，不能返回list中元素的个数，返回的是list中的最后一个元素

	# a list is an ordered collection of scalars 
	# an array is a variable that contains a list,but isn't list itself
	# we can assign a list to an array or using it in a foreach loop

	# 当逗号操作符位于标量上下文时，将返回逗号操作符最右边的元素赋值给scalar variable
	# （'a','b','c'）逗号操作符创建 list

	# 因此，要注意列表不能赋予一个标量
	# what if assign the literal text to a scalar variable?
	my $b = ('bsf','sfsg','fdsfs');
	my $b1 = qw(bsf sfsg fdsfs);
	print $b,"\n";
	print $b1,"\n";

	my $elements = my @arr = localtime;
	my $elements1 = (my @arr = localtime);
	print $elements1,"\n";
	
	#!!!!!!!! a list assignment in scalar context returns the number of elements on the righthand side !!!!!!!!!
	
	my $elemets2 = () = localtime;  # 非常简化!!!!!!!!!!!!!!!,这种写法被称为山羊操作符(goatse operator)
	print $elemets2,"\n";

	#当你想count全局匹配的个数，或者split产生的元素个数，可以使用山羊操作符
	# my $count =()= m//g;
	# my $count =()= split //,$line;

	#不要用undef创建空的数组和哈希
	my @test = (); # empty array
	my %test = (); # empty hash


### slice is shortcut way of accessing several elements at once 
	#!!!!!!! 含有一个元素的list也是列表，不是scalar value !!!!!!!!!!!!!!!!!!

	my @giant = qw(fee fie foe fun);
	#my @quene = ($giant[1],$giant[2]);
	
	# use slice is very easy way to get several elements at once
	my @quene = @giant[1,2];
	my $c = @giant[1]; #虽然可以运行，但是会有warning,因为等号两边是列表上下文，取单个元素最好用$giant[1]
	print "@quene\n";
	print $c,"\n";
	
	# slice can easy to swap two elements
	my @num = (1..10);
	@num[1,2]=@num[2,1];
	print "@num\n";

	my @uid = (5,6,2,3,8);
	my @name = qw(chenzhi chenchen haha liuxiaoqiang hamda);
	@name = @name[sort {$uid[$a] <=> $uid[$b]} 0..$#name];
	for (my $i=0;$i<@name;++$i) {
		print $name[$i],"\n";
	
	}
	#print "@name\n"

	#!!!! 使用切片可以将我们平时的操作进行简化，

# （）可以强制列表上下文
	my ($n) = ("a","b","c");
	my $bb = ("a","b","c"); #列表上下文，得到的是c
	print $n,"\n";

# void context(没有save the results to variable)
	#会出现warning信息
	1+2; # 报错，会进行赋值




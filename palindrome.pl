#1051432
#!usr/etc/perl

$str=$ARGV[0];
$len=length($str);
$check=1;
@val=split(undef,$str);
for(0..$len){
    if($val[$_] ne $val[$len-$_-1]){$check=0;}
    last if $_==$len-$_-1 || $_+1==$len-$_-1 || $len==1;
}
if($check==1){print"Palindrome!\n";}
else{print"Not palindrome!\n";}

#!usr/etc/perl
$input = $ARGV[0];
@data = split(',',$input);
$len=0;
foreach my $val(@data){
  $len++;
}
&quicksort(0, $len-1);
for $ii (0..$len){
  print $data[$ii]," ";
}
print "\n";

sub quicksort {
  if($_[0] < $_[1]){
    my $i = $_[0];
    my $j = $_[1]+1;
    my $pivot = $data[$i];
    do{
      do{$i++;}while($data[$i] < $pivot);
      do{$j--;}while($data[$j] > $pivot);
      if($i < $j){
	($data[$i], $data[$j]) = ($data[$j], $data[$i]);
      }
    }while($i < $j);
    ($data[$_[0]], $data[$j]) = ($data[$j], $data[$_[0]]);
    &quicksort($_[0], $j-1);
    &quicksort($j+1, $_[1]);
    }
}

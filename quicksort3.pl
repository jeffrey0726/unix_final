#!usr/etc/perl
$input = $ARGV[0];
@data = split(',',$input);
$len=0;
foreach my $val(@data){
  print $val," ";
  $len++;
}
print "length(input):",$len,"\n";
&quicksort(0, $len);
for $ii (0..$len){
  print $data[$ii]," ";
}
print "\n";

sub quicksort {
  if($_[0] < $_[1]){
    my $i = $_[0];
    my $j = $_[1];
    my $pivot = $data[$i];
    print "pivot:",$pivot,"\n";
    do{
      #do{$i++;
	#print "data[i]:",$data[$i],"\n";
	#if($data[$i] < $pivot){print"true\n";}
	#last if $i==30;
	#}while($data[$i] < $pivot);
      $i++;
      for $i ($i..$_[1]){
	print "i:",$i,"\n";
	print "data[i]:",$data[$i],"\n";
	last if $data[$i] >= $pivot;
	}
      print"-------j----------\n";
      do{$j--;
	print "data[j]:",$data[$j],"\n";
	print "j:",$j,"\n";
	}while($data[$j] > $pivot);
      print"data[j]:",$data[$j],"\n";
      if($i < $j){
	($data[$i], $data[$j]) = ($data[$j], $data[$i]);
      }
    }while($i < $j);
    print "i:",$i,"\n";
    print "j:",$j,"\n";
      ($data[$_[0]], $data[$j]) = ($data[$j], $data[$_[0]]);
      &quicksort($_[0], $j-1);
      &quicksort($j+1, $_[1]);
    }
}

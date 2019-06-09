#!usr/bin/perl
sub splt{
  $_ = shift;
  my @cutline = split(' ',$_);
  for my $val (0..scalar(@cutline)-1){
    while($cutline[$val] =~ /(.*)([^\d\w_%&\$@])(.*)/){
      if($3){
	$result[$cnt] = $3;
	$cnt++;
      }
      if($2){
	$result[$cnt] = $2;
	$cnt++;
      }
      $cutline[$val] = $1;
    }
    if($cutline[$val]){
      $result[$cnt] = $cutline[$val];
      $cnt++;
    }
  }
}
sub spltstr{
  $cnt = 0;
  $_ = shift;
  @result=();
  my $str = $_;
  while($str =~ /(.*)([\"\'].*[\"\'])(.*)/){
    $save2 = $2;
    $save1 = $1;
    if($3){
      &splt($3);
    }
    if($save2){
      $result[$cnt] = $save2;
      $cnt++;
    }
    $str = $save1; 
  }
  &splt($str);
  $cnt = 0;
  return @result;
}
while(chomp($line = <stdin>)){
  @linesplt = ();
  #@linesplt = &spltstr($line);
  
  if($line =~ /^["'].*["']$/){
    print "data2weight[_[0]] = 3\n";
  }
  elsif($line =~ /[^\d\w_%&\$@]/){
    print "data2weight[_[0]] = 1\n";
  }
  else{
    print "data2weight[_[0]] = 2\n";
  }
  #foreach my $val (@linesplt){
   # print $val,"\n";
  #}
}

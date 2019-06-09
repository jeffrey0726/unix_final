#!usr/bin/perl
use Term::ANSIColor;

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

opendir(DIR,'./') or die "$!";
@files = grep{ /\.pl$/i } readdir(DIR);
$filesize = scalar(@files);
for $i (0..$filesize-1){
  for $j (0..$filesize-1){
    $size1=0;
    $size2=0;
    @data1=();
    @data1cnt=();
    @data2=();
    @data2cnt=();
    next if $i >= $j;
    #next if $files[$i]ne"test.pl" || $files[$j]ne"final.pl";
    open(FILE, $files[$i]);
    while( defined( $line = <FILE> )){
      my @linesplt=();
      @linesplt = spltstr($line);
      my $check = 0;
      for my $ii (0..scalar(@linesplt)-1){
	my $len = $size1-1;
	for my $jj (0..$len){
	  if($data1[$jj] eq $linesplt[$ii]){
	    $data1cnt[$jj] = $data1cnt[$jj]+ 1;
	    $check = 1;
	  }
	}
	if($check == 0){
	  $data1[$size1] = $linesplt[$ii];
	  $data1cnt[$size1] = 1;
	  $size1++;
	}
	else{ $check = 0; }
      }
    }
    open(FILE, $files[$j]);
    while( defined( $line = <FILE> )){
      my @linesplt=();
      @linesplt = spltstr($line);
      my $check = 0;
      for my $ii (0..scalar(@linesplt)-1){	  
	my $len = $size2-1;
	for my $jj (0..$len){
	  if($data2[$jj] eq $linesplt[$ii]){
	    $data2cnt[$jj] = $data2cnt[$jj] + 1;
	    $check = 1;
	  }
	}
	if($check == 0){
	  $data2[$size2] = $linesplt[$ii];
	  $data2cnt[$size2] = 1;
	  $size2++;
	}
	else{ $check = 0; }
      }
    }
    $common = 0;
    $total = 0;
    for my $v1 (0..$size1-1){
      for my $v2 (0..$size2-1){
	if($data1[$v1] eq $data2[$v2]){
	  if($data1cnt[$v1] <= $data2cnt[$v2]){
	    $common += $data1cnt[$v1]*2;
	  }
	  else{
	    $common += $data2cnt[$v2]*2;
	  }
	}
      }
    }
    foreach my $val(0..$size1-1){
      $total += $data1cnt[$val];
    }
    foreach my $val(0..$size2-1){
      $total += $data2cnt[$val];
    }
    #print "total:", $total,"\n";
    #print "common:", $common, "\n";
    $similarity = int(($common/$total)*100);
    if($similarity >= 30){
      print color 'bold blue';
      print "The similarity of ", $files[$i], " and ", $files[$j], " is ", $similarity, "% : Plagiarism!\n\n";
      print color 'reset';
    }
    else{
      print "The similarity of ", $files[$i], " and ", $files[$j], " is ", $similarity, "% : Not plagiarism!\n\n";
    }
  }
}

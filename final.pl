#!usr/etc/perl
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
    open(FILE, $files[$i]);
    $first = "true";
    $n = 0;
    $cnt = 0;
    while( defined( $line = <FILE> )){
      if($first eq "true"){
	$n = 1;
	$first = "false";
      }
      else{ $n = 0;}
      my @linesplt = split(' ',$line);
      my $check = 0;
      if($size1 == 0){
	$data1[0] = $linesplt[0];
	$data1cnt[0] = 1;
	$size1++;
      }
      for my $ii ($n..scalar(@linesplt)-1){
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
    $first = "true";
    $m = 0;
    while( defined( $line = <FILE> )){
      if($first eq "true"){
	$m = 1;
	$first = "false";
      }
      else{ $m = 0;}
      my @linesplt = split(' ',$line);
      my $check = 0;
      if($size2 == 0){
	$data2[0] = $linesplt[0];
	$data2cnt[0] = 1;
	$size2++;
      }
      for my $ii ($m..scalar(@linesplt)-1){	  
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
	  if($data1cnt[$v1] < $data1cnt[$v2]){
	    $common += $data1cnt[$v1]*2;
	  }
	  else{
	    $common += $data2cnt[$v2]*2;
	  }
	}
      }
    }
    $total1 = 0;
    $total2 = 0;
    foreach (0..$size1-1){
      $total1 += $data1cnt[$_];
    }
    foreach (0..$size2-1){
      $total2 += $data2cnt[$_];
    }
    $total = $total1 + $total2;
    #print "total:", $total,"\n";
    #print "common:", $common, "\n";
    $similarity = int(($common/$total)*100);
    print "The similarity of ", $files[$i], " and ", $files[$j], " is ", $similarity, "%\n";
    if($similarity >= 30){
      print "Plagiarism!\n";
    }
    else{
      print "Not Plagiarism!\n";
    }
  }
}

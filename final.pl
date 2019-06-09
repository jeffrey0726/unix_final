#!usr/bin/perl -w
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
sub match1{
  if($_[1] =~ /^["'].*["']$/){
    $data1weight[$_[0]] = $weight[0];
  }
  elsif($_[1] =~ /[^\d\w_%&\$@]/){
    $data1weight[$_[0]] = $weight[1];
  }
  else{
    $data1weight[$_[0]] = $weight[2];
  }
}
sub match2{
  if($_[1] =~ /^["'].*["']$/){
    $data2weight[$_[0]] = $weight[0];
  }
  elsif($_[1] =~ /[^\d\w_%&\$@]/){
    $data2weight[$_[0]] = $weight[1];
  }
  else{
    $data2weight[$_[0]] = $weight[2];
  }
}

opendir(DIR,'./') or die "$!";
@files = grep{ /\.pl$/i } readdir(DIR);
$filesize = scalar(@files);
@weight = (3, 1, 2);
$first = 0;
if(!$ARGV[0]){
  print "-p : Show whether plagiarism\n";
  print "-s : Show similar percentage\n";
  print "-a : Show all\n";
  print "-i : add common file\n";
  print "-w : change weight\n";
}
else{
for $i (0..$filesize-1){
  for $j (0..$filesize-1){
    if($ARGV[0] eq "-w" && $first == 0){
      print "class1(string): ";
      chomp($weight[0] = <stdin>);
      print "class2(parentheses, sign): ";
      chomp($weight[1] = <stdin>);
      print "class3(varable, function, type, array): ";
      chomp($weight[2] = <stdin>);
      $first = 1;
    }
    $size1=0;
    $size2=0;
    @data1=();
    @data1cnt=();
    @data2=();
    @data2cnt=();
    @data1weight=();
    @data2weight=();
    if($ARGV[0] eq"-i"){
      next if $i > $j;
    }
    else{
      next if $i >= $j;
    }
    open(FILE, $files[$i]);
    while( defined( $line = <FILE> )){
      my @linesplt=();
      @linesplt = spltstr($line);
      my $check = 0;
      for my $ii (0..scalar(@linesplt)-1){
	for my $jj (0..$size1-1){
	  if($data1[$jj] eq $linesplt[$ii]){
	    $data1cnt[$jj] = $data1cnt[$jj]+ 1;
	    $check = 1;
	  }
	}
	if($check == 0){
	  $data1[$size1] = $linesplt[$ii];
	  $data1cnt[$size1] = 1;
          &match1($size1,$linesplt[$ii]);
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
	for my $jj (0..$size2-1){
	  if($data2[$jj] eq $linesplt[$ii]){
	    $data2cnt[$jj] = $data2cnt[$jj] + 1;
	    $check = 1;
	  }
	}
	if($check == 0){
	  $data2[$size2] = $linesplt[$ii];
	  $data2cnt[$size2] = 1;
	  &match2($size2,$linesplt[$ii]);
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
	    $common += $data1cnt[$v1]*$data1weight[$v1];
	  }
	  else{
	    $common += $data2cnt[$v2]*$data2weight[$v2];
	  }
	}
      }
    }
    foreach my $val(0..$size1-1){
      $total += $data1cnt[$val]*$data1weight[$val];
    }
    foreach my $val(0..$size2-1){
      $total += $data2cnt[$val]*$data2weight[$val];
    }
<<<<<<< HEAD
    $total = $total - $common;
=======
    #print "total:", $total,"\n";
    #print "common:", $common, "\n";
>>>>>>> 6e740f0b7daf622515e2e5a645d93e945f75e39b
    $similarity = int(($common/$total)*100);
    if($ARGV[0] eq "-p" ){
    	if($similarity >= 30){
          print color 'bold blue';
<<<<<<< HEAD
          print "File ",$files[$i], " and ", $files[$j], "is Plagiarism!\n\n";
          print color 'reset';
      }
       else{
          print "File ",$files[$i], " and ", $files[$j], "is not Plagiarism!\n\n";
=======
          print "Plagiarism!\n\n";
          print color 'reset';
      }
       else{
          print "Not plagiarism!\n\n";
>>>>>>> 6e740f0b7daf622515e2e5a645d93e945f75e39b
      }
    }
   
    elsif($ARGV[0] eq "-s"){
	if($similarity >= 30){
           print color 'bold blue';
<<<<<<< HEAD
	   print "The similarity of ", $files[$i], " and ", $files[$j] , " is " , $similarity , "%\n\n";
           print color 'reset';
        }
        else{
	  print "The similarity of ", $files[$i], " and ", $files[$j] , " is " , $similarity , "%\n\n";
=======
	   print "The similarity of ", $files[$i], " and ", $files[$j] , "is" , $similarity , "%\n";
           print color 'reset';
        }
        else{
	  print "The similarity of ", $files[$i], " and ", $files[$j] , "is" , $similarity , "%\n";
>>>>>>> 6e740f0b7daf622515e2e5a645d93e945f75e39b
	}
    }

    elsif($ARGV[0] eq "-a" || $ARGV[0] eq "-i" || $ARGV[0] eq "-w"){
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
  }
}

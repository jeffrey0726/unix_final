#!usr/etc/perl
open(FILE, 'census.txt') or die "$!";
$firstLine = "true";
print "county name\tpopulation per mile\twater percentage\n";
while(defined($line = <FILE>)){
  @lineSplt = split('\t', $line);
  $density = $lineSplt[1]/($lineSplt[2]+$lineSplt[3]);
  $water = ($lineSplt[2]/($lineSplt[2]+$lineSplt[3]))*100;
  if($firstLine eq "true"){
    $highDensity = $density;
    $lowDensity = $density;
    $highWater = $water;
    $lowWater = $water;
    $highDensityName = $lineSplt[0];
    $lowDensityName = $lineSplt[0];
    $highWaterName = $lineSplt[0];
    $lowWaterName = $lineSplt[0];
    $firstLine = "false";
  }
  else{
    if($density > $highDensity){
      $highDensity = $density;
      $highDensityName = $lineSplt[0];
    }
    elsif($density < $lowDensity){
      $lowDensity = $density;
      $lowDensityName = $lineSplt[0];
    }
    if($water > $highWater){
      $highWater = $water;
      $highWaterName = $lineSplt[0];
    }
    elsif($water < $lowWater){
      $lowWater = $water;
      $lowWaterName = $lineSplt[0];
    }
  }
  print $lineSplt[0],"\t",$density,"\t",int($water),"%\t","\n";
}
print "\n";
print "Hightest population density:",$highDensityName,"\n";
print "Lowest population density:",$lowDensityName,"\n";
print "Hightest percentage of water:",$highWaterName,"\n";
print "Lowest percentage of water:",$lowWaterName,"\n";

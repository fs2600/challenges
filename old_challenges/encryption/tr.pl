#!/usr/bin/perl
#shyft 2008

#transliteration is wonderful

if($ARGV[0] eq "-easter_eggs") #bonus points anyone?
{
	system("cls");
	print "YOU SIR OR MADDAM ARE CLEVER\n\n\t\tYou get additional points.\n\t\tI was thinking something like 5 points\n\t\tJust go to me and mention this message\nThanks,\n-shyft\n";
	exit();
}
if($ARGV[0] eq "-h") #help page
{
	print "Usage: tr <file_to_encode>\n";
	exit();
}
if($ARGV[0] ne "-d") #whats gonna piss you off is that THIS IS the solution see bottom ~line 51
{
	if( $ARGV[0] ne "")
		{
			$file = $ARGV[0];
		}else
		{	
			print "Usage: tr <file_to_encode>\n";
			exit();
		}
		
	print "encoding \noutput to 'encoded.txt'\n";
	open(FILE,"<$file");
	open(NEW,">encoded.txt");

	while(<FILE>)
	{
		
	
		$salt = int(rand(9));
		$_ =~ tr/a-z/n-za-m/;
		$_ =~ tr/ /-/;
		@temp = split(//);
		foreach $char (@temp)
		{
			$salt = int(rand(9));
			print NEW "$char$salt:";
		} 

	}	
}else{
		if( $ARGV[1] ne "")#this is the actual decoding algorithm
			{
				$file = $ARGV[1];
			}else
			{	
				print "dont forget your files\n";
				exit();
			}
	print "decoding \noutput to 'decoded.txt'\n";
	open(FILE,"<$file");
	open(NEW,">decoded.txt");

	while(<FILE>)
	{
		chomp($_);
		$_ =~ tr/n-za-m/a-mn-z/;
		$_ =~ tr/-/ /;
		$_ =~ tr/0-9//d;
		$_ =~ tr/://d;
		print NEW $_;
	}
}
close(FILE);
close(NEW);	

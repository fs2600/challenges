#!/usr/bin/perl
#ft smith 2600 programming challenge
# the given source file contains teh md5 of each word in the string "the password is password"
#8fc42c6ddf9966db3b09e84365034357
#5f4dcc3b5aa765d61d8327deb882cf99
#a2a551a6458a8de22446cc76d639a9e9
#5f4dcc3b5aa765d61d8327deb882cf99

use Digest::MD5 "md5_hex";
open(OFILE,">rt.dat");
open(SFILE,"<wordlist.txt");

@words = <SFILE>;
$count = scalar(@words);
print  "$count words hashed\n";
foreach $data (@words)
{
	chomp($data);
	$digest = md5_hex($data);
	print OFILE "$digest\n";
}
close OFILE;
close SFILE;

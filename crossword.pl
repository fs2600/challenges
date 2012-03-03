#!/usr/bin/perl
#crossword helper

$str = $ARGV[0];

if($str eq "")
{
    print "Help find words of a certain length and order to solve crossword puzzles.\n\tUsage: crossword.pl PATTERN [wordlist]\n\n\tPATTERN \tthe letters you know. For letters you don't know place a period. This should be the length of the whole word.\n\tExample: ./crossword.pl .at.w..\n\t1: gateway\n";
}

if($ARGV[1] ne "")
{
    $wordlist = "$ARGV[1]";
}else
{
    $wordlist = "/home/shyft/stuff/wordlists/wordlist.txt";
}
#print "$str\n".length($str)."\n";

open(F, $wordlist);

$i=1;
while($l = <F>)
{
    chomp($l);
    #$t = "$l =~ m/$str/";
    #print "$t\n";
    
    if( $l =~ m/^$str$/ )
    {
        if(length($l) == length($str))
        {
            print "$i: ";
            $i++;
            print "$l\n";
        }
    }
}

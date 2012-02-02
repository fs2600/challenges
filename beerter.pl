#!/usr/bin/perl
#scrape twitter for beer
#02FEB12
use WWW::Mechanize;
use Getopt::Long;

$mech = WWW::Mechanize->new(); #global object
$mech->agent('Mozilla/5.0 (Ubuntu; X11; Linux x86_64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1'); #so that the script is truly the browser


$url = "https://mobile.twitter.com/session/new";

$username = '';
$password = '';


GetOptions("user=s"=>\$username, "pass=s"=>\$password);

$mech->get($url);
$mech->form_number(1);
$mech->field("username", $username);
$mech->field("password", $password);
$mech->click();

$mech->get("https://mobile.twitter.com/search/beer");
$content = $mech->text();

#$content =~ s/[^[:ascii:]]+//g;
#$content =~ s/<div/\n\t<div/g;
#$content =~ s/<.+?>//g;
# 

$content =~ s/ ago/_ago \n/g;
$content =~ s/Refresh results/ \n/g;
$content =~ s/\s{3,}/\n/g;

@tmp = split("\n", $content);
foreach $line (@tmp)
{
    if( $line =~ m/beer/i)
    {
        print "$line\n----------------------\n";
    }
}


#print $content . "\n";

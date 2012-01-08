#!/usr/bin/perl
#facebook scraper
#shyft
#07JAN12
use WWW::Mechanize;
my $mech = WWW::Mechanize->new();


#use mobile site so that there is less to parse through
$url = "http://m.facebook.com/";
#change to your information
$username = '<your email here>';
$password = '<your pass here>';


if($ARGV[0] eq "-h") #help
{
    print "facebook scraper\n\t./fbscrape.pl --scrape your stories\n\t./fbscrape.pl [facebook_id] --scrape a friends pages\n";
    exit();
}
if($ARGV[0] eq "-f") #a friends page
{
    #
}    



$mech = WWW::Mechanize->new();
#$mech->cookie_jar($cookiejar);
#$mech->agent('Mozilla/5.0 (Ubuntu; X11; Linux x86_64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1'); #my firefox user agent

#navigate the login page
$mech->get($url);
$mech->form_number(1);
$mech->field("email", $username);
$mech->field("pass", $password);
$mech->click(); #submit form (login)


#get the page after you've logged in
$dump = $mech->content();

#experiment
#$text = $mech->text(); #returns just text... not formatted... not pretty... not useful for this project, but maybe in the future.

$raw = $dump; #for debugging;

if($dump =~ m/<b>You are trying too often.  Please try again later.<\/b>/)
{
    print "\ngot caught spamming... wait a little bit before trying again\n";
   # exit();
}

#get the content of your stories <div>
$start_target = '<div id="m_stream_stories">'; #string to search for at the beginning
$end_target = "<span>See More Stories</span>"; #string to search for at the end

$start = index($raw, $start_target); #offset of start
$end = index($raw, $end_target); #offset of end
$len = $end - $start; #content lies between these offsets

#print "s $start e $end l $len\n"; #debugging

$raw = substr($raw,$start,$len); #get just the contents of the <body> tag

#--------------------------------------

$raw =~ s/[^[:ascii:]]+//g; #remove non-ascii characters. solves "wide character print error; looks better without this

#render html-escaped shit properly
$raw =~ s/&#039;/'/g; 
$raw =~ s/&qout;/"/g;
$raw =~ s/&nbsp;/ /g;
$raw =~ s/>/> /g;
$raw =~ s/&gt;/>/g;
$raw =~ s/<div/\n\t<div/g; #keep the divs in place

#now remove all remaining html tags but kinda keep formatting
$raw =~ s/<.+?>//g; 

#show it. grep it. love it. Welcome to Ball-Mart.
print "$raw\n";

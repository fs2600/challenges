#!/usr/bin/perl
#facebook scraper
#shyft
#07JAN12
use WWW::Mechanize;
use Getopt::Long;
$mech = WWW::Mechanize->new();

binmode STDOUT, ":utf8";


#use mobile site so that there is less to parse through
$url = "http://m.facebook.com/";
#change to your information
$username = '';
$password = '';
$help = '';
$friend = '';

GetOptions("user=s"=>\$username, "pass=s"=>\$password, "friend=s"=>\$friend, "url=s"=>\$url, "newToken"=>\$newToken, "help"=>\$help);

if($help || $username eq "" || $password eq "") #help
{
    print "
    facebook scraper
    ./fbscrape.pl --user <username> --pass <password> [--friend <url for friends photo page>]
    
";
    exit();
}

#this bit snatches a new token, which is invalidated after about two hours
if($newToken && $username ne "" & $password ne "") 
{
    $mech->agent('Mozilla/5.0 (Ubuntu; X11; Linux x86_64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1');
    
    $url = "https://graph.facebook.com";
    $mech->get($url);
    $mech->form_number(1);
    $mech->field("email", $username);
    $mech->field("pass", $password);
    $mech->click(); #submit form (login)

    $dump = $mech->content();
    
    @tmp = split("access_token=", $dump);
    @tmp2 = split("\">https:\/\/graph.facebook.com\/367501354973<\/a> ", $tmp[1]);
    print "$tmp2[0]\n";
    exit();
}

#$mech->cookie_jar($cookiejar);
$mech->agent('Mozilla/5.0 (Ubuntu; X11; Linux x86_64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1'); #my firefox user agent so that the script gets the same code as the browser
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
    print "\ngot caught spamming... wait a little bit (an hour is what it took my account to unlock) before trying again\n";
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

#$raw =~ s/[^[:ascii:]]+//g; #remove non-ascii characters. solves "wide character print error; looks better without this

#render html-escaped shit properly
$raw =~ s/&#039;/'/g; 
$raw =~ s/&qout;/"/g;
$raw =~ s/&nbsp;/ /g;
$raw =~ s/&amp;/&/g;
$raw =~ s/>/> /g;
$raw =~ s/&gt;/>/g;
$raw =~ s/<div/\n\t<div/g; #keep the divs in place

#now remove all remaining html tags but kinda keep formatting
$raw =~ s/<.+?>//g; 

#$raw =~ s/<div class="msg">(.+?)<\/div>/<\/post>\n<post>\n/g;

#show it. grep it. love it. Welcome to Ball-Mart.
print "$raw\n";


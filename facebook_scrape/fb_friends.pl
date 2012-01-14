#!/usr/bin/perl
#fb_friends.pl
#lists facebook friends by name or id given a url to their page
#08JAN12
#shyft

use WWW::Mechanize;
use Getopt::Long;
use List::MoreUtils "uniq";
$mech = WWW::Mechanize->new(); #global object
$mech->agent('Mozilla/5.0 (Ubuntu; X11; Linux x86_64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1'); #so that the script is truly the browser

$url = "http://www.facebook.com/";

$username = '';
$password = '';
$help = '';
$friend = '';

@ids = {}; #global var for IDs

GetOptions("user=s"=>\$username, "pass=s"=>\$password, "friend=s"=>\$friend, "url=s"=>\$url, "help"=>\$help, "getNameByID=i"=>\$getNameByID, "dumpIDs"=>\$dumpIDs, "dumpFriends"=>\$dumpFriends);

if($help || $username eq "" || $password eq "" )
{
    printHelp();
}

login(); #do this before any function does its work. this should help with the multiple login issue

if($dumpIDs)
{
    dumpIDs();
}elsif($getNameByID ne "")
{
    getNameByID($getNameByID);
}elsif($dumpFriends)
{   
    dumpIDs();
    dumpFriends();
}else
{
    printHelp();
}

sub dumpIDs()
{
    login(); 
    $raw = $mech->content();
    
    $raw =~ s/\\//g;
    #get your facebook profile id
    @tmp = split(',"userID":"', $raw); 
    @tmp2 = split('","name":"' , $tmp[1]);
    $my_id = $tmp2[0]; #this should be it
    
    $url = "http://facebook.com/profile.php?id=$my_id&sk=friends"; #it even traverses the 302 redirect nicely
    
    #have $mech jump to my page of friends (friends page)
    $mech->get($url);
    $raw = $mech->content();


    $raw =~ s/[^[:ascii:]]+//g;
    
    @ids = ($raw =~ m/profile\.php\?id=(\d+)/g); #get the ids and save them in array

    @ids = uniq(@ids);
    
    if($dumpIDs) #if this flag was set on the commandline, do this. 
    {
        foreach $line (@ids)
        {
            print "$line\n";
        }
    }
}

sub getNameByID
{
    #needed to recreate the $mech object to start fresh on the page. 
    $url = "http://www.facebook.com/profile.php?id=".$_[0];
    #print $url;
    #$mech = WWW::Mechanize->new(); 
    $mech->get($url);
    #$mech->form_number(1);
    #$mech->field("email", $username);
    #$mech->field("pass", $password);
    #$mech->click(); #submit form (login)
    $raw = $mech->content();

    @tmp = split("<title>", $raw);
    @tmp2 = split("</title>" , $tmp[1]);
    $name = $tmp2[0];
    if($dumpFriends)
    {
        print "$name\n";
    }else
    {
        return $name;
    }
}

sub dumpFriends()
{
    
    foreach $id (@ids)
    {
        #print getNameByID($id);
    }
}

sub login()
{
    #navigate the login page
    $mech->agent('Mozilla/5.0 (Ubuntu; X11; Linux x86_64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1');
    $mech->get($url);
    $mech->form_number(1);
    $mech->field("email", $username);
    $mech->field("pass", $password);
    $mech->click(); #submit form (login)
    $safe = $mech->text();
    if($safe =~ m/You are trying too often/)
    {
        print "\ngot caught spamming... wait a little bit (an hour is what it took my account to unlock) before trying again\n";
        exit();
    }
}

sub printHelp()
{
    print "
    find Facebook friends
    ./fb_friends.pl --user=username --pass=password [option]
    
    options:
    --getNameByID=<id>  - returns the name associated with the ID
    --dumpIDs           - dump all IDs on your page
    --dumpFriends       - dump all of your friends names
";
    exit();
    }

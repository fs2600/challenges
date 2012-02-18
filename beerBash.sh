#!/bin/sh
#even simpler twitter scraper
#02FEB12 
#shyft
#twitter lets you search without authentication
#mobile has less code to sift through
curl -s mobile.twitter.com/search/beer | html2text


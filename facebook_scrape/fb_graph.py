#!/usr/bin/env python

import urllib
import json
import sys
import subprocess

base_url = "https://graph.facebook.com/"

global target
global uname
global pword
global access_token #tokens are only good for about two hours
global limit 

limit = "50"
target = "me/home"

def fetchToken():
    global access_token
    access_token = subprocess.check_output(["./fbscrape.pl", "--user=<uname>", "--pass=<pass>", "--newToken"])
    access_token = access_token.rstrip()
    
for opt in sys.argv:
    if opt == "-n":
        fetchToken()
    elif opt == "-t":
        off = sys.argv.index("-t")
        target = sys.argv[off+1]
        print "using target:" + target
    elif opt == "-l":
        off = sys.argv.index("-l")
        limit = sys.argv[off+1]
        print "using limit:" + limit
    elif opt == "-u":   
        off = sys.argv.index("-u")
        uname = sys.argv[off+1]
        pword = sys.argv[off+2]
        print "using account " + uname

url = base_url + target + "?access_token=" + access_token + "&limit=" + limit

print url

r = urllib.urlopen(url)

content = r.read()

j = json.loads(content) #can be any .read() -able object

#structure 
#j = JSON object as a dict
#   j["data"]
#       content = j["data"][element of data as a dict(id,name,etc.)]  
#
#j['data'].keys() to explore

if "error" in j.keys():
    print "An error occurred. Most likely a bad token..."
    exit()

#for el in j['data']:
for i in range(0,len(j['data'])):
    try:
        s = (j['data'][i]['from']['name']+ " - "+ j['data'][i]['message'])
        s = s.encode('utf-8')
        print s,"\n------------\n"
    except KeyError:
        print "error"


#print content


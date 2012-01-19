#!/usr/bin/env python

import urllib
import json



base_url = "https://graph.facebook.com/"

target = "me/home"

#got this token at 8:18 on 18JAN2012
#access_token = "?access_token=AAAAAAITEghMBALoOdEBOHMie8dbRPKnqJpPHXQ4qZBShRaXy37P0851LU6ginGDZAMBQuqEW2j34CZCMUsyw6SoVltpWBE1gbTwvZAbf7ayPNe4oZB68b" 
#expired at Wed Jan 18 22:00:00 


limit = "&limit=50"

url = base_url + target + access_token + limit


r = urllib.urlopen(url)

content = r.read()

j = json.loads(content) #can be any .read() -able object

#structure 
#j = JSON object as a dict
#   j["data"]
#       content = j["data"][element of data as a dict(id,name,etc.)]  
#
#j['data'].keys() to explore




for el in j['data']:
    for i in range(0,len(j['data'])):
        try:
            s = (j['data'][i]['from']['name']+ " - "+ j['data'][i]['message'])
            s = s.encode('utf-8')
            print s,"------------\n"
        except KeyError:
            break
    
    


#print content


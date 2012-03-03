#!/usr/bin/env python

#returns every permutation of a given string
#shyft
#17FEB12
import itertools
import sys

string = sys.argv[1]
for s in itertools.permutations(string):
    print "".join(s)

    
#rotate    
#for i in range(0,len(string)):
#    print string
#    string=string[1:]+string[0]


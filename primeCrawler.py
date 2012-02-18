#!/usr/bin/env python

#builds a list of prime numbers that are a sum of that number of consecutive elements in the array. 
#for instance 
#[2,3,5,7,11,13,17,19,23]
#first element is 2 so we are looking for a prime number that is the sum of 2 consecutive prime numbers; sliding through the list we see that 2+3 = 5 so we add the number 5 to the output and continue looking for 2 consecutive numbers whos sum is prime.
#the second element is 3 so wea re looking for a prime number that is the sum of 3 consecutive prime numbers; sliding through the array we see that 5+7+11 = 23 so we add that number to the output and continue our search. 
#continue this for all prime numbers in the array.
#I'm convinced that a pattern will emerge from this... I am sure to be wrong.

#SIMPSONS DID IT!!!
#http://oeis.org/search?q=23%2C31%2C41%2C59%2C71%2C83%2C97&sort=&language=english&go=Search

#15FEB12
#shyft

is_prime = 100000000 * [True]
primes = []
for p in range(2,10000):
    if is_prime[p]:
        primes.append(p)
        for i in range(2*p,10000,p):
            is_prime[i] = False

print primes
exit()

np = []

for currPrime in primes:
    print "begin of", currPrime
    pstr=""
    trigger = 0
    for j in range(0, currPrime):
        if(j == currPrime-1):
            pstr+="primes[i+"+str(j)+"] "
        else:
            pstr+="primes[i+"+str(j)+"] + "
    #print pstr
    for i in range(0,len(primes)):
        try:
            if(eval(pstr)) in primes:
            	print eval(pstr)
            	if(trigger == 0):
                	np.append(currPrime)
                	trigger == 1
        except IndexError:
            break
    print "end of ",currPrime

print set(np)




